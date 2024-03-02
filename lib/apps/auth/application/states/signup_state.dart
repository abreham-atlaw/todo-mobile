

import 'package:todo/apps/auth/application/forms/signup_form.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/base_state.dart';

class SignupState extends AsyncState{

  var form = SignupForm();

  @override
  BaseState newInstance() {
    return SignupState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as SignupState).form = form;
  }

}