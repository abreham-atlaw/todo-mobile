

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/core/application/events/write_todo_events.dart';
import 'package:todo/apps/core/application/forms/todo_form.dart';
import 'package:todo/apps/core/application/states/write_todo_state.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/apps/core/data/repositories/category_repository.dart';
import 'package:todo/apps/core/data/repositories/todo_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class WriteTodoBloc extends AsyncBloc<WriteTodoState>{

  final _repository = TodoRepository();
  final _categoryRepository = CategoryRepository();

  WriteTodoBloc(super.initialState){
    on<WriteTodoEvent>(_handleWriteTodo);
    on<DeleteTodoEvent>(_handleDeleteTodo);
  }

  @override
  onInit() async{
    await super.onInit();
    state.initStatus;
    state.categories = await _categoryRepository.getAll();
    if(state.todoId != null){
      state.todo = await _repository.getById(state.todoId!);
      _mapInstanceToForm(state.todo!, state.form);
    }
  }

  _mapInstanceToForm(Todo instance, TodoForm form){
    form.description.value = instance.description;
    form.title.value = instance.title;
    form.endDate.value = instance.endDate;
    form.startDate.value = instance.startDate;
    form.category.value = instance.category;
  }

  _mapFormToInstance(Todo instance, TodoForm form){
    instance.category = form.category.getValue();
    instance.startDate = form.startDate.getValue()!;
    instance.endDate = form.endDate.getValue()!;
    instance.title = form.title.getValue()!;
    instance.description = form.description.getValue()!;
    instance.categoryId = instance.category!.getPK()!;
  }

  _handleWriteTodo(WriteTodoEvent event, Emitter emitter) async{
    await asyncCall(
        event,
        emitter,
         (_, __) async {
            await state.form.isValid(throwError: true);
            if(state.todoId == null){
              await _repository.create(
                  Todo(
                    categoryId: state.form.category.getValue()!.getPK()!,
                    title: state.form.title.getValue()!,
                    description: state.form.description.getValue()!,
                    startDate: state.form.startDate.getValue()!,
                    endDate: state.form.endDate.getValue()!,
                  )
              );
            }
            else{
              _mapFormToInstance(state.todo!, state.form);
              await _repository.update(state.todo!);
            }

         }
    );
  }

  _handleDeleteTodo(DeleteTodoEvent event, Emitter emitter) async{
    await asyncCall(
        event,
        emitter,
        (_, __) async{
          await _repository.delete(state.todo!);
        },
      stateGetter: (_) => state.deleteState
    );
  }
}