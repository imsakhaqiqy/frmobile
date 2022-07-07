import 'package:field_recruitment/Model/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOutItem {
  String nik;

  CheckOutItem(this.nik);
}

class CheckOutProvider extends ChangeNotifier {
  List<CheckOutModel> _data = [];
  List<CheckOutModel> get dataCheckout => _data;

  Future<List<CheckOutModel>> getCheckout(CheckOutItem checkOutItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getCheckOutReport';
    final response = await http.post(url, body: {'niksales': checkOutItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Checkout']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<CheckOutModel>((json) => CheckOutModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
