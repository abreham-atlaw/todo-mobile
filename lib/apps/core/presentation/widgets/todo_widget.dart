


import 'package:flutter/cupertino.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/apps/core/presentation/widgets/circle_check_widget.dart';
import 'package:todo/common/widgets/navigation/link.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/configs/ui_configs.dart';

class TodoWidget extends StatelessWidget{

  final Todo todo;
  final void Function() onCheck;

  const TodoWidget(this.todo, this.onCheck, {super.key});

  @override
  Widget build(BuildContext context) {
    return Link(
      to: "/core/todo/edit",
      extra: todo.getPK()!,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsConfigs.white,
          borderRadius: BorderRadius.circular(SpacingConfigs.spacing3)
        ),
        padding: const EdgeInsets.all(SpacingConfigs.spacing3),
        child: Row(
          children: [
            GestureDetector(
                onTap:  onCheck,
                child: CircleCheck(isChecked: todo.isComplete)
            ),
            const SizedBox(
              width: SpacingConfigs.spacing2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  todo.title,
                  color: (todo.isComplete) ? ColorsConfigs.grey : ColorsConfigs.dark,
                  decoration: (todo.isComplete) ? TextDecoration.lineThrough : TextDecoration.none,
                ),
                BodyText(
                  todo.category!.name,
                  color: ColorsConfigs.primary,
                  fontSize: FontSizeConfigs.size0,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}