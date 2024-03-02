


import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/repositories/appwrite_repository.dart';
import 'package:todo/apps/core/data/serializers/category_serializer.dart';

class CategoryRepository extends AppWriteRepository<Category>{

  final _authRepository = AuthRepository();

  CategoryRepository(): super(
    "65e1724844e80ad66721",
    CategorySerializer()
  );

  @override
  create(Category instance) async{
    instance.uid = (await _authRepository.whoAmI()).$id;
    return super.create(instance);
  }

}