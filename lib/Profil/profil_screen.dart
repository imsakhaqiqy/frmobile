import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool loadingScreen = false;
  String? nik,
      namaKaryawan,
      statusPernikahan,
      tanggalLahir,
      tempatLahir,
      noKtp,
      jenisKelamin,
      agama,
      email,
      telepon,
      pendidikan;
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
          nik = resBody['nik'].toString();
          namaKaryawan = resBody['nama_karyawan'].toString();
          statusPernikahan = resBody['status_nikah'].toString();
          tanggalLahir = resBody['tgl_lahir'].toString();
          tempatLahir = resBody['tempat_lahir'].toString();
          noKtp = resBody['no_ktp'].toString();
          jenisKelamin = resBody['jenis_kelamin'].toString();
          agama = resBody['agama'].toString();
          email = resBody['alamat_email'].toString();
          telepon = resBody['no_telepon_2'].toString();
          pendidikan = resBody['pendidikan'].toString();
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
                'Profil',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
            body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  nikField('NIK', nik),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('NAMA KARYAWAN', namaKaryawan),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('STATUS PERKAWINAN',
                      setStatusPerkawinan(statusPernikahan!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TANGGAL LAHIR', tanggalLahir),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TEMPAT LAHIR', tempatLahir),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('NO KTP', noKtp),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('JENIS KELAMIN', setJenisKelamin(jenisKelamin!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('AGAMA', setAgama(agama!)),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('EMAIL', email),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('TELEPON', telepon),
                  SizedBox(
                    height: 10.0,
                  ),
                  nikField('PENDIDIKAN', setPendidikan(pendidikan!)),
                  SizedBox(
                    height: 10.0,
                  ),
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
