

import 'package:appwrite/models.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/base_state.dart';

class HomeState extends AsyncState{

  List<Todo>? todayTodos;
  List<Category>? categories;
  Map<Category, int>? categoriesTasksCount;
  Map<Category, int>? categoriesCompletedCount;
  User? me;


  @override
  BaseState newInstance() {
    return HomeState();
  }
  
  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as HomeState).todayTodos = todayTodos;
    newState.me = me;
    newState.categories = categories;
    newState.categoriesCompletedCount = categoriesCompletedCount;
    newState.categoriesTasksCount = categoriesTasksCount;
  }

}