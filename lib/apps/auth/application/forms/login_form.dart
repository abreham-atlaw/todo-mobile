


import 'package:todo/common/forms/field.dart';
import 'package:todo/common/forms/form.dart';

class LoginForm extends Form{

  final email = TextField();
  final password = TextField();


  @override
  List<Field> getFields() {
    return [
      email,
      password
    ];
  }
}