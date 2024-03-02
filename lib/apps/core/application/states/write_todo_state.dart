

import 'package:todo/apps/core/application/forms/todo_form.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/base_state.dart';

class WriteTodoState extends AsyncState{

  String? todoId; // Only available in edit mode(editing a task). Is null when creating new Task
  Todo? todo;
  var form = TodoForm();
  List<Category>? categories;
  AsyncState deleteState = AsyncState();

  WriteTodoState({this.todoId});
  
  @override
  BaseState newInstance() {
    return WriteTodoState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as WriteTodoState).form = form;
    newState.categories = categories;
    newState.todo = todo;
    newState.todoId = todoId;
  }

}