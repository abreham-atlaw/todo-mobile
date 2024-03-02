

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/core/application/blocs/list_todos_bloc.dart';
import 'package:todo/apps/core/application/states/list_todos_state.dart';
import 'package:todo/apps/core/presentation/widgets/task_update_banner.dart';
import 'package:todo/apps/core/presentation/widgets/todo_widget.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/headers.dart';
import 'package:todo/configs/ui_configs.dart';

import '../../application/events/list_todos_events.dart';

class ListTodosScreen extends AsyncBlocScreen<ListTodosBloc, ListTodosState>{

  final String? categoryId;

  const ListTodosScreen({super.key, this.categoryId});

  @override
  ListTodosBloc onCreateBloc(ListTodosState state) {
    return ListTodosBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, ListTodosState state) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(SpacingConfigs.spacing4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Heading3((categoryId == null) ? "All Tasks" : "${state.category!.name} Tasks"),
                const SizedBox(height: SpacingConfigs.spacing5,),
              ] + state.todos!.map<Widget>((todo) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: SpacingConfigs.spacing1
                ),
                child: TodoWidget(
                    todo,
                        (){
                      context.read<ListTodosBloc>().add(CompleteTaskEvent(todo, !todo.isComplete));
                    }
                ),
              )).toList(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.all(SpacingConfigs.spacing4),
            child: FloatingActionButton(
              backgroundColor: ColorsConfigs.primary,
              onPressed: () {
                RoutingUtils.redirect("/core/todo/add", context);
              },
              child: const Icon(
                  Icons.add
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: const EdgeInsets.only(top: SpacingConfigs.spacing3),
                child: TaskUpdateBanner(state)
            )
        )
      ],
    );
  }

  @override
  ListTodosState onCreateState() {
    return ListTodosState(categoryId: categoryId);
  }


}