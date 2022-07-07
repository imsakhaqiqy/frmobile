import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class DetailCheckScreen extends StatefulWidget {
  String id;
  String tanggal;
  String jamMasuk;
  String absen;
  String status;
  String latitude;
  String longitude;
  String path;
  String jenisAbsensi;
  DetailCheckScreen(
    this.id,
    this.tanggal,
    this.jamMasuk,
    this.absen,
    this.status,
    this.latitude,
    this.longitude,
    this.path,
    this.jenisAbsensi,
  );
  @override
  _DetailCheckScreenState createState() => _DetailCheckScreenState();
}

class _DetailCheckScreenState extends State<DetailCheckScreen> {
  String status = '';
  final keteranganVerifikasiController = TextEditingController();

  Future dialogLoading() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {});

          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      FieldReqruitmentPalette.menuBluebird),
                ),
                height: 20,
                width: 20,
              )
            ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String foto = 'https://www.nabasa.co.id/field_recruitment/assets/' +
        widget.jenisAbsensi +
        '/' +
        widget.path;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FieldReqruitmentPalette.menuBluebird,
        title: Text(
          'Detail',
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await showGeneralDialog(
                        context: context,
                        barrierColor:
                            Colors.black12.withOpacity(0.6), // Background color
                        barrierDismissible: false,
                        barrierLabel: 'Dialog',
                        transitionDuration: Duration(
                            milliseconds:
                                400), // How long it takes to popup dialog after button click
                        pageBuilder: (_, __, ___) {
                          // Makes widget fullscreen
                          return SizedBox.expand(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: SizedBox.expand(
                                    child: PhotoView(
                                      imageProvider: NetworkImage(foto),
                                      backgroundDecoration: BoxDecoration(
                                          color: Colors.transparent),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox.expand(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Tutup',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default_image.png',
                      image: foto,
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        color: Colors.white,
                        width: double.infinity,
                        child: field('Tanggal', setNull(widget.tanggal))),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        color: Colors.white,
                        width: double.infinity,
                        child: field('Jam', setNull(widget.jamMasuk))),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        color: Colors.white,
                        width: double.infinity,
                        child: field('Keterangan',
                            setNull(widget.absen).toString().toUpperCase())),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        color: Colors.white,
                        width: double.infinity,
                        child: field('Status',
                            setNull(widget.status).toString().toUpperCase())),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget field(String field, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          field,
          style: TextStyle(color: FieldReqruitmentPalette.menuOther),
        ),
        Text(
          value,
        )
      ],
    );
  }
}
