import 'package:field_recruitment/Model/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitItem {
  String nik;

  VisitItem(this.nik);
}

class VisitProvider extends ChangeNotifier {
  List<VisitModel> _data = [];
  List<VisitModel> get dataVisit => _data;

  Future<List<VisitModel>> getVisit(VisitItem visitItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getVisitReport';
    final response = await http.post(url, body: {'niksales': visitItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Visit']
          .cast<Map<String, dynamic>>();
      _data =
          result.map<VisitModel>((json) => VisitModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
