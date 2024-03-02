


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/events/login_events.dart';
import 'package:todo/apps/auth/application/states/login_state.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class LoginBloc extends AsyncBloc<LoginState>{

  final _repository = AuthRepository();

  LoginBloc(super.initialState){
    on<LoginEvent>(_handleLogin);
  }

  _handleLogin(LoginEvent event, Emitter emitter) async{
    await asyncCall(
        event,
        emitter,
        (_, __) async{
          await state.form.isValid(throwError: true);
          await _repository.login(
            state.form.email.getValue()!,
            state.form.password.getValue()!
          );
        }
    );
  }


}