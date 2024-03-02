

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/core/application/blocs/write_todo_bloc.dart';
import 'package:todo/apps/core/application/events/write_todo_events.dart';
import 'package:todo/apps/core/application/states/write_todo_state.dart';
import 'package:todo/apps/core/presentation/widgets/category_choice_field.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/buttons/async_button.dart';
import 'package:todo/common/widgets/forms/datetime_field_widget.dart';
import 'package:todo/common/widgets/forms/labeled_field.dart';
import 'package:todo/common/widgets/forms/text_field_widget.dart';
import 'package:todo/common/widgets/navigation/link.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/common/widgets/text/errors.dart';
import 'package:todo/common/widgets/text/headers.dart';
import 'package:todo/configs/ui_configs.dart';


class WriteTodoScreen extends AsyncBlocScreen<WriteTodoBloc, WriteTodoState>{

  final String? todoId;

  const WriteTodoScreen({super.key, this.todoId});

  @override
  WriteTodoBloc onCreateBloc(WriteTodoState state) {
    return WriteTodoBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, WriteTodoState state) {
    if(state.asyncStatus == AsyncStatus.done || state.deleteState.asyncStatus == AsyncStatus.done){
      RoutingUtils.redirect("/core/home", context);
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(
          SpacingConfigs.spacing4
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Link(
                      to: "/core/todo/all",
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                    child: Heading3("${(todoId == null)?'Create':'Edit'} Task")),
              ],
            ),
            const SizedBox(height: SpacingConfigs.spacing3,),
            ErrorText(state.error?.message ?? ""),
            ErrorText(state.deleteState.error?.message ?? ""),
            const SizedBox(height: SpacingConfigs.spacing5,),
            LabeledFormField(
              label: "Title",
              inputField: TextFieldWidget(
                iconData: Icons.title,
                field: state.form.title
              ),
            ),
            const SizedBox(height: SpacingConfigs.spacing5,),
            LabeledFormField(
              label: "Description",
              inputField: TextFieldWidget(
                  iconData: Icons.description,
                  field: state.form.description,
              ),
            ),
            const SizedBox(height: SpacingConfigs.spacing5,),
            LabeledFormField(
              label: "Category",
              inputField: CategoryFieldWidget(field: state.form.category, categories: state.categories!)
            ),
            const SizedBox(height: SpacingConfigs.spacing5,),
            LabeledFormField(
              label: "Start Date",
              inputField: DateTimeFieldWidget(field: state.form.startDate),
            ),
            const SizedBox(height: SpacingConfigs.spacing5,),
            LabeledFormField(
              label: "End Date",
              inputField: DateTimeFieldWidget(field: state.form.endDate),
            ),
            const SizedBox(height: SpacingConfigs.spacing6,),
            Align(
              alignment: Alignment.center,
              child: AsyncButton(
                onPressed: (){
                  context.read<WriteTodoBloc>().add(WriteTodoEvent());
                },
                state: state,
                child: SizedBox(
                  width: WidgetSizeConfigs.size2,
                  child: BodyText(
                    (todoId == null)?"CREATE":"SAVE",
                    textAlign: TextAlign.center,
                    color: ColorsConfigs.light,
                  )
                ),
              ),
            ),
            const SizedBox(height: SpacingConfigs.spacing3,),
            Visibility(
              visible: todoId != null,
              child: Align(
                alignment: Alignment.center,
                child: AsyncButton(
                  backgroundColor: ColorsConfigs.danger,
                  onPressed: (){
                    context.read<WriteTodoBloc>().add(DeleteTodoEvent());
                  },
                  state: state.deleteState,
                  child: SizedBox(
                    width: WidgetSizeConfigs.size2,
                    child: BodyText(
                      "DELETE",
                      textAlign: TextAlign.center,
                      color: ColorsConfigs.light,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  WriteTodoState onCreateState() {
    return WriteTodoState(todoId: todoId);
  }

}