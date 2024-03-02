import 'package:flutter/material.dart';
import 'package:todo/configs/ui_configs.dart';

class BaseButton extends ElevatedButton {
  BaseButton(
      {super.key,
      super.onPressed,
      super.child,
      EdgeInsets? padding,
      Color? textColor,
      BorderSide? borderSide,
      BorderRadius? borderRadius,
      Color? backgroundColor})
      : super(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: backgroundColor ?? ColorsConfigs.primary,
                padding: padding ??
                    const EdgeInsets.symmetric(
                        vertical: SpacingConfigs.spacing3,
                        horizontal: SpacingConfigs.spacing7),
                shape: RoundedRectangleBorder(
                  side: borderSide ?? BorderSide.none,
                    borderRadius: borderRadius ??
                        BorderRadius.circular(SpacingConfigs.spacing3))));
}


const regularPadding = EdgeInsets.symmetric(
    horizontal: SpacingConfigs.spacing2,
    vertical: SpacingConfigs.spacing0
);

BorderRadius regularBorderRadius = BorderRadius.circular(SpacingConfigs.spacing1);
