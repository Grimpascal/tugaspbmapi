import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class ProductController {

  final String baseUrl =
      "https://task.itprojects.web.id";

  Future<List<productModel>> getProducts() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/products'),

      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List products =
          data['data']['products'];
      return products.map(
        (e) => productModel.fromJson(e),
      ).toList();
    } else {
      throw Exception(
        'Gagal mengambil produk',
      );
    }
  }

  Future<bool> addProduct(
    String name,
    int price,  
    String description,
  ) async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/api/products'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

      body: jsonEncode({
        "name": name,
        "price": price,
        "description": description,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}