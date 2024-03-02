

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/common/widgets/containers/percentage_container.dart';
import 'package:todo/common/widgets/containers/wrap_container.dart';
import 'package:todo/common/widgets/navigation/link.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/common/widgets/text/headers.dart';
import 'package:todo/configs/ui_configs.dart';

class CategoryWidget extends StatelessWidget{

  final Category category;
  final int tasksCount;
  final int completeCount;

  const CategoryWidget({required this.category, required this.tasksCount, required this.completeCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Link(
      to: "/core/todo/category",
      extra: category.getPK()!,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsConfigs.white,
          borderRadius: BorderRadius.circular(
            SpacingConfigs.spacing3
          )
        ),
        padding: const EdgeInsets.all(SpacingConfigs.spacing3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpacingConfigs.spacing3,),
            BodyText(
              "$tasksCount TASKS",
              fontSize: FontSizeConfigs.size0,
              color: ColorsConfigs.grey,
            ),
            const SizedBox(height: SpacingConfigs.spacing1,),
            Heading3(category.name),
            const SizedBox(height: SpacingConfigs.spacing1,),
            Container(
              width: WidgetSizeConfigs.size3,
              height: 3,
              color: ColorsConfigs.primaryLight,
              child: WrapContainer(
                child: PercentageContainer(
                  width: completeCount.toDouble()/(max(tasksCount.toDouble(), 0.00001)),
                  child: Container(
                    height: 3,
                    color: ColorsConfigs.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}