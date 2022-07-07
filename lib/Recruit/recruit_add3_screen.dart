import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/Recruit/recruit_add4_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:field_recruitment/constans.dart';
import 'package:intl/intl.dart';

class AddRecruit3Screen extends StatefulWidget {
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

  AddRecruit3Screen(
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
  );

  State<AddRecruit3Screen> createState() => AddRecruit3ScreenState();
}

class AddRecruit3ScreenState extends State<AddRecruit3Screen> {
  // ignore: prefer_typing_uninitialized_variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedPengalamanMarketing;
  List<String> _PengalamanMarketingType = <String>[
    'YA',
    'TIDAK',
  ];
  var selectedKantor;
  List<String> _kantorType = <String>[
    'PT MARSIT',
    'PT TETRA',
    'PT ENTERTEK',
    'PT CAMA',
  ];

  bool visible = false;
  bool visiblex = false;
  String title = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return visiblex
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
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Tambah Recruit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Penempatan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      fieldPengalamanMarketing(),
                      fieldKantor(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: FieldReqruitmentPalette.menuBluebird,
                    color: FieldReqruitmentPalette.menuBluebird,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        if (selectedPengalamanMarketing == null) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('Pilih pengalaman marketing dulu ya'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (selectedKantor == null) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('Pilih kantor dulu ya'),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddRecruit4Screen(
                                widget.nomorKtp,
                                widget.namaLengkap,
                                widget.tempatLahir,
                                widget.tanggalLahir,
                                widget.kotaKab,
                                widget.telepon,
                                widget.email,
                                widget.pendidikan,
                                widget.perusahaan1,
                                widget.posisi1,
                                widget.tahunMasuk1,
                                widget.tahunKeluar1,
                                widget.perusahaan2,
                                widget.posisi2,
                                widget.tahunMasuk2,
                                widget.tahunKeluar2,
                                selectedKantor,
                                selectedPengalamanMarketing,
                              ),
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Lanjut',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget fieldPengalamanMarketing() {
    return DropdownButtonFormField(
        items: _PengalamanMarketingType.map((value) => DropdownMenuItem(
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              value: value,
            )).toList(),
        onChanged: (selectedPengalamanMarketingType) {
          setState(() {
            selectedPengalamanMarketing = selectedPengalamanMarketingType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Pengalaman Marketing',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Poppins-Regular',
            )),
        value: selectedPengalamanMarketing,
        isExpanded: true);
  }

  Widget fieldKantor() {
    return DropdownButtonFormField(
        items: _kantorType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedKantorType) {
          setState(() {
            selectedKantor = selectedKantorType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Perusahaan',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Poppins-Regular',
            )),
        value: selectedKantor,
        isExpanded: true);
  }
}
