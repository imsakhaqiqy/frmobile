import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlacementScreen extends StatefulWidget {
  @override
  _PlacementScreenState createState() => _PlacementScreenState();
}

class _PlacementScreenState extends State<PlacementScreen> {
  bool loadingScreen = false;
  String? divisi, jabatan, wilayah, branch, statusKaryawan;
  final String url =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getProfile';
  Future getProfile() async {
    setState(() {
      loadingScreen = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.post(url, body: {
      'nik': isNiksales,
    });
    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Profile'] == '') {
          loadingScreen = false;
        } else {
          var resBody = json.decode(res.body)['Daftar_Profile'][0];
          loadingScreen = false;
          divisi = resBody['divisi_karyawan'].toString();
          jabatan = resBody['jabatan_karyawan'].toString();
          wilayah = resBody['wilayah_karyawan'].toString();
          branch = resBody['branch'].toString();
          statusKaryawan = resBody['status_karyawan'].toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return loadingScreen
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: FieldReqruitmentPalette.menuBluebird,
              title: Text(
                'Penempatan',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
            body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  nikField('DIVISI', divisi),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('JABATAN', jabatan),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('WILAYAH', wilayah),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('BRANCH', branch),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField(
                      'STATUS KARYAWAN', setStatusKaryawan(statusKaryawan!)),
                ],
              ),
            ),
          );
  }

  Widget nikField(
    field,
    value,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  field,
                  style: TextStyle(
                      fontFamily: 'Poppins-Medium', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }
}
