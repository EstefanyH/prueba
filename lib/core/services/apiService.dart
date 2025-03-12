import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
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
        headers: _getHeaders(),
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error in POST request: $e');
    }
  }

  Future<dynamic> put(String endpoint, File _image) async {
    
    try { 
      //File _image =  File(filePath);

      // Crear la URL de la API
      var url = Uri.parse(endpoint); // Reemplaza con la URL de tu API

      // Crear la solicitud PUT
      var request = http.Request('PUT', url);

      // Abrir el archivo de la imagen
      var fileBytes = await _image.readAsBytes();

      // Obtener el tipo MIME de la imagen
      final mimeType = lookupMimeType(_image.path);

      // Agregar los encabezados (si es necesario)
      request.headers.addAll({
        'Content-Type': mimeType != null ? mimeType : 'application/octet-stream',
        //'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Si se requiere un token de autenticación
      });

      // Adjuntar los bytes de la imagen al cuerpo de la solicitud (en formato binario)
      request.bodyBytes = fileBytes;

      // Enviar la solicitud PUT
      final streamedResponse = await request.send();
      // Convertir el StreamedResponse a http.Response para utilizar la función _handleResponse
      final response = await http.Response.fromStream(streamedResponse);
    
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
      //"Content-Type": "application/json",
      "x-api-key": "${ApiConfig.token}", // Token global
    };
  }

  // **Maneja las respuestas HTTP**
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.statusCode}, ${response.body}");
    }
  }
}