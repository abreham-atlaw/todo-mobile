

import 'package:todo/apps/auth/application/forms/login_form.dart';
import 'package:todo/common/async_bloc/async_state.dart';

class LoginState extends AsyncState{

  var form = LoginForm();

  @override
  newInstance() {
    return LoginState();
  }

  @override
  void copyProperties(newState) {
    super.copyProperties(newState);
    (newState as LoginState).form = form;
  }

}