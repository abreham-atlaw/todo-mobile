

import 'package:todo/common/models/model.dart';

class Category extends Model{

  String? id;
  String name;
  String? uid;


  Category({
    this.id,
    required this.name,
    this.uid
  });

  @override
  String? getPK() {
    return id;
  }

  @override
  setPK(String pk) {
    id = pk;
  }

}