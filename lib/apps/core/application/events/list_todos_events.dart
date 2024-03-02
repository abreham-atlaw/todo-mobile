

import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/common/async_bloc/async_events.dart';

class ListTodosBaseEvents extends AsyncEvent{

}

class CompleteTaskEvent extends ListTodosBaseEvents{
  final Todo todo;
  final bool complete;

  CompleteTaskEvent(this.todo, this.complete);
}