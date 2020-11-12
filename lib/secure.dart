import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'device.dart';
import 'variable.dart';

dynamic globalSecureStorage;

Future initSecureStorage() async {
    globalSecureStorage = const FlutterSecureStorage();
    await secureVariable();
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

Future secureVariable() async {
  await setStorageValue('signature', ultiSendSignature);
  await setStorageValue('deviceId',deviceId);
}