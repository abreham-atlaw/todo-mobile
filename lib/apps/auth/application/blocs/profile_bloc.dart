import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/apps/auth/application/events/profile_events.dart';
import 'package:todo/apps/auth/application/states/profile_state.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/common/async_bloc/async_bloc.dart';

class ProfileBloc extends AsyncBloc<ProfileState>{

  final _repository = AuthRepository();

  ProfileBloc(super.initialState){
    on<LogoutEvent>(_handleLogout);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();
    state.me = await _repository.whoAmI();
  }

  _handleLogout(LogoutEvent event, Emitter emitter) async{
    await asyncCall(
        event,
        emitter,
        (event, state) async{
          await _repository.logout();
        }
    );

  }

}