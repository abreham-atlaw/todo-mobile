import 'package:flutter/cupertino.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../async_bloc/async_state.dart';
import 'base_button.dart';

class AsyncButton extends BaseButton {
  AsyncButton(
      {super.key,
      super.backgroundColor,
      super.padding,
      super.onPressed,
      super.borderRadius,
      super.borderSide,
      required AsyncState state,
      required Widget child,
      double? fontSize,
      LoadingIndicator? loadingIndicator})
      : super(child: Builder(builder: (context) {
          if (state.asyncStatus == AsyncStatus.loading) {
            return SizedBox(
              width: FontSizeConfigs.size2_5,
              height: FontSizeConfigs.size2_5,
              child:
                  loadingIndicator ?? LoadingIndicatorsConfigs.indicatorLight,
            );
          }
          return child;
        }));
}
