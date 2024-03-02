import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/events/signup_events.dart';
import 'package:todo/apps/auth/application/states/signup_state.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class SignupBloc extends AsyncBloc<SignupState>{

  final _repository = AuthRepository();

  SignupBloc(super.initialState){
    on<SignupEvent>(_handleSignup);
  }

  _handleSignup(SignupEvent event, Emitter emitter) async{
    await asyncCall(
      event,
      emitter,
      (_, __) async{
        await state.form.isValid(throwError: true);
        await _repository.signup(
            state.form.fullName.getValue()!,
            state.form.email.getValue()!,
            state.form.password.getValue()!
        );
      }
    );
  }


}