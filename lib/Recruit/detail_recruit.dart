import 'dart:convert';

import 'package:field_recruitment/Activity/absensi_activity_screen.dart';
import 'package:field_recruitment/Activity/interaksi_activity_screen.dart';
import 'package:field_recruitment/Activity/pencairan_activity_screen.dart';
import 'package:field_recruitment/Activity/pipeline_activity_screen.dart';
import 'package:field_recruitment/Activity/simulasi_activity_screen.dart';
import 'package:field_recruitment/Provider/personal_provider.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailRecruitScreen extends StatefulWidget {
  String id;
  String nikx;
  DetailRecruitScreen(
    this.id,
    this.nikx,
  );
  @override
  _DetailRecruitScreenState createState() => new _DetailRecruitScreenState();
}

class _DetailRecruitScreenState extends State<DetailRecruitScreen> {
  bool visiblex = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          backgroundColor: FieldReqruitmentPalette.menuBluebird,
          title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Detail Informasi',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          actions: <Widget>[],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.bold), //For Selected tab
            unselectedLabelStyle: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.bold), //For Un-selected Tabs
            tabs: <Widget>[
              Tab(
                text: 'PRIBADI',
              ),
              Tab(
                text: 'PENGALAMAN KERJA',
              ),
              Tab(
                text: 'PENEMPATAN',
              ),
              Tab(
                text: 'DOKUMEN',
              ),
              Tab(
                text: 'AKTIVITAS',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            sliderPersonal(widget.id),
            sliderWorkExperience(widget.id),
            sliderPlacement(widget.id),
            sliderPhoto(widget.id),
            sliderActivity(widget.id),
          ],
        ),
      ),
    );
  }

  Widget sliderPersonal(id) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<PersonalProvider>(context, listen: false)
            .getPersonal(PersonalItem(
          id,
        )),
        builder: (context, snapshot) {
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 70,
                        color: Colors.black54,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Data tidak ditemukan',
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ]),
            );
          } else {
            return Consumer<PersonalProvider>(
              builder: (context, data, _) {
                if (data.dataPersonal.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.hourglass_empty_outlined,
                                size: 50,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          Text(
                            'Data tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataPersonal.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldDebitur(
                              'Nomor KTP', data.dataPersonal[index].nomorKtp),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Nama Lengkap',
                              data.dataPersonal[index].namaLengkap),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Tempat Lahir',
                              data.dataPersonal[index].tempatLahir),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Tanggal Lahir',
                              data.dataPersonal[index].tanggalLahir),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Kota / Kabupaten',
                              data.dataPersonal[index].kotaKab),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Telepon', data.dataPersonal[index].telepon),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Email', data.dataPersonal[index].email),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Pendidikan',
                              data.dataPersonal[index].pendidikan),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget sliderWorkExperience(id) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<PersonalProvider>(context, listen: false)
            .getPersonal(PersonalItem(
          id,
        )),
        builder: (context, snapshot) {
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 70,
                        color: Colors.black54,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Data tidak ditemukan',
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ]),
            );
          } else {
            return Consumer<PersonalProvider>(
              builder: (context, data, _) {
                if (data.dataPersonal.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.hourglass_empty_outlined,
                                size: 50,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          Text(
                            'Data tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataPersonal.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldDebitur('Nama Perusahaan',
                              setNull(data.dataPersonal[index].perusahaan1)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Posisi',
                              setNull(data.dataPersonal[index].posisi1)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Mulai Bekerja',
                              setNull(data.dataPersonal[index].masuk1)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Selesai Bekerja',
                              setNull(data.dataPersonal[index].keluar1)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Nama Perusahaan',
                              setNull(data.dataPersonal[index].perusahaan2)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Posisi',
                              setNull(data.dataPersonal[index].posisi2)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Mulai Bekerja',
                              setNull(data.dataPersonal[index].masuk2)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Selesai Bekerja',
                              setNull(data.dataPersonal[index].keluar2)),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget sliderPlacement(id) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<PersonalProvider>(context, listen: false)
            .getPersonal(PersonalItem(
          id,
        )),
        builder: (context, snapshot) {
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 70,
                        color: Colors.black54,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Data tidak ditemukan',
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ]),
            );
          } else {
            return Consumer<PersonalProvider>(
              builder: (context, data, _) {
                if (data.dataPersonal.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.hourglass_empty_outlined,
                                size: 50,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          Text(
                            'Data tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataPersonal.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldDebitur('Pengalaman Marketing',
                              data.dataPersonal[index].pengalamanMarketing),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Perusahaan',
                              data.dataPersonal[index].perusahaan),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget sliderPhoto(id) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<PersonalProvider>(context, listen: false)
            .getPersonal(PersonalItem(
          id,
        )),
        builder: (context, snapshot) {
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 70,
                        color: Colors.black54,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Data tidak ditemukan',
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ]),
            );
          } else {
            return Consumer<PersonalProvider>(
              builder: (context, data, _) {
                if (data.dataPersonal.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.hourglass_empty_outlined,
                                size: 50,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          Text(
                            'Data tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataPersonal.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      String foto = 'https://www.nabasa.co.id/marsitacademy/' +
                          setNull(data.dataPersonal[index].pasfoto);
                      String foto2 = 'https://www.nabasa.co.id/marsitacademy/' +
                          setNull(data.dataPersonal[index].cv);
                      String foto3 = 'https://www.nabasa.co.id/marsitacademy/' +
                          setNull(data.dataPersonal[index].ktp);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await showGeneralDialog(
                                context: context,
                                barrierColor: Colors.black12
                                    .withOpacity(0.6), // Background color
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
                                              backgroundDecoration:
                                                  BoxDecoration(
                                                      color:
                                                          Colors.transparent),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox.expand(
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                            child: fieldDebiturImage('Pas Foto', setNull(foto)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showGeneralDialog(
                                context: context,
                                barrierColor: Colors.black12
                                    .withOpacity(0.6), // Background color
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
                                              backgroundDecoration:
                                                  BoxDecoration(
                                                      color:
                                                          Colors.transparent),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox.expand(
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                            child: fieldDebiturImage(
                                'CV / Resume', setNull(foto2)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () async {
                                await showGeneralDialog(
                                  context: context,
                                  barrierColor: Colors.black12
                                      .withOpacity(0.6), // Background color
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
                                                imageProvider:
                                                    NetworkImage(foto),
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                        color:
                                                            Colors.transparent),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox.expand(
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'Tutup',
                                                  style:
                                                      TextStyle(fontSize: 20),
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
                              child: fieldDebiturImage('KTP', setNull(foto3))),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget sliderInterview(id) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<PersonalProvider>(context, listen: false)
            .getPersonal(PersonalItem(
          id,
        )),
        builder: (context, snapshot) {
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    FieldReqruitmentPalette.menuBluebird),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 70,
                        color: Colors.black54,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Interview empty',
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ]),
            );
          } else {
            return Consumer<PersonalProvider>(
              builder: (context, data, _) {
                if (data.dataPersonal.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.hourglass_empty_outlined,
                                size: 50,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          Text(
                            'Interview empty',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataPersonal.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldDebitur('Pertanyaan 1',
                              data.dataPersonal[index].jawaban1),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Pertanyaan 2',
                              data.dataPersonal[index].jawaban2),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Pertanyaan 3',
                              data.dataPersonal[index].jawaban3),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Pertanyaan 4',
                              data.dataPersonal[index].jawaban4),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Pertanyaan 5',
                              data.dataPersonal[index].jawaban5),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget sliderActivity(id) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.nikx != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AbsensiActivityScreen(widget.nikx)));
              } else {
                Alert(
                  context: context,
                  style: AlertStyle(
                    overlayColor: Colors.transparent.withAlpha(125),
                    backgroundColor: Colors.white,
                    animationType: AnimationType.fromLeft,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                    descTextAlign: TextAlign.start,
                    animationDuration: Duration(milliseconds: 400),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(
                      color: Colors.red,
                    ),
                    alertAlignment: Alignment.center,
                  ),
                  type: AlertType.info,
                  desc: "Status Karyawan Belum Penempatan",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.cyan,
                      radius: BorderRadius.circular(0.0),
                    ),
                  ],
                ).show();
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: FieldReqruitmentPalette.menuBluebird,
                        width: 20), // red as border color
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Absensi',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade50,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.nikx != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        InteraksiActivityScreen(widget.nikx)));
              } else {
                Alert(
                  context: context,
                  style: AlertStyle(
                    overlayColor: Colors.transparent.withAlpha(125),
                    backgroundColor: Colors.white,
                    animationType: AnimationType.fromLeft,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                    descTextAlign: TextAlign.start,
                    animationDuration: Duration(milliseconds: 400),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(
                      color: Colors.red,
                    ),
                    alertAlignment: Alignment.center,
                  ),
                  type: AlertType.info,
                  desc: "Status Karyawan Belum Penempatan",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.cyan,
                      radius: BorderRadius.circular(0.0),
                    ),
                  ],
                ).show();
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: FieldReqruitmentPalette.menuBluebird,
                        width: 20), // red as border color
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Interaksi',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade50,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.nikx != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PipelineActivityScreen(widget.nikx)));
              } else {
                Alert(
                  context: context,
                  style: AlertStyle(
                    overlayColor: Colors.transparent.withAlpha(125),
                    backgroundColor: Colors.white,
                    animationType: AnimationType.fromLeft,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                    descTextAlign: TextAlign.start,
                    animationDuration: Duration(milliseconds: 400),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(
                      color: Colors.red,
                    ),
                    alertAlignment: Alignment.center,
                  ),
                  type: AlertType.info,
                  desc: "Status Karyawan Belum Penempatan",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.cyan,
                      radius: BorderRadius.circular(0.0),
                    ),
                  ],
                ).show();
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: FieldReqruitmentPalette.menuBluebird,
                        width: 20), // red as border color
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Pipeline',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade50,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.nikx != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PencairanActivityScreen(widget.nikx)));
              } else {
                Alert(
                  context: context,
                  style: AlertStyle(
                    overlayColor: Colors.transparent.withAlpha(125),
                    backgroundColor: Colors.white,
                    animationType: AnimationType.fromLeft,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                    descTextAlign: TextAlign.start,
                    animationDuration: Duration(milliseconds: 400),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(
                      color: Colors.red,
                    ),
                    alertAlignment: Alignment.center,
                  ),
                  type: AlertType.info,
                  desc: "Status Karyawan Belum Penempatan",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.cyan,
                      radius: BorderRadius.circular(0.0),
                    ),
                  ],
                ).show();
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: FieldReqruitmentPalette.menuBluebird,
                        width: 20), // red as border color
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Pencairan',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade50,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.nikx != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SimulasiActivityScreen(widget.nikx)));
              } else {
                Alert(
                  context: context,
                  style: AlertStyle(
                    overlayColor: Colors.transparent.withAlpha(125),
                    backgroundColor: Colors.white,
                    animationType: AnimationType.fromLeft,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                    descTextAlign: TextAlign.start,
                    animationDuration: Duration(milliseconds: 400),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(
                      color: Colors.red,
                    ),
                    alertAlignment: Alignment.center,
                  ),
                  type: AlertType.info,
                  desc: "Status Karyawan Belum Penempatan",
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.cyan,
                      radius: BorderRadius.circular(0.0),
                    ),
                  ],
                ).show();
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: FieldReqruitmentPalette.menuBluebird,
                        width: 20), // red as border color
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Simulasi',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green.shade50,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldDebitur(title, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: FieldReqruitmentPalette.menuBluebird,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Colors.black,
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget fieldDebiturImage(title, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: FieldReqruitmentPalette.menuBluebird,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              value,
              width: 50,
              height: 50,
            )
          ],
        ))
      ],
    );
  }
}
