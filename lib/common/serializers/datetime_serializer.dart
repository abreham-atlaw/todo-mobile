import 'dart:core';

import 'package:todo/common/serializers/serializer.dart';

class DateTimeSerializer extends Serializer<DateTime, String> {
  @override
  DateTime deserialize(String data) {
    return DateTime.parse(data);
  }

  @override
  String serialize(DateTime instance) {
    return instance.toIso8601String();
  }
}
