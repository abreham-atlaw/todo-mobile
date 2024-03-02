import 'package:flutter/material.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/navigation/bottom_nav_bar.dart';
import 'package:todo/configs/ui_configs.dart';


class TodoAppBottomNavBar extends StatelessWidget{

  final List<List<dynamic>> navItems = [
    ["Home", Icons.dashboard, "/core/home"],
    ["Tasks", Icons.task_alt, "/core/todo/all"],
    ["Profile", Icons.person_outline, "/auth/profile"]
  ];

  TodoAppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
        items: navItems.map(
                (List<dynamic> item) => BottomNavItem(
                icon: item[1] as IconData,
                title: item[0] as String,
                activeColor: ColorsConfigs.light,
                inactiveColor: ColorsConfigs.dark,
                activeBackgroundColor: ColorsConfigs.primary
            )
        ).toList(),
        onItemSelected: (int index){
          RoutingUtils.redirect(navItems[index][2] as String, context);
        }
    );
  }

}

