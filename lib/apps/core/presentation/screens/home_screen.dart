import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/core/application/blocs/home_bloc.dart';
import 'package:todo/apps/core/application/events/home_events.dart';
import 'package:todo/apps/core/application/states/home_state.dart';
import 'package:todo/apps/core/presentation/widgets/category_widget.dart';
import 'package:todo/apps/core/presentation/widgets/task_update_banner.dart';
import 'package:todo/apps/core/presentation/widgets/todo_widget.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/headers.dart';
import 'package:todo/configs/ui_configs.dart';

class HomeScreen extends AsyncBlocScreen<HomeBloc, HomeState>{
  const HomeScreen({super.key});

  @override
  HomeBloc onCreateBloc(HomeState state) {
    return HomeBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, HomeState state) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(SpacingConfigs.spacing4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Heading3("Hello, ${state.me!.name}!"),
                const SizedBox(height: SpacingConfigs.spacing5,),
                Heading5("CATEGORIES", color: ColorsConfigs.grey,),
                const SizedBox(height: SpacingConfigs.spacing4,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categories!.map<Widget>(
                            (category) => CategoryWidget(
                                category: category,
                                tasksCount: state.categoriesTasksCount![category]!,
                                completeCount: state.categoriesCompletedCount![category]!
                            )
                    ).toList(),
                  ),
                ),
                const SizedBox(height: SpacingConfigs.spacing5,),
                Heading5("TODAY'S TASKS", color: ColorsConfigs.grey,),
                const SizedBox(height: SpacingConfigs.spacing4,),
              ] + state.todayTodos!.map<Widget>((todo) => TodoWidget(
                  todo,
                  (){
                    context.read<HomeBloc>().add(CompleteTaskEvent(todo, !todo.isComplete));
                  }
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
  HomeState onCreateState() {
    return HomeState();
  }



}