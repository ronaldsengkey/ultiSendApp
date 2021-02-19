import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'device.dart';

dynamic globalSecureStorage;

Future initSecureStorage(signature) async {
    globalSecureStorage = const FlutterSecureStorage();
    await secureVariable(signature);
    return globalSecureStorage;
}

dynamic getStorageValue(String key) async{
  final value = await globalSecureStorage.read(key: key);
  return value;
}

Future<void> setStorageValue(String key,String value) async{
  return await globalSecureStorage.write(key: key, value: value);
}

Future deleteAllStorage() async {
  await globalSecureStorage.deleteAll();
}

Future deleteStorageKey(String key) async {
  await globalSecureStorage.delete(key: key);
}

Future secureVariable(signature) async {
  await setStorageValue('signature', signature);
  await setStorageValue('deviceId',deviceId);
}