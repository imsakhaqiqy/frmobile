import 'package:field_recruitment/Model/checkin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckInItem {
  String nik;

  CheckInItem(this.nik);
}

class CheckInProvider extends ChangeNotifier {
  List<CheckInModel> _data = [];
  List<CheckInModel> get dataCheckin => _data;

  Future<List<CheckInModel>> getCheckin(CheckInItem checkInItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getCheckInReport';
    final response = await http.post(url, body: {'niksales': checkInItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Checkin']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<CheckInModel>((json) => CheckInModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
