import 'dart:convert';

import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

enum SingingCharacter {
  ya,
  tidak,
}

class AddRecruit5Screen extends StatefulWidget {
  String nomorKtp;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String kotaKab;
  String telepon;
  String email;
  String pendidikan;
  String perusahaan1;
  String posisi1;
  String tahunMasuk1;
  String tahunKeluar1;
  String perusahaan2;
  String posisi2;
  String tahunMasuk2;
  String tahunKeluar2;
  String selectedKantor;
  String selectedPengalamanMarketing;
  String image1;
  String path1;
  String image2;
  String path2;
  String image3;
  String path3;

  AddRecruit5Screen(
    this.nomorKtp,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    this.kotaKab,
    this.telepon,
    this.email,
    this.pendidikan,
    this.perusahaan1,
    this.posisi1,
    this.tahunMasuk1,
    this.tahunKeluar1,
    this.perusahaan2,
    this.posisi2,
    this.tahunMasuk2,
    this.tahunKeluar2,
    this.selectedKantor,
    this.selectedPengalamanMarketing,
    this.image1,
    this.path1,
    this.image2,
    this.path2,
    this.image3,
    this.path3,
  );
  State<AddRecruit5Screen> createState() => AddRecruit5ScreenState();
}

class AddRecruit5ScreenState extends State<AddRecruit5Screen> {
  List<SingingCharacter> _character = <SingingCharacter>[];

  // ignore: prefer_typing_uninitialized_variables
  final String urlDataInterview =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getDataInterview';
  List dataInterview = [];

  bool visible = false;
  bool visiblex = false;
  String title = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataInterview();
  }

  setNilai(SingingCharacter sc) {
    if (sc == SingingCharacter.ya) {
      return '1';
    } else {
      return '0';
    }
  }

  Future _saveRecruitment() async {
    loadingScreen(context);
    setState(() {
      visible = true;
    });

    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/saveRecruitment';

    //starting web api call
    var response = await http.post(url, body: {
      'noktp': widget.nomorKtp,
      'nama': widget.namaLengkap,
      'tempat_lahir': widget.tempatLahir,
      'tanggal_lahir': widget.tanggalLahir,
      'telepon': widget.telepon,
      'email': widget.email,
      'kota': widget.kotaKab,
      'pendidikan': widget.pendidikan,
      'referal': isNiksales,
      'perusahaan': widget.selectedKantor,
      'perusahaan1': widget.perusahaan1,
      'posisi1': widget.posisi1,
      'tahun_masuk1': widget.tahunMasuk1,
      'tahun_keluar1': widget.tahunKeluar1,
      'perusahaan2': widget.perusahaan2,
      'posisi2': widget.posisi2,
      'tahun_masuk2': widget.tahunMasuk2,
      'tahun_keluar2': widget.tahunKeluar2,
      'pengalaman_marketing': widget.selectedPengalamanMarketing,
      'a': setNilai(_character[0]),
      'b': setNilai(_character[1]),
      'c': setNilai(_character[2]),
      'd': setNilai(_character[3]),
      'e': setNilai(_character[4]),
      'pas_foto': widget.path1,
      'image1': widget.image1,
      'cv': widget.path2,
      'image2': widget.image2,
      'ktp': widget.path3,
      'image3': widget.image3,
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Recruitment'];
      if (message == 'Save Success') {
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.success,
          desc: "Recruit berhasil",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show().then((value) {
          Navigator.popAndPushNamed(context, '/landing');
        });
        setState(() {
          visible = false;
        });
      } else {
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.error,
          desc: "Recruit gagal",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
        setState(() {
          visible = false;
        });
      }
    }
  }

  Future<void> _getData() async {
    setState(() {
      getDataInterview();
    });
  }

  Future getDataInterview() async {
    setState(() {
      visiblex = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.get(Uri.encodeFull(urlDataInterview),
        headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Interview'] == '') {
          visiblex = false;
        } else {
          var resBody = json.decode(res.body)['Daftar_Interview'];
          visiblex = false;
          dataInterview = resBody;
          for (int i = 0;
              i < json.decode(res.body)['Daftar_Interview'].length;
              i++) {
            _character.add(SingingCharacter.ya);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return visiblex
        ? Container(
            color: Colors.white,
            child: Center(
              child: SpinKitThreeInOut(
                color: FieldReqruitmentPalette.menuBluebird,
                size: 30.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Soal Interview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: fieldDataInterview(),
            ),
            bottomSheet: Container(
              margin: EdgeInsets.all(16.0),
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: FieldReqruitmentPalette.menuBluebird,
                color: FieldReqruitmentPalette.menuBluebird,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    _saveRecruitment();
                  },
                  child: Center(
                    child: visible
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'Simpan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget fieldDataInterview() {
    if (dataInterview.length > 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dataInterview.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dataInterview[index]['pertanyaan'].toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      ListTile(
                        title: Text('YA'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.ya,
                          groupValue: _character[index],
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character[index] = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('TIDAK'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.tidak,
                          groupValue: _character[index],
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character[index] = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.hourglass_empty, size: 70),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            'Pertanyaan belum tersedia',
            style: TextStyle(
                fontFamily: "Poppins-Regular",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ]),
      );
    }
  }
}
