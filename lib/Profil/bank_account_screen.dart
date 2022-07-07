import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountBankScreen extends StatefulWidget {
  @override
  _AccountBankScreenState createState() => _AccountBankScreenState();
}

class _AccountBankScreenState extends State<AccountBankScreen> {
  bool loadingScreen = false;
  String? noRekening, namaBank, namaRekening;
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
          noRekening = resBody['no_rekening'].toString();
          namaBank = resBody['nama_bank'].toString();
          namaRekening = resBody['nama_rekening'].toString();
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
                'Akun Bank',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
            body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  nikField('NO REKENING', noRekening),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('NAMA BANK', namaBank),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('NAMA REKENING', namaRekening),
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
