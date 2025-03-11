
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {  
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  late SharedPreferences _preferences;

  SharedPreferencesService._internal();
  
  // Método para obtener la instancia del singleton
  factory SharedPreferencesService() {
    return _instance;
  }
  
  // Inicializar SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

// Método para guardar un String
  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }
  
  // Método para obtener un String
  String? getString(String key) {
    return _preferences.getString(key);
  }
 
  void saveUserData(String key, Map<String, dynamic> userData) async {
    String jsonString = jsonEncode(userData); // Convertir Map a String
    await _preferences.setString(key, jsonString);
  }

  Future<Map<String, dynamic>?> getUserData(String key) async {
    String? jsonString = _preferences.getString(key);

    if (jsonString != null) {
      return jsonDecode(jsonString); // Convertir String a Map
    }
    return null; // Si no existe, devuelve null
  }

}