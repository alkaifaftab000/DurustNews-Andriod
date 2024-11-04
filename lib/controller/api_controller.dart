import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController {
  final random = Random();
  late String selectedApi;
  final List<String> l1 = [
    '776d750cbe4d50e37174ec4effda0165',
    '69b4531b384edfeaf2e9f2682d636a90',
    'e4166798792bc1b70d5ffbb6ba277536',
    '5fe2a63bd8010c887b0cfaa129784629'
  ];
  List<NewsModel> newsList = <NewsModel>[];

  ApiController() {
    selectedApi = l1[random.nextInt(l1.length)];
  }

  Future<void> getApi(String query) async {
    clearNewsList(); // Clear the list before fetching new data

    // Get the current date in the required formast (YYYY-MM-DD)
    final currentDate = DateTime.now().toUtc().toString().split(' ')[0];

    final url =
        "https://gnews.io/api/v4/search?q=$query&apikey=$selectedApi&lang=en&from=$currentDate";

    try {
      debugPrint('Fetching news from URL: $url');
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);

        if (data['articles'] != null) {
          newsList = (data['articles'] as List)
              .map((element) => NewsModel.fromMap(element))
              .toList();
        } else {
          throw Exception('API returned unexpected data structure');
        }
      } else {
        throw Exception('Failed to load news: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching news: $e');
      throw Exception('Failed to load news: $e');
    }
  }

  void clearNewsList() {
    newsList.clear();
  }
}

// Make sure your NewsModel class is updated as in the previous example