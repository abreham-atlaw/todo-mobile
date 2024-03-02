

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/apps/core/application/events/home_events.dart';
import 'package:todo/apps/core/application/states/home_state.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/repositories/category_repository.dart';
import 'package:todo/apps/core/data/repositories/todo_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class HomeBloc extends AsyncBloc<HomeState>{

  final _todoRepository = TodoRepository();
  final _authRepository = AuthRepository();
  final _categoryRepository = CategoryRepository();

  HomeBloc(super.initialState){
    on<CompleteTaskEvent>(_handleCompleteTask);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();
    await initializeUser();
    state.categories = await _categoryRepository.getAll();
    state.todayTodos = await _todoRepository.getTodaysTodos();
    state.me = await _authRepository.whoAmI();
    state.categoriesTasksCount = {};
    state.categoriesCompletedCount = {};
    await _getCounts();
  }

  _getCounts() async{
    for(Category category in state.categories!){
      final tasks = await _todoRepository.filterByCategory(category);
      state.categoriesTasksCount![category] = tasks.length;
      state.categoriesCompletedCount![category] = tasks.where((element) => element.isComplete).length;
    }
  }

  initializeUser() async{
    final categories = await _categoryRepository.getAll();
    if(categories.isEmpty){
      for(String categoryName in ["Personal", "Business", "Work", "School"]){
        await _categoryRepository.create(Category(name: categoryName));
      }
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
          await _getCounts();
        }
    );
  }

}