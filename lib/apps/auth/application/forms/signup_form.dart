import 'package:todo/common/forms/exceptions.dart';
import 'package:todo/common/forms/field.dart';
import 'package:todo/common/forms/form.dart';

class SignupForm extends Form {

  Field<String> fullName = TextField(
      validator: (String value) async{
        var split = value.split(" ");
        if(split.length < 2 || split[1].replaceAll(" ", "") == ""){
          throw ValidationException("Please enter a valid full name.");
        }
      }
  );
  Field<String> email = TextField(
      validator: (String value) async{
        final RegExp emailRegex = RegExp(
          r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
        );

        if(!emailRegex.hasMatch(value)){
          throw ValidationException("Please enter a valid email address.");
        }
      }
  );
  Field<String> password = TextField(
    validator: (String value) async{
      if(value.length < 8){
        throw ValidationException("Password should at least be 8 characters long");
      }
    }
  );
  Field<String> confirmPassword = TextField();

  @override
  List<Field> getFields() {
    return [fullName, email, password, confirmPassword];
  }

  @override
  Future<void> validate() async {
    await super.validate();
    if (password.getValue()! != confirmPassword.getValue()!) {
      throw ValidationException("Passwords Don't Match");
    }
  }
}
