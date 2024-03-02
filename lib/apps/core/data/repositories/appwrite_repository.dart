

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:todo/apps/auth/data/repositories/auth_repository.dart';
import 'package:todo/common/models/model.dart' as BaaSModel;
import 'package:todo/common/serializers/serializer.dart';
import 'package:todo/common/utils/random_utils.dart';
import 'package:todo/configs/data_configs.dart';
import 'package:todo/di/core_providers.dart';

class AppWriteRepository<M extends BaaSModel.Model>{

  final String collectionId;
  final database = CoreProviders.provideDatabase();
  final Serializer<M, Map<String, dynamic>> _serializer;
  final _authRepository = AuthRepository();

  AppWriteRepository(this.collectionId, this._serializer);
  
  String _generateId(){
    return RandomUtils.generateRandomString(IDLength);
  }
  
  create(M instance) async{
    if(instance.getPK() == null){
      instance.setPK(_generateId());
    }
    await database.createDocument(
        databaseId: dbID,
        collectionId: collectionId,
        documentId: instance.getPK()!,
        data: _serializer.serialize(instance)
    );
  }

  update(M instance) async{
    await database.updateDocument(
        databaseId: dbID,
        collectionId: collectionId,
        documentId: instance.getPK()!,
        data: _serializer.serialize(instance)
    );
  }

  Future<M> processDocument(Document document) async{
    final instance = _serializer.deserialize(document.data);
    await attachForeignKeys(instance);
    return instance;
  }

  Future<List<M>> processDocuments(List<Document> documents) async{
    List<M> instances = [];
    for(Document document in documents){
      instances.add(await processDocument(document));
    }
    return instances;
  }

  Future<M> getById(String id) async{
    final document = await database.getDocument(databaseId: dbID, collectionId: collectionId, documentId: id);
    return processDocument(document);
  }

  Future<List<M>> getAll() async{
    final documents = await database.listDocuments(databaseId: dbID, collectionId: collectionId, queries: await globalQueries());
    return processDocuments(documents.documents);
  }

  delete(M instance) async{
    await database.deleteDocument(databaseId: dbID, collectionId: collectionId, documentId: instance.getPK()!, );
  }

  attachForeignKeys(M instance) async{

  }

  Future<List<String>> globalQueries() async {
    return [Query.equal("uid", (await _authRepository.whoAmI()).$id)];
  }

}