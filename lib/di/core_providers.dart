import 'package:appwrite/appwrite.dart';


class CoreProviders {

  static Client? appWriteClient;

  static Client provideAppWriteClient(){
    if(CoreProviders.appWriteClient == null){
      CoreProviders.appWriteClient = Client();
      CoreProviders.appWriteClient!
          .setEndpoint('https://cloud.appwrite.io/v1')
          .setProject('65e0bd20ba5b7fb01f10')
          .setSelfSigned(status: true);

    }
    return CoreProviders.appWriteClient!;
  }

  static Account provideAccount(){
    return Account(CoreProviders.provideAppWriteClient());
  }

  static Databases provideDatabase(){
    return Databases(CoreProviders.provideAppWriteClient());
  }

}