import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:field_recruitment/Visit/camera_visit_screen.dart';
import 'package:field_recruitment/Visit/signature_screen.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:field_recruitment/constans.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({Key? key}) : super(key: key);

  State<VisitScreen> createState() => VisitScreenState();
}

class VisitScreenState extends State<VisitScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final formKey = GlobalKey<FormState>();
  File? imageFilex;
  File? imageFilex2;
  ByteData _img = ByteData(0);
  bool visible = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final namaVisitController = TextEditingController();
  final teleponVisitController = TextEditingController();
  final keteranganVisitController = TextEditingController();
  String? namaLengkap;
  String? telepon;
  String? keterangan;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future _saveVisit() async {
    loadingScreen(context);
    setState(() {
      visible = true;
    });

    namaLengkap = namaVisitController.text;
    telepon = teleponVisitController.text;
    keterangan = keteranganVisitController.text;

    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/saveVisit';

    //starting web api call
    String image = imageFilex.toString().split('/').last;
    final directory = await getApplicationDocumentsDirectory();
    final pathOfImage = await File('${directory.path}/legendary.png').create();
    final Uint8List bytes = _img.buffer.asUint8List();
    await pathOfImage.writeAsBytes(bytes);
    var response = await http.post(url, body: {
      'niksales': isNiksales,
      'nama_lengkap': namaLengkap,
      'telepon': telepon,
      'keterangan': keterangan,
      'location': '',
      'latitude': isLat.toString(),
      'longitude': isLong.toString(),
      'path': image.replaceAll("'", ""),
      'image': base64Encode(imageFilex!.readAsBytesSync()),
      'path2': 'ttd_' + image.replaceAll("'", ""),
      'image2': base64Encode(pathOfImage.readAsBytesSync()),
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Visit'];
      if (message == 'Save Success') {
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.success,
          desc: "Visit berhasil",
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
          desc: "Visit gagal",
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
    Completer<GoogleMapController> _controller = Completer();

    final LatLng _kMapYour = LatLng(isLat!, isLong!);

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(isLat!, isLong!),
      zoom: 15.0,
    );

    Set<Marker> _createMarker() {
      return {
        Marker(
          markerId: MarkerId("marker_2"),
          position: _kMapYour,
          infoWindow: InfoWindow(title: 'Kamu disini'),
        ),
      };
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Visit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Posisi Kamu'),
                ),
                Container(
                  height: 259,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _createMarker(),
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  fieldNamaVisit(),
                  fieldTeleponVisit(),
                  fieldKeteranganVisit(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            //color: Colors.white,
            child: Row(
              children: <Widget>[Expanded(child: buildGridViewLampiran())],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
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
                        content: Text('Ambil foto visit dulu ya'),
                        duration: Duration(seconds: 3),
                      ));
                    } else if (_img.buffer.lengthInBytes == 0) {
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(
                        content: Text('Tanda tangan visit dulu ya'),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      _saveVisit();
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
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget fieldNamaVisit() {
    return TextFormField(
      controller: namaVisitController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Lengkap wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(
        fontFamily: 'Poppins-Regular',
        fontSize: 14,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldTeleponVisit() {
    return TextFormField(
      controller: teleponVisitController,
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
      style: const TextStyle(
        fontFamily: 'Poppins-Regular',
        fontSize: 14,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget fieldKeteranganVisit() {
    return TextFormField(
      controller: keteranganVisitController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Keterangan wajib diisi ya';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: 'Keterangan'),
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(
        fontFamily: 'Poppins-Regular',
        fontSize: 14,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildGridViewLampiran() {
    // ignore: non_constant_identifier_names
    List<Icon> xconx = [
      Icon(
        Icons.camera_alt_outlined,
      ),
      Icon(
        MdiIcons.pen,
      ),
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(2, (index) {
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
              (index == 0)
                  ? (imageFilex != null)
                      ? Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Image.file(
                                  imageFilex!,
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
                                      imageFilex = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : IconButton(
                          icon: xconx[index],
                          iconSize: 30,
                          onPressed: () async {
                            if (index == 0) {
                              imageFilex = (await Navigator.push<File>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CameraVisitScreen())))!;
                              setState(() {});
                            }
                          },
                        )
                  : (_img.buffer.lengthInBytes == 0)
                      ? IconButton(
                          icon: xconx[index],
                          iconSize: 30,
                          onPressed: () async {
                            if (index == 1) {
                              _img = (await Navigator.push<ByteData>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignatureScreen())))!;
                              setState(() {});
                            }
                          },
                        )
                      : Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: <Widget>[
                              LimitedBox(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 14,
                                maxWidth: 200.0,
                                child: Image.memory(
                                  _img.buffer.asUint8List(),
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
                                      _img = ByteData(0);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        );
      }),
    );
  }
}
