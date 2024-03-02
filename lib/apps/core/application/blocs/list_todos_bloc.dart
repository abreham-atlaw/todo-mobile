

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/core/application/events/list_todos_events.dart';
import 'package:todo/apps/core/application/states/list_todos_state.dart';
import 'package:todo/apps/core/data/repositories/category_repository.dart';
import 'package:todo/apps/core/data/repositories/todo_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class ListTodosBloc extends AsyncBloc<ListTodosState>{

  final _todoRepository = TodoRepository();
  final _categoryRepository = CategoryRepository();

  ListTodosBloc(super.initialState){
    on<CompleteTaskEvent>(_handleCompleteTask);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();

    if(state.categoryId != null){
      state.category = await _categoryRepository.getById(state.categoryId!);
      state.todos = await _todoRepository.filterByCategory(state.category!);
    }
    else{
      state.todos = await _todoRepository.getAll();
    }
  }

  _handleCompleteTask(CompleteTaskEvent event, Emitter emitter) async{
    await asyncCall(
        event, emitter,
            (_, __) async{
          if(event.complete){
            await _todoRepository.completeTodo(event.todo);
          }
          else{
            await _todoRepository.unCompleteTodo(event.todo);
          }
        }
    );
  }
}