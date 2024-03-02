import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/common/models/model.dart';

class Todo extends Model {
  String? id;

  String categoryId;
  String? uid;

  String title;
  String description;

  DateTime startDate;
  DateTime endDate;
  DateTime? completedOn;

  Category? category;

  Todo({
    this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.uid,
    this.completedOn,
  });

  bool get isComplete {
    return completedOn != null;
  }

  @override
  String? getPK() {
    return id;
  }

  @override
  setPK(String pk) {
    id = pk;
  }


}
