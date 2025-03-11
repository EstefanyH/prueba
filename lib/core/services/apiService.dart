import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba/core/api_config.dart';

final class ApiService {
  
  final http.Client client;

  ApiService(this.client);

  Future<dynamic> get(String url, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      //final response = await client.get(uri);
      final response = await http.get(
        uri,
        headers: _getHeaders()
      );
    return _handleResponse(response);

    } catch (e) {
      throw Exception('Error in GET request: $e');
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error in POST request: $e');
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final url = Uri.parse(endpoint);

    try {
      final response = await http.put(
        url,
        headers: _getHeaders(),
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Error en PUT: $e");
    }
  }

  /// **Método PATCH**
  Future<dynamic> patch(String endpoint, dynamic data) async {
    final url = Uri.parse(endpoint);

    try {
      final response = await http.patch(
        url,
        headers: _getHeaders(),
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Error en PATCH: $e");
    }
  }

  Map<String, String> _getHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${ApiConfig.token}", // Token global
    };
  }

  // **Maneja las respuestas HTTP**
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.statusCode}, ${response.body}");
    }
  }
}