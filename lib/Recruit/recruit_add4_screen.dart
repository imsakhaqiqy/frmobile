// ignore_for_file: null_check_always_fails

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:field_recruitment/Recruit/recruit_add5_screen.dart';
import 'package:field_recruitment/Visit/camera_visit_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:field_recruitment/constans.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AddRecruit4Screen extends StatefulWidget {
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

  AddRecruit4Screen(
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
  );

  State<AddRecruit4Screen> createState() => AddRecruit4ScreenState();
}

class AddRecruit4ScreenState extends State<AddRecruit4Screen> {
  // ignore: prefer_typing_uninitialized_variables
  String? fileName;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File? imageFilex1;
  File? imageFilex2;
  File? imageFilex3;
  bool visible = false;
  bool visiblex = false;
  String title = '';
  String? base64Image1;
  String? base64Image2;
  String? base64Image3;

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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Informasi Dokumen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Expanded(child: buildGridViewLampiran())],
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
                      onTap: () async {
                        if (imageFilex1 == null) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('Isi Pas photo dulu ya'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (imageFilex2 == null) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('Isi cv / resume dulu ya'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (imageFilex3 == null) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('Isi Photo KTP dulu ya'),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddRecruit5Screen(
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
                                widget.selectedKantor,
                                widget.selectedPengalamanMarketing,
                                base64Encode(imageFilex1!.readAsBytesSync()),
                                fileName
                                    .toString()
                                    .split('/')
                                    .last
                                    .replaceAll("'", ""),
                                base64Encode(imageFilex2!.readAsBytesSync()),
                                imageFilex2
                                    .toString()
                                    .split('/')
                                    .last
                                    .replaceAll("'", ""),
                                base64Encode(imageFilex3!.readAsBytesSync()),
                                imageFilex3
                                    .toString()
                                    .split('/')
                                    .last
                                    .replaceAll("'", ""),
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

  Widget buildGridViewLampiran() {
    // ignore: non_constant_identifier_names
    List<Text> xtext = [
      Text('Pas Photo'),
      Text('CV/Resume'),
      Text('Photo KTP'),
    ];
    List<Icon> xconx = [
      Icon(
        Icons.document_scanner_outlined,
      ),
      Icon(
        Icons.document_scanner,
      ),
      Icon(
        MdiIcons.creditCardScan,
      ),
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(3, (index) {
        return Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                xtext[index],
                (index == 0)
                    ? (imageFilex1 != null)
                        ? Card(
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Image.file(
                                    imageFilex1!,
                                    fit: BoxFit.fill,
                                    height: 50,
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
                                        imageFilex1 = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : IconButton(
                            icon: xconx[index],
                            iconSize: 50,
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Text('Gallery'),
                                              onTap: () async {
                                                var picture =
                                                    await ImagePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  imageFilex1 = picture;
                                                  base64Image1 = base64Encode(
                                                      imageFilex1!
                                                          .readAsBytesSync());
                                                  imageFilex1 = imageFilex1;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(8.0)),
                                            GestureDetector(
                                                child: Text('Camera'),
                                                onTap: () async {
                                                  imageFilex1 = (await Navigator
                                                      .push<File>(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  CameraVisitScreen())))!;
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                })
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          )
                    : (index == 1)
                        ? (imageFilex2 != null)
                            ? Card(
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Image.file(
                                        imageFilex2!,
                                        fit: BoxFit.fill,
                                        height: 50,
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
                                            imageFilex2 = null;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : IconButton(
                                icon: xconx[index],
                                iconSize: 50,
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Text('Gallery'),
                                                  onTap: () async {
                                                    var picture =
                                                        await ImagePicker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    setState(() {
                                                      imageFilex2 = picture;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0)),
                                                GestureDetector(
                                                    child: Text('Camera'),
                                                    onTap: () async {
                                                      imageFilex2 =
                                                          (await Navigator.push<
                                                                  File>(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      CameraVisitScreen())))!;
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              )
                        : (index == 2)
                            // ignore: unnecessary_null_comparison
                            ? (imageFilex3 != null)
                                ? Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Image.file(
                                            imageFilex3!,
                                            fit: BoxFit.fill,
                                            height: 50,
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
                                                imageFilex3 = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : IconButton(
                                    icon: xconx[index],
                                    iconSize: 50,
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      child: Text('Gallery'),
                                                      onTap: () async {
                                                        var picture = await ImagePicker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        setState(() {
                                                          imageFilex3 = picture;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0)),
                                                    GestureDetector(
                                                        child: Text('Camera'),
                                                        onTap: () async {
                                                          imageFilex3 = (await Navigator.push<
                                                                  File>(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      CameraVisitScreen())))!;
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        })
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  )
                            : Text('a')
              ],
            ));
      }),
    );
  }
}
