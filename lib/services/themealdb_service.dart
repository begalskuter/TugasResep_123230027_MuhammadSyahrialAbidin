import 'dart:convert';
import 'package:http/http.dart' as http;

class TheMealDBService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';


  Future<List<dynamic>> getRecipesByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? [];
    }
    throw Exception('Gagal mengambil data resep');
  }

  // Endpoint untuk Detail Page berdasarkan ID
  Future<Map<String, dynamic>?> getRecipeDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return data['meals'][0];
      }
    }
    throw Exception('Gagal mengambil detail resep');
  }
}