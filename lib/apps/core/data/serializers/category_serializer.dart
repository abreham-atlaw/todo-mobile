import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/common/serializers/serializer.dart';

class CategorySerializer extends Serializer<Category, Map<String, dynamic>> {

  @override
  Category deserialize(Map<String, dynamic> data) {
    return Category(
      id: data["id"],
      name: data["name"],
      uid: data["uid"]
    );
  }

  @override
  Map<String, dynamic> serialize(Category instance) {
    return {
      'id': instance.id,
      'name': instance.name,
      "uid": instance.uid
    };
  }
}
