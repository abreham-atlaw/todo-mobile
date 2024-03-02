import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/blocs/signup_bloc.dart';
import 'package:todo/apps/auth/application/events/signup_events.dart';
import 'package:todo/apps/auth/application/states/signup_state.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/async_bloc/async_status.dart';
import 'package:todo/common/utils/routing.dart';
import 'package:todo/common/widgets/buttons/async_button.dart';
import 'package:todo/common/widgets/containers/percentage_container.dart';
import 'package:todo/common/widgets/forms/labeled_field.dart';
import 'package:todo/common/widgets/forms/text_field_widget.dart';
import 'package:todo/common/widgets/navigation/link.dart';
import 'package:todo/common/widgets/screens/bloc_screen.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/common/widgets/text/errors.dart';
import 'package:todo/common/widgets/text/headers.dart';

class SignupScreen extends AsyncBlocScreen<SignupBloc, SignupState> {

  const SignupScreen({super.key});

  @override
  SignupBloc onCreateBloc(SignupState state) {
    return SignupBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, SignupState state) {
    if (state.asyncStatus == AsyncStatus.done) {
      RoutingUtils.redirect("/core/home", context);
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: SpacingConfigs.spacing6),
        alignment: Alignment.center,
        child: PercentageContainer(
          width: 0.8,
          child: Column(
            children: [
              Heading2("Register"),
              const SizedBox(height: SpacingConfigs.spacing1,),
              BodyText("Start tracking your tasks", color: ColorsConfigs.grey),
              const SizedBox(height: SpacingConfigs.spacing3,),
              const SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              ErrorText(state.error?.message ?? ""),
              const SizedBox(
                height: SpacingConfigs.spacing2,
              ),
              LabeledFormField(
                label: "Full Name",
                inputField: TextFieldWidget(
                  field: state.form.fullName,
                  iconData: Icons.person,
                  hintText: "Enter Full Name",
                ),
              ),
              const SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              LabeledFormField(
                label: "Email",
                inputField: TextFieldWidget(
                  field: state.form.email,
                  iconData: Icons.email,
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
                height: SpacingConfigs.spacing3,
              ),
              LabeledFormField(
                label: "Confirm Password",
                inputField: TextFieldWidget(
                  field: state.form.confirmPassword,
                  iconData: Icons.lock,
                  obsecureText: true,
                  hintText: "Confirm Password",
                ),
              ),
              const SizedBox(
                height: SpacingConfigs.spacing6,
              ),
              AsyncButton(
                onPressed: () =>
                {context.read<SignupBloc>().add(SignupEvent())},
                state: state,
                child: BodyText(
                    "Register",
                    color: ColorsConfigs.white,
                    fontSize: FontSizeConfigs.size1
                ),
              ),
              const SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    BodyText("Already have an account?", fontSize: FontSizeConfigs.size1),
                    Link(
                      to: "/auth/login",
                      child: BodyText(
                        "Login",
                        color: ColorsConfigs.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSizeConfigs.size1,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignupState onCreateState() {
    return SignupState();
  }
}
