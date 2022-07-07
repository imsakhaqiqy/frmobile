import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool visible = false;
  bool _loading2 = false;
  final pertanyaanController = TextEditingController();
  String pertanyaan = '';
  String? email, phone, whatsapp;

  Future getSetting() async {
    setState(() {
      _loading2 = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getSetting';

    //starting web api call
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message != '') {
        setState(() {
          _loading2 = false;
          email = message[0]['nilai'].toString();
          phone = message[1]['nilai'].toString();
          whatsapp = message[2]['nilai'].toString();
        });
      }
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      !await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // String _url = 'https://flutter.dev';
  // void _launchURL() async {
  //   if (!await launch(_url)) throw 'Could not launch $_url';
  // }

  void launchWhatsApp({
    @required String? phone,
    @required String? message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message!)}";
    }

    if (await canLaunch(url())) {
      !await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void _createEmail({@required String? email}) async {
    String emailaddress() {
      return 'mailto:$email?subject=Sample Subject&body=Hallo, apakah saya bisa dibantu ?';
    }

    if (await canLaunch(emailaddress())) {
      !await launch(emailaddress());
    } else {
      throw 'Could not Email';
    }
  }

  @override
  void initState() {
    super.initState();
    this.getSetting();
  }

  Widget build(BuildContext context) {
    return _loading2
        ? Container(
            color: Colors.white,
            child: Center(
                child: SpinKitThreeInOut(
              color: Colors.white,
              size: 30.0,
            )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: FieldReqruitmentPalette.menuBluebird,
              title: Text(
                'Bantuan',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white,
                ),
              ),
              actions: [],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Butuh Bantuan Dengan Layanan ?',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Team kami siap membantu anda setiap hari senin-jumat di 08.00-17.00 WIB',
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Kontak langsung',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _createEmail(email: email);
                          },
                          child: Icon(Icons.email_outlined),
                        ),
                        Text(
                          email!,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _makePhoneCall('tel:$phone');
                          },
                          child: Icon(Icons.phone),
                        ),
                        Text(
                          phone!,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            launchWhatsApp(
                                phone: whatsapp,
                                message: 'Halo, apakah bisa dibantu ?');
                          },
                          child: Icon(MdiIcons.whatsapp),
                        ),
                        Text(
                          whatsapp!,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
