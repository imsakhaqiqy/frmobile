import 'package:field_recruitment/Model/checkin_model.dart';
import 'package:field_recruitment/Model/leave_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveItem {
  String nik;

  LeaveItem(this.nik);
}

class LeaveProvider extends ChangeNotifier {
  List<LeaveModel> _data = [];
  List<LeaveModel> get dataLeave => _data;

  Future<List<LeaveModel>> getLeave(LeaveItem leaveItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getLeaveReport';
    final response = await http.post(url, body: {'niksales': leaveItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Leave']
          .cast<Map<String, dynamic>>();
      _data =
          result.map<LeaveModel>((json) => LeaveModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
