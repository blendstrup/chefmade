import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> getImageUrl(
    FirebaseStorage storage,
    String imageRef,
  ) async {
    return await storage.ref(imageRef).getDownloadURL();
  }
}
