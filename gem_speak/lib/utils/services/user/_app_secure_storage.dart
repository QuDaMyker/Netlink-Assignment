import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gem_speak/common/constant/app_constants.dart';
import 'package:hive/hive.dart';
import 'package:tool_core/models/user_auth.dart';
import 'package:tool_core/storage/app_storage.dart';

AppStorage createAppStorage() => AppSecureStorage<UserAuth>();

class AppSecureStorage<E> implements AppStorage {
  late Box encryptedBox;

  Future<void> init() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'key');
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final key = await secureStorage.read(key: 'key');
    final encryptionKeyUint8List = base64Url.decode(key!);

    encryptedBox = await Hive.openBox(
      'securedStorage',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }

  @override
  Future<void> deleteItem(dynamic key) async {
    return await encryptedBox.delete(key);
  }

  @override
  Future<E>? getItem(dynamic key, {dynamic defaultValue}) async {
    return encryptedBox.get(key);
  }

  @override
  Future<void> setItem(dynamic key, dynamic value) async {
    return await encryptedBox.put(key, value);
  }

  @override
  Future<bool> containsKey(dynamic key) async {
    return encryptedBox.containsKey(key);
  }
}

extension AppSecureStorageExtension on AppSecureStorage {
  Future<void> saveUserAuth(String value) async {
    await encryptedBox.put(AppConstants.userAuthKey, value);
  }

  Future<UserAuth?> getUserAuth() async {
    final userAuth = await encryptedBox.get(AppConstants.userAuthKey);
    if (userAuth != null) {
      return UserAuth.fromJson(jsonDecode(userAuth));
    }
    return null;
  }

  Future<void> clear() async {
    await encryptedBox.clear();
  }

  Future<void> deleteAll(List<dynamic> keys) async {
    for (var key in keys) {
      await encryptedBox.delete(key);
    }
  }
}
