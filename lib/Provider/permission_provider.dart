import 'package:field_recruitment/Model/checkin_model.dart';
import 'package:field_recruitment/Model/leave_model.dart';
import 'package:field_recruitment/Model/permission_model.dart';
import 'package:field_recruitment/Model/sick_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PermissionItem {
  String nik;

  PermissionItem(this.nik);
}

class PermissionProvider extends ChangeNotifier {
  List<PermissionModel> _data = [];
  List<PermissionModel> get dataPermission => _data;

  Future<List<PermissionModel>> getPermission(
      PermissionItem permissionItem) async {
    final url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getPermissionReport';
    final response =
        await http.post(url, body: {'niksales': permissionItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Permission']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<PermissionModel>((json) => PermissionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
