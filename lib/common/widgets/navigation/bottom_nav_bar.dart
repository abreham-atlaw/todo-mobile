import 'package:flutter/material.dart';
import 'package:todo/configs/ui_configs.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final ValueChanged<int> onItemSelected;

  BottomNavBar({required this.items, required this.onItemSelected});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onItemSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacingConfigs.spacing1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.items.map((item) {
          var itemIndex = widget.items.indexOf(item);
          return GestureDetector(
            onTap: () => _updateIndex(itemIndex),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(SpacingConfigs.spacing1)),
                color: (itemIndex == _selectedIndex) ? item.activeBackgroundColor : Colors.transparent,
              ),
              padding: const EdgeInsets.all(SpacingConfigs.spacing2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: itemIndex == _selectedIndex ? item.activeColor : item.inactiveColor,
                  ),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: itemIndex == _selectedIndex ? item.activeColor : item.inactiveColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String title;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeBackgroundColor;

  BottomNavItem({
    required this.icon,
    required this.title,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackgroundColor
  });
}
