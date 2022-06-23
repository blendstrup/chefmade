import 'package:firebase_storage/firebase_storage.dart';

import '../remote/storage_service.dart';

abstract class IStorageRepository {
  Future<String> getImageUrl(String imageRef);
}

class StorageRepository implements IStorageRepository {
  const StorageRepository(this._storage);

  final FirebaseStorage _storage;

  @override
  Future<String> getImageUrl(String imageRef) {
    return StorageService.getImageUrl(_storage, imageRef);
  }
}
