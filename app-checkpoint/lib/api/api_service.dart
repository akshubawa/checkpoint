import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = 'https://checkpoint-awvj.onrender.com/api/v1';
  static const String baseUrl = 'https://checkpoint-production-5fc2.up.railway.app/api/v1';
  
  Future<http.Response> get(String endpoint,
      {bool isAdmin = false, Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint';
    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response> post(String endpoint,
      {dynamic body,
      Map<String, String>? headers,
      bool jsonEncodeBody = false}) async {
    final response = jsonEncodeBody
        ? await http
            .post(Uri.parse('$baseUrl/$endpoint'),
                headers: headers, body: jsonEncode(body))
            .timeout(const Duration(seconds: 60))
        : await http
            .post(Uri.parse('$baseUrl/$endpoint'), headers: headers, body: body)
            .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response> postWithFile(String endpoint, File file,
      {Map<String, String>? headers, Map<String, dynamic>? bodyFields}) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('${'https://1d34-14-97-132-203.ngrok-free.app'}/$endpoint'));
    request.headers.addAll(headers ?? {});
    bodyFields?.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.files.add(http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }


  Future<http.Response> put(String endpoint,
      {bool isAdmin = false, Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint';
    final response = await http
        .put(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response> putWithFile(String endpoint,
      {File? file,
      Map<String, String>? headers,
      Map<String, dynamic>? bodyFields}) async {
    final request =
        http.MultipartRequest('PUT', Uri.parse('$baseUrl/$endpoint'));
    request.headers.addAll(headers ?? {});
    bodyFields?.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    if (file != null) {
      request.files.add(http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> delete(String endpoint, String extendedEndpoint,
      {Map<String, String>? headers}) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$endpoint/$extendedEndpoint'),
            headers: headers)
        .timeout(const Duration(seconds: 60));
    return response;
  }
}
