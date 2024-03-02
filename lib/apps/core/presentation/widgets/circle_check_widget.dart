import 'package:flutter/material.dart';
import 'package:todo/configs/ui_configs.dart';

class CircleCheck extends StatelessWidget {
  final bool isChecked;

  const CircleCheck({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SpacingConfigs.spacing4_5,
      height: SpacingConfigs.spacing4_5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? ColorsConfigs.primary : Colors.transparent,
        border: const Border.fromBorderSide(BorderSide(color: ColorsConfigs.primary, width: 3))
      ),
      child: isChecked
          ? const Icon(Icons.check, color: ColorsConfigs.light, size: SpacingConfigs.spacing3,)
          : null,
    );
  }
}
