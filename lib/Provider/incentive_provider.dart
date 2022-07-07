import 'package:field_recruitment/Model/incentive_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsentifItem {
  String nik;

  InsentifItem(this.nik);
}

class InsentifProvider extends ChangeNotifier {
  List<InsentifModel> _data = [];
  List<InsentifModel> get dataInsentif => _data;

  Future<List<InsentifModel>> getInsentif(InsentifItem insentifItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getInsentif';
    final response =
        await http.post(url, body: {'nik_sales': insentifItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Insentif']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<InsentifModel>((json) => InsentifModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
