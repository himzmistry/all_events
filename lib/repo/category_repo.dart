import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../constants/api_sheet.dart';

final categoryRepoProvider = Provider((ref) => CategoryRepo());
final client = APIClient();

class CategoryRepo {
  getCategory() async {
    print('getCategory called');
    try {
      var response = await client.getHttp(ApiSheet.baseUrl + ApiSheet.category);
      return response;
    } catch (e) {
      print('getCategory: $e');
    }
  }

  getEvent(String url) async {
    if (url == '' || url.isEmpty) {
      return;
    }
    try {
      var response = await client.getHttp(url);
      return response;
    } catch (e) {
      print('getEvent: $e');
    }
  }
}
