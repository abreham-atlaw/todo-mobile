import 'package:flutter/material.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/configs/ui_configs.dart';

class LabeledFormField extends StatelessWidget {
  final Widget inputField;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  const LabeledFormField(
      {required this.inputField,
      required this.label,
      this.fontSize = FontSizeConfigs.size1,
      this.fontWeight = FontWeight.bold,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(
            label,
            fontSize: fontSize,
            fontWeight: fontWeight,
        ),
        const SizedBox(height: SpacingConfigs.spacing1),
        inputField
      ],
    );
  }
}
