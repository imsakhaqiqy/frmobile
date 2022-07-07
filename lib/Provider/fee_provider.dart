import 'package:field_recruitment/Model/fee_model.dart';
import 'package:field_recruitment/Model/incentive_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeeItem {
  String nik;

  FeeItem(this.nik);
}

class FeeProvider extends ChangeNotifier {
  List<FeeModel> _data = [];
  List<FeeModel> get dataFee => _data;

  Future<List<FeeModel>> getFee(FeeItem feeItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getFee';
    final response = await http.post(url, body: {'nik_sales': feeItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Fee'].cast<Map<String, dynamic>>();
      _data = result.map<FeeModel>((json) => FeeModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
