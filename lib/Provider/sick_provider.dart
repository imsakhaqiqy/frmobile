import 'package:field_recruitment/Model/checkin_model.dart';
import 'package:field_recruitment/Model/leave_model.dart';
import 'package:field_recruitment/Model/sick_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SickItem {
  String nik;

  SickItem(this.nik);
}

class SickProvider extends ChangeNotifier {
  List<SickModel> _data = [];
  List<SickModel> get dataSick => _data;

  Future<List<SickModel>> getSick(SickItem sickItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getSickReport';
    final response = await http.post(url, body: {'niksales': sickItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Sick']
          .cast<Map<String, dynamic>>();
      _data =
          result.map<SickModel>((json) => SickModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
