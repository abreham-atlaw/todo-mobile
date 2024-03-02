import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/common/serializers/datetime_serializer.dart';
import 'package:todo/common/serializers/nullable_serializer.dart';
import 'package:todo/common/serializers/serializer.dart';

class TodoSerializer extends Serializer<Todo, Map<String, dynamic>> {

  final _dateTimeSerializer = NullableSerializer(DateTimeSerializer());
  
  @override
  Todo deserialize(Map<String, dynamic> data) {
    return Todo(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      completedOn: _dateTimeSerializer.deserialize(data["completed_on"]),
      startDate: _dateTimeSerializer.deserialize(data["start_date"])!,
      endDate: _dateTimeSerializer.deserialize(data["end_date"])!,
      categoryId: data["category_id"],
      uid: data["uid"]
    );
  }

  @override
  Map<String, dynamic> serialize(Todo instance) {
    return {
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed_on': _dateTimeSerializer.serialize(instance.completedOn),
      'start_date': _dateTimeSerializer.serialize(instance.startDate),
      'end_date': _dateTimeSerializer.serialize(instance.endDate),
      'category_id': instance.categoryId,
      'uid': instance.uid
    };
  }
}
