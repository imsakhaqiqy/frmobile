import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:field_recruitment/Checkin/camera_screen.dart';
import 'package:field_recruitment/constans.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({Key? key}) : super(key: key);

  State<CheckinScreen> createState() => CheckinScreenState();
}

class CheckinScreenState extends State<CheckinScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File? imageFilex;
  bool visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    Future _saveCheckin() async {
      loadingScreen(context);
      setState(() {
        visible = true;
      });
      var url =
          'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/saveCheckin';

      //starting web api call
      String image = imageFilex.toString().split('/').last;
      var response = await http.post(url, body: {
        'niksales': isNiksales,
        'latitude': isLat.toString(),
        'longitude': isLong.toString(),
        'path': image.replaceAll("'", ""),
        'image': base64Encode(imageFilex!.readAsBytesSync()),
      });
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Save_Absensi'];
        if (message == 'Save Success') {
          Alert(
            context: context,
            style: alertStyle(),
            type: AlertType.success,
            desc: "Check In berhasil",
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
            desc: "Check In gagal",
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
          'Check In',
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
          Card(
            elevation: 4,
            color: Color(0xFF6B5B95),
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Check In dapat dilakukan setiap hari mulai pukul 07.00 - 09.00 WIB.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
                    height: 250,
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
              )),
          SizedBox(
            height: 10,
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
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    padding: const EdgeInsets.all(16.0),
                    child: FlatButton(
                      child: Text(
                        'Foto Selfie',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      onPressed: () async {
                        imageFilex = (await Navigator.push<File>(context,
                            MaterialPageRoute(builder: (_) => CameraPage())))!;
                        setState(() {});
                      },
                    ),
                  ),
                )
              : SizedBox(),
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
                  if (imageFilex == null) {
                    _scaffoldKey.currentState?.showSnackBar(SnackBar(
                      content: Text('Foto selfie dulu ya :)'),
                      duration: Duration(seconds: 3),
                    ));
                  } else {
                    _saveCheckin();
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
          ),
        ],
      ),
    );
  }
}
