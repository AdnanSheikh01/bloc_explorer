import 'dart:convert';
import 'dart:developer';
import 'package:bloc_explorer/models/blogs_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<BlogsModels>> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<dynamic> blogsJson = jsonData['blogs'];

        return blogsJson.map((json) => BlogsModels.fromJson(json)).toList();
      } else {
        log('Request failed with status code: ${response.statusCode}');
        log('Response data: ${response.body}');
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load blogs: $e');
    }
  }
}
