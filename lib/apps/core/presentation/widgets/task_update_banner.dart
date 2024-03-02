
import 'package:flutter/cupertino.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:todo/common/widgets/banners/banner_widget.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/configs/ui_configs.dart';

class TaskUpdateBanner extends StatelessWidget{

  final AsyncState state;

  const TaskUpdateBanner(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bannerColor;
    String text;

    switch(state.asyncStatus){

      case AsyncStatus.none:
        return const SizedBox.shrink();

      case AsyncStatus.loading:
        bannerColor = ColorsConfigs.info;
        text = "Updating Task...";
        break;

      case AsyncStatus.done:
        bannerColor = ColorsConfigs.success;
        text = "Task Successfully Updated.";
        break;

      case AsyncStatus.failed:
        bannerColor = ColorsConfigs.danger;
        text = "Failed to Update Task.";
        break;

    }

    return BannerWidget(
        key: Key(text),
        color: bannerColor,
        seconds: (state.asyncStatus == AsyncStatus.loading) ? null : 5,
        child: BodyText(text, color: ColorsConfigs.light,)
    );
  }



}