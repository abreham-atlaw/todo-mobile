

import 'package:appwrite/models.dart';
import 'package:todo/common/async_bloc/async_state.dart';
import 'package:todo/common/async_bloc/base_state.dart';

class ProfileState extends AsyncState{

  User? me;

  @override
  BaseState newInstance() {
    return ProfileState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as ProfileState).me = me;
  }

}