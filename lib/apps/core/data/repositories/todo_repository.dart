


import 'package:appwrite/appwrite.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/apps/core/data/models/todo.dart';
import 'package:todo/apps/core/data/repositories/appwrite_repository.dart';
import 'package:todo/apps/core/data/repositories/category_repository.dart';
import 'package:todo/apps/core/data/serializers/todo_serializer.dart';
import 'package:todo/common/utils/random_utils.dart';
import 'package:todo/configs/data_configs.dart';
import 'package:todo/di/core_providers.dart';

class TodoRepository extends AppWriteRepository<Todo>{
  
  final _categoryRepository = CategoryRepository();
  final _authRepository = AuthRepository();

  TodoRepository(): super(
    "65e172358d425c473ec7",
    TodoSerializer()
  );

  @override
  create(Todo instance) async{
    instance.uid = (await _authRepository.whoAmI()).$id;
    return super.create(instance);
  }

  @override
  attachForeignKeys(Todo instance) async{
    super.attachForeignKeys(instance);
    instance.category = await _categoryRepository.getById(instance.categoryId);
  }

  Future<List<Todo>> getActiveTodos() async{
    return (await getAll()).where(
            (element) => element.completedOn == null
    ).toList();
  }

  Future<List<Todo>> getTodaysTodos() async {
    DateTime now = DateTime.now();

    return (await getAll()).where((element) =>
    element.startDate.isBefore(now) && element.endDate.isAfter(now)
    ).toList();
  }

  Future<List<Todo>> filterByCategory(Category category) async{
    return (await getAll()).where((element) => element.category!.getPK() == category.getPK()).toList();
  }

  completeTodo(Todo instance) async{
    instance.completedOn = DateTime.now();
    await update(instance);
  }

  unCompleteTodo(Todo instance) async{
    instance.completedOn = null;
    await update(instance);
  }

}