import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/Checkin/camera_screen.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddPermissionScreen extends StatefulWidget {
  const AddPermissionScreen({Key? key}) : super(key: key);

  State<AddPermissionScreen> createState() => AddPermissionScreenState();
}

class AddPermissionScreenState extends State<AddPermissionScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File? imageFilex;
  bool visible = false;
  bool visiblex = false;
  final tanggal1Controller = TextEditingController();
  final tanggal2Controller = TextEditingController();
  final tanggalMasukController = TextEditingController();
  final descriptionController = TextEditingController();
  String? tanggal1;
  String? tanggal2;
  String? tanggalMasuk;
  String? keterangan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future _savePermission() async {
    loadingScreen(context);
    setState(() {
      visible = true;
    });

    tanggal1 = tanggal1Controller.text;
    tanggal2 = tanggal2Controller.text;
    tanggalMasuk = tanggalMasukController.text;
    keterangan = descriptionController.text;

    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/savePermission';

    //starting web api call
    String image = imageFilex.toString().split('/').last;
    var response = await http.post(url, body: {
      'niksales': isNiksales,
      'tanggal_awal': tanggal1,
      'tanggal_akhir': tanggal2,
      'tanggal_kerja': tanggalMasuk,
      'keterangan': keterangan,
      'path': image.replaceAll("'", ""),
      'image': base64Encode(imageFilex!.readAsBytesSync()),
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Permission'];
      if (message == 'Save Success') {
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.success,
          desc: "Tambah Izin berhasil",
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
          desc: "Tambah Izin gagal",
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
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Request Izin',
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
                        fieldKeterangan(),
                      ],
                    ),
                  ),
                ),
                (imageFilex != null)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Image.file(
                                  imageFilex!,
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: InkWell(
                                  child: Icon(
                                    Icons.remove_circle,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      imageFilex = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                (imageFilex == null)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          padding: const EdgeInsets.all(16.0),
                          child: FlatButton(
                            child: Text(
                              'Foto Izin',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                            onPressed: () async {
                              imageFilex = (await Navigator.push<File>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CameraPage())))!;
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
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
                          if (imageFilex == null) {
                            _scaffoldKey.currentState?.showSnackBar(SnackBar(
                              content: Text('Ambil foto izin dulu ya'),
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            _savePermission();
                          }
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
          decoration: InputDecoration(labelText: 'Tanggal Awal'),
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
              return 'Tanggal masuk wajib diisi ya';
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

  Widget fieldKeterangan() {
    return TextFormField(
      controller: descriptionController,
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
}
