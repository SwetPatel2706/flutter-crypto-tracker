// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/coin.dart';

class ApiService {
  Future<List<Coin>> getCoins() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Coin.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coins. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}