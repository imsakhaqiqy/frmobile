import 'package:field_recruitment/Model/checkin_model.dart';
import 'package:field_recruitment/Model/personal_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonalItem {
  String id;

  PersonalItem(this.id);
}

class PersonalProvider extends ChangeNotifier {
  List<PersonalModel> _data = [];
  List<PersonalModel> get dataPersonal => _data;

  Future<List<PersonalModel>> getPersonal(PersonalItem personalItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getPersonal';
    final response = await http.post(url, body: {'id': personalItem.id});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Personal']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<PersonalModel>((json) => PersonalModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
