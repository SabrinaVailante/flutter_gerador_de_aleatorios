import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS {
  CHAVE_NUMERO_MINIM,
  CHAVE_NUMERO_MAXIMO,
  CHAVE_NUMERO_ALEATORIO,
}

class GeradorStorageServices {
  Future<void> _setInt(STORAGE_KEYS chave, int valor) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(chave.toString(), valor);
  }

  Future<int> _getInt(STORAGE_KEYS chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave.toString()) ?? 0;
  }

  Future<void> setNumeroMinimo(int valor) async {
    await _setInt(STORAGE_KEYS.CHAVE_NUMERO_MINIM, valor);
  }

  Future<int> getNumeroMinimo() async {
    return await _getInt(STORAGE_KEYS.CHAVE_NUMERO_MINIM);
  }

  Future<void> setNumeroMaximo(int valor) async {
    await _setInt(STORAGE_KEYS.CHAVE_NUMERO_MAXIMO, valor);
  }

  Future<int> getNumeroMaximo() async {
    return await _getInt(STORAGE_KEYS.CHAVE_NUMERO_MAXIMO);
  }

  Future<void> setNumeroAleatorio(int valor) async {
    await _setInt(STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO, valor);
  }

  Future<int> getNumeroAleatorio() async {
    return await _getInt(STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO);
  }
}
