import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:todo/apps/auth/data/models/authentication_status.dart';
import 'package:todo/common/utils/random_utils.dart';
import 'package:todo/configs/data_configs.dart';
import 'package:todo/di/core_providers.dart';


class AuthRepository{

  final _account = CoreProviders.provideAccount();

  String _generateUID(){
    return RandomUtils.generateRandomString(IDLength);
  }

  login(String email, String password) async{
    await _account.createEmailSession(email: email, password: password);
  }
  
  logout() async{
    await _account.deleteSessions();
  }

  Future<User> signup(String name, String email, String password ) async{
    final user = await _account.create(userId: _generateUID(), email: email, password: password, name: name);
    await login(email, password);
    return user;
  }

  Future<User> whoAmI() async{
    return await _account.get();
  }

  Future<AuthenticationStatus> getAuthenticationStatus() async{
    try {
      await whoAmI();
      return AuthenticationStatus.authenticated;
    } catch(ex){
      if(ex is AppwriteException){
        if(ex.code == 401){
          return AuthenticationStatus.none;
        }
      }
      rethrow;
    }
  }

}