import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/Recruit/kabupaten_screen.dart';
import 'package:field_recruitment/Recruit/recruit_add2_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:field_recruitment/constans.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddRecruitScreen extends StatefulWidget {
  const AddRecruitScreen({Key? key}) : super(key: key);

  State<AddRecruitScreen> createState() => AddRecruitScreenState();
}

class AddRecruitScreenState extends State<AddRecruitScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final formKey = GlobalKey<FormState>();
  var selectedPendidikan;
  List<String> _pendidikanType = <String>[
    'SD',
    'SMP',
    'SMA',
    'DIPLOMA',
    'SARJANA',
    'MAGISTER',
  ];
  bool visible = false;
  bool visiblex = false;
  String title = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nomorKtpController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final kotaKabController = TextEditingController();
  final teleponController = TextEditingController();
  final emailController = TextEditingController();
  String? nomorKtp;
  String? namaLengkap;
  String? tempatLahir;
  String? tanggalLahir;
  String? kotaKab;
  String? telepon;
  String? email;
  bool? validasi = false;

  Future getValidasiKtp(String value) async {
    setState(() {
      visible = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getValidasiKtp';

    //starting web api call
    var response = await http.post(url, body: {
      'ktp': value,
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Ktp'];
      if (message != '') {
        setState(() {
          if (int.parse(message[0]['jml']) >= 1) {
            validasi = true;
          } else {
            validasi = false;
          }
          visible = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getPersonal() {
    setState(() {
      nomorKtp = nomorKtpController.text;
      namaLengkap = namaLengkapController.text;
      tempatLahir = tempatLahirController.text;
      tanggalLahir = tanggalLahirController.text;
      kotaKab = kotaKabController.text;
      telepon = teleponController.text;
      email = emailController.text;
    });
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Pribadi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        fieldNomorKtp(),
                        fieldNamaLengkap(),
                        fieldTempatLahir(),
                        fieldTanggalLahir(),
                        fieldKotaKab(),
                        fieldTelepon(),
                        fieldEmail(),
                        fieldPendidikan(),
                      ],
                    ),
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
                        if (formKey.currentState!.validate()) {
                          if (selectedPendidikan == null) {
                            _scaffoldKey.currentState?.showSnackBar(SnackBar(
                              content: Text('Pilih pendidikan dulu ya'),
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            getPersonal();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddRecruit2Screen(
                                  nomorKtp!,
                                  namaLengkap!,
                                  tempatLahir!,
                                  tanggalLahir!,
                                  kotaKab!,
                                  telepon!,
                                  email!,
                                  selectedPendidikan,
                                ),
                              ),
                            );
                          }
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

  Widget fieldNomorKtp() {
    return TextFormField(
      controller: nomorKtpController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nomor KTP wajib diisi ya';
        } else if (value.length < 16 || value.length > 16) {
          return 'Nomor KTP wajib 16 digit ya';
          // ignore: unrelated_type_equality_checks
        } else if (validasi!) {
          return 'Nomor KTP sudah terdaftar';
        }
        return null;
      },
      onChanged: (value) {
        getValidasiKtp(value);
      },
      decoration: const InputDecoration(
        labelText: 'Nomor KTP',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldNamaLengkap() {
    return TextFormField(
      controller: namaLengkapController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Lengkap wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTempatLahir() {
    return TextFormField(
      controller: tempatLahirController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tempat Lahir wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Tempat Lahir'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTanggalLahir() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalLahirController,
        validator: (DateTime? dateTime) {
          if (dateTime == null) {
            return 'Tanggal Lahir wajib diisi ya';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Tanggal Lahir'),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        style: TextStyle(fontFamily: 'Poppins-Regular'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    ]);
  }

  Widget fieldKotaKab() {
    return TextFormField(
      showCursor: false,
      readOnly: true,
      controller: kotaKabController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Kota / Kabupaten wajib diisi ya';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kota / Kabupaten'),
      onTap: () {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => KotaKabupatenScreen()))
            .then((value) {
          setState(() {
            kotaKabController.text = value;
          });
        });
      },
      style: TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Telepon wajib diisi ya';
        } else if (value.length < 10) {
          return 'Telepon minimal 10 digit ya';
        } else if (value.length > 13) {
          return 'Telepon maksimal 13 digit ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldEmail() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email wajib diisi ya';
        } else if (!value.contains('@')) {
          return 'Email harus valid ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Email'),
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldPendidikan() {
    return DropdownButtonFormField(
        items: _pendidikanType
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
        onChanged: (selectedPendidikanType) {
          setState(() {
            selectedPendidikan = selectedPendidikanType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Pendidikan',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Poppins-Regular',
            )),
        value: selectedPendidikan,
        isExpanded: true);
  }
}
