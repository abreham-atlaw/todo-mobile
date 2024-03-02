import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/blocs/login_bloc.dart';
import 'package:todo/apps/auth/application/events/login_events.dart';
import 'package:todo/apps/auth/application/states/login_state.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/buttons/async_button.dart';
import 'package:todo/common/widgets/containers/full_container.dart';
import 'package:todo/common/widgets/containers/percentage_container.dart';
import 'package:todo/common/widgets/forms/labeled_field.dart';
import 'package:todo/common/widgets/forms/text_field_widget.dart';
import 'package:todo/common/widgets/navigation/link.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/common/widgets/text/errors.dart';
import 'package:todo/common/widgets/text/headers.dart';


class LoginScreen extends AsyncBlocScreen<LoginBloc, LoginState> {
  const LoginScreen({super.key});

  @override
  LoginBloc onCreateBloc(LoginState state) {
    return LoginBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, LoginState state) {
    if (state.asyncStatus == AsyncStatus.done) {
      RoutingUtils.redirect("/", context);
    }
    return FullContainer(
      alignment: Alignment.center,
      child: PercentageContainer(
        width: 0.8,
        child: Column(
          children: [
            Heading2("WELCOME BACK"),
            const SizedBox(height: SpacingConfigs.spacing1,),
            BodyText("Continue tracking your tasks", color: ColorsConfigs.grey),
            const SizedBox(height: SpacingConfigs.spacing3,),
            const SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            ErrorText(state.error?.message ?? ""),
            const SizedBox(
              height: SpacingConfigs.spacing4,
            ),
            LabeledFormField(
              label: "Email",
              inputField: TextFieldWidget(
                field: state.form.email,
                iconData: Icons.person,
                hintText: "Enter Email",
              ),
            ),
            const SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            LabeledFormField(
              label: "Password",
              inputField: TextFieldWidget(
                field: state.form.password,
                iconData: Icons.lock,
                obsecureText: true,
                hintText: "Enter Password",
              ),
            ),
            const SizedBox(
              height: SpacingConfigs.spacing5,
            ),
            AsyncButton(
              onPressed: () => {context.read<LoginBloc>().add(LoginEvent())},
              state: state,
              child: BodyText(
                  "LOGIN",
                  color: ColorsConfigs.white,
                  fontSize: FontSizeConfigs.size1,
              ),
            ),
            const SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  BodyText(
                      "Don't Have an Account Yet?",
                    fontSize: FontSizeConfigs.size1,
                  ),
                  Link(
                    to: "/auth/signup",
                    child: BodyText(
                      "Sign Up",
                      color: ColorsConfigs.primary,
                      fontSize: FontSizeConfigs.size1,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  LoginState onCreateState() {
    return LoginState();
  }
}
