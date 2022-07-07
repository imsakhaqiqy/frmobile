import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/Recruit/recruit_add3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:field_recruitment/constans.dart';
import 'package:intl/intl.dart';

class AddRecruit2Screen extends StatefulWidget {
  String nomorKtp;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String kotaKab;
  String telepon;
  String email;
  String pendidikan;

  AddRecruit2Screen(
    this.nomorKtp,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    this.kotaKab,
    this.telepon,
    this.email,
    this.pendidikan,
  );
  State<AddRecruit2Screen> createState() => AddRecruit2ScreenState();
}

class AddRecruit2ScreenState extends State<AddRecruit2Screen> {
  // ignore: prefer_typing_uninitialized_variables
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  bool visiblex = false;
  String title = '';
  final perusahaan1Controller = TextEditingController();
  final posisi1Controller = TextEditingController();
  final tahunMasuk1Controller = TextEditingController();
  final tahunKeluar1Controller = TextEditingController();
  final perusahaan2Controller = TextEditingController();
  final posisi2Controller = TextEditingController();
  final tahunMasuk2Controller = TextEditingController();
  final tahunKeluar2Controller = TextEditingController();
  String? perusahaan1;
  String? posisi1;
  String? tahunMasuk1;
  String? tahunKeluar1;
  String? perusahaan2;
  String? posisi2;
  String? tahunMasuk2;
  String? tahunKeluar2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getWokrExperience() {
    setState(() {
      perusahaan1 = perusahaan1Controller.text;
      posisi1 = posisi1Controller.text;
      tahunMasuk1 = tahunMasuk1Controller.text;
      tahunKeluar1 = tahunKeluar1Controller.text;
      perusahaan2 = perusahaan2Controller.text;
      posisi2 = posisi2Controller.text;
      tahunMasuk2 = tahunMasuk2Controller.text;
      tahunKeluar2 = tahunKeluar2Controller.text;
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
                          'Informasi Pekerjaan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Pengalaman Kerja 1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        fieldPerusahaan1(),
                        fieldPosisi1(),
                        fieldTahunMasuk1(),
                        fieldTahunKeluar1(),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Pengalaman Kerja 2',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        fieldPerusahaan2(),
                        fieldPosisi2(),
                        fieldTahunMasuk2(),
                        fieldTahunKeluar2(),
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
                          getWokrExperience();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddRecruit3Screen(
                                widget.nomorKtp,
                                widget.namaLengkap,
                                widget.tempatLahir,
                                widget.tanggalLahir,
                                widget.kotaKab,
                                widget.telepon,
                                widget.email,
                                widget.pendidikan,
                                perusahaan1!,
                                posisi1!,
                                tahunMasuk1!,
                                tahunKeluar1!,
                                perusahaan2!,
                                posisi2!,
                                tahunMasuk2!,
                                tahunKeluar2!,
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
  }

  Widget fieldPerusahaan1() {
    return TextFormField(
      controller: perusahaan1Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Perusahaan wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Nama Perusahaan'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldPosisi1() {
    return TextFormField(
      controller: posisi1Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Posisi terakhir wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Posisi Terakhir'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTahunMasuk1() {
    return TextFormField(
      controller: tahunMasuk1Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tahun Masuk wajib diisi ya';
        } else if (value.length < 4 || value.length > 4) {
          return 'Tahun Masuk wajib 4 digit ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Tahun Masuk'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTahunKeluar1() {
    return TextFormField(
      controller: tahunKeluar1Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tahun Keluar wajib diisi ya';
        } else if (value.length < 4 || value.length > 4) {
          return 'Tahun Keluar wajib 4 digit ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Tahun Keluar'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldPerusahaan2() {
    return TextFormField(
      controller: perusahaan2Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Perusahaan wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Nama Perusahaan'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldPosisi2() {
    return TextFormField(
      controller: posisi2Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Posisi terakhir wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Posisi Terakhir'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTahunMasuk2() {
    return TextFormField(
      controller: tahunMasuk2Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tahun Masuk wajib diisi ya';
        } else if (value.length < 4 || value.length > 4) {
          return 'Tahun Masuk wajib 4 digit ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Tahun Masuk'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTahunKeluar2() {
    return TextFormField(
      controller: tahunKeluar2Controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tahun Keluar wajib diisi ya';
        } else if (value.length < 4 || value.length > 4) {
          return 'Tahun Keluar wajib 4 digit ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Tahun Keluar'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
