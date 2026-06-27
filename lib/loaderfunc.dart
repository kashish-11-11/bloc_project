import 'dart:convert';

import 'package:flutter/services.dart';

class loaderfunc {
  Future<List<dynamic>> load_products() async {
    final String response = await rootBundle.loadString("assets/products.json");
    final data = json.decode(response);
    return data;
    
  }
}
