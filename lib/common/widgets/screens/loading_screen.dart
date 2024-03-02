import 'package:flutter/widgets.dart';
import 'package:todo/common/widgets/screens/app_scaffold.dart';
import 'package:todo/common/widgets/text/headers.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/widgets/containers/full_container.dart';
import 'package:todo/common/widgets/containers/percentage_container.dart';
import '../../async_bloc/base_state.dart';

class LoadingScreen extends StatelessWidget {
  final BaseState state;

  const LoadingScreen(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: FullContainer(
          decoration: const BoxDecoration(
              color: ColorsConfigs.light
          ),
          child: PercentageContainer(
              width: 0.75,
              child: Column(
                children: [
                  // Image.asset("assets/images/logo.png"),
                  // const SizedBox(
                  //   height: SpacingConfigs.spacing3,
                  // ),

                  const SizedBox(
                      width: WidgetSizeConfigs.size0,
                      child: LoadingIndicatorsConfigs.indicatorDark
                  ),
                  const SizedBox(
                    height: SpacingConfigs.spacing5,
                  ),
                  Heading3("Loading...")
                ],
              ))),
    );
  }
}
