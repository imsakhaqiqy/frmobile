import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({Key? key}) : super(key: key);

  State<AddLeaveScreen> createState() => AddLeaveScreenState();
}

class AddLeaveScreenState extends State<AddLeaveScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  bool visiblex = false;
  final tanggal1Controller = TextEditingController();
  final tanggal2Controller = TextEditingController();
  final tanggalMasukController = TextEditingController();
  final keperluanController = TextEditingController();
  final teleponDaruratController = TextEditingController();
  String? tanggal1;
  String? tanggal2;
  String? tanggalMasuk;
  String? keperluan;
  String? teleponDarurat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future _saveLeave() async {
    loadingScreen(context);
    setState(() {
      visible = true;
    });

    tanggal1 = tanggal1Controller.text;
    tanggal2 = tanggal2Controller.text;
    tanggalMasuk = tanggalMasukController.text;
    keperluan = keperluanController.text;
    teleponDarurat = teleponDaruratController.text;

    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/saveLeave';

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': isNiksales,
      'tanggal_awal': tanggal1,
      'tanggal_akhir': tanggal2,
      'tanggal_kerja': tanggalMasuk,
      'keterangan': keperluan,
      'telepon_darurat': teleponDarurat,
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Leave'];
      if (message == 'Save Success') {
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.success,
          desc: "Tambah Cuti berhasil",
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
          desc: "Tambah Cuti gagal",
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
                'Request Cuti',
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
                        fieldTanggal1(),
                        fieldTanggal2(),
                        fieldTanggalMasuk(),
                        fieldKeperluan(),
                        fieldTeleonDarurat(),
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
                          _saveLeave();
                        }
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
              ],
            ),
          );
  }

  Widget fieldTanggal1() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggal1Controller,
          validator: (DateTime? dateTime) {
            if (dateTime == null) {
              return 'Tanggal awal wajib diisi ya';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Mulai'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Poppins-Regular')),
    ]);
  }

  Widget fieldTanggal2() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggal2Controller,
          validator: (DateTime? dateTime) {
            if (dateTime == null) {
              return 'Tanggal akhir wajib diisi ya';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Akhir'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Poppins-Regular')),
    ]);
  }

  Widget fieldTanggalMasuk() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalMasukController,
          validator: (DateTime? dateTime) {
            if (dateTime == null) {
              return 'Tanggal Masuk wajib diisi ya';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Masuk'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Poppins-Regular')),
    ]);
  }

  Widget fieldKeperluan() {
    return TextFormField(
      controller: keperluanController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Keterangan wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Keterangan'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
    );
  }

  Widget fieldTeleonDarurat() {
    return TextFormField(
      controller: teleponDaruratController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Telepon Darurat wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Telepon Darurat'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(fontFamily: 'Poppins-Regular'),
    );
  }
}
