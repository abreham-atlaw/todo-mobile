
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/common/forms/field.dart';
import 'package:todo/common/forms/form.dart';

class TodoForm extends Form{

  final title = TextField();
  final description = TextField();
  final startDate = Field<DateTime>();
  final endDate = Field<DateTime>();
  final category = Field<Category>();

  @override
  List<Field> getFields() {
    return [
      title,
      description,
      startDate,
      endDate,
      category
    ];
  }

}