import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/blocs/profile_bloc.dart';
import 'package:todo/apps/auth/application/events/profile_events.dart';
import 'package:todo/apps/auth/application/states/profile_state.dart';
import 'package:todo/common/widgets/buttons/base_button.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/buttons/async_button.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/common/widgets/text/errors.dart';
import 'package:todo/common/widgets/text/headers.dart';


class ProfileScreen extends AsyncBlocScreen<ProfileBloc, ProfileState> {
  const ProfileScreen({super.key});

  @override
  ProfileBloc onCreateBloc(ProfileState state) {
    return ProfileBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, ProfileState state) {
    if (state.asyncStatus == AsyncStatus.done){
      RoutingUtils.redirect("/auth/login", context);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpacingConfigs.spacing4
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: SpacingConfigs.spacing6,),
                CircleAvatar(
                  radius: WidgetSizeConfigs.size0,
                  backgroundColor: ColorsConfigs.secondary,
                  child: Heading2(
                    "${state.me!.name[0]}${state.me!.name.split(" ")[1][0]}",
                    color: ColorsConfigs.white,
                  ),
                ),
                const SizedBox(height: SpacingConfigs.spacing2,),
                Heading3(state.me!.name),
                const SizedBox(height: SpacingConfigs.spacing1,),
                BodyText(state.me!.email, color: ColorsConfigs.grey, fontSize: FontSizeConfigs.size1,)
              ],
            ),
            const SizedBox(height: SpacingConfigs.spacing3,),
            ErrorText(state.error?.message ?? ""),
            const SizedBox(
              height: SpacingConfigs.spacing4,
            ),
            const SizedBox(height: SpacingConfigs.spacing2,),
            Container(
              alignment: Alignment.bottomCenter,
              child: AsyncButton(
                padding: const EdgeInsets.all(SpacingConfigs.spacing3),
                onPressed: (){
                  context.read<ProfileBloc>().add(LogoutEvent());
                },
                borderRadius: regularBorderRadius,
                state: state,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Heading3("Logout", color: ColorsConfigs.light),
                    const Icon(Icons.arrow_forward, color: ColorsConfigs.light,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: SpacingConfigs.spacing3,),
          ],
        ),
      ),
    );
  }

  @override
  ProfileState onCreateState() {
    return ProfileState();
  }
}
