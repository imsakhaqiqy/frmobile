import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  bool loadingScreen = false;
  String? gajiPokok,
      tunjTkd,
      tunjJabatan,
      tunjPerumahan,
      tunjTelepon,
      tunjKinerja;
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
          gajiPokok = resBody['gaji_pokok'].toString();
          tunjTkd = resBody['tunjangan_tkd'].toString();
          tunjJabatan = resBody['tunjangan_jabatan'].toString();
          tunjPerumahan = resBody['tunjangan_perumahan'].toString();
          tunjTelepon = resBody['tunjangan_telepon'].toString();
          tunjKinerja = resBody['tunjangan_kinerja'].toString();
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
                'Penghasilan',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
            body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  nikField('GAJI POKOK', formatRupiah(gajiPokok!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TUNJ TKD', formatRupiah(tunjTkd!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TUNJ JABATAN', formatRupiah(tunjJabatan!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TUNJ PERUMAHAN', formatRupiah(tunjPerumahan!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TUNJ TELEPON', formatRupiah(tunjTelepon!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TUNJ KINERJA', formatRupiah(tunjKinerja!)),
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
