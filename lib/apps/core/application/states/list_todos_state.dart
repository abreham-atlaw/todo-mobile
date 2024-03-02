

import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/base_state.dart';

class ListTodosState extends AsyncState{

  List<Todo>? todos;

  String? categoryId;
  Category? category;

  ListTodosState({this.categoryId});

  @override
  BaseState newInstance() {
    return ListTodosState(categoryId: categoryId);
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as ListTodosState).todos = todos;
    newState.categoryId = categoryId;
    newState.category = category;
  }

}