import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoryApiService {
  static const String baseUrl = 'http://localhost:3000'; // APIのベースURL

  // カテゴリ一覧を取得
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('カテゴリの取得に失敗しました');
    }
  }

  // カテゴリを作成
  static Future<Category?> createCategory(String name, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'description': description}),
    );

    if (response.statusCode == 201) {
      return Category.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
