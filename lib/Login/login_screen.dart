import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formLoginKey = GlobalKey<FormState>();
  bool visible = false;
  bool checkedValue = false;
  bool _isHidden = true;
  String? usernamePref;
  String? passwordPref;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();
    //this.getAppVersion();
    getPref();
    getAppVersion();
  }

  final String url =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getVersion';
  String? versionId;
  String versionIdApp = '1.0.2';

  Future getAppVersion() async {
    setState(() {
      visible = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body)['Daftar_Version'];
      setState(() {
        versionId = resBody[0]['version_id'];
      });
      if (versionIdApp != versionId) {
        alertBalance(context);
      }
      setState(() {
        visible = false;
      });
    }
  }

  Future<void> setPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
    prefs.setString('password', passwordController.text);
  }

  Future<void> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernamePref = preferences.getString("username") == null
        ? ''
        : preferences.getString("username");
    passwordPref = preferences.getString("password") == null
        ? ''
        : preferences.getString("password");
    setState(() {
      usernameController.text = usernamePref!;
      passwordController.text = passwordPref!;
      if (usernamePref != '' && passwordPref != '') {
        checkedValue = true;
      }
    });
  }

  Future userLogin() async {
    //showing CircularProgressIndicator
    loadingScreen(context);
    setState(() {
      visible = true;
    });

    //getting value from controller
    String uname = usernameController.text;
    String nik = passwordController.text;

    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getLogin';

    //starting web api call
    var response = await http.post(url, body: {
      'uname': uname,
      'nik': nik,
    });

    //if the response message is matched
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Login'];
      if (message['message'].toString() == 'Login Success') {
        setState(() {
          visible = false;
          isLogin = true;
          isUsername = message['uname'];
          isNiksales = message['nik'];
          isFullname = message['uname'];
          isPoints = '1000';
          isPosition = 'Field Recruitment';
          isPict = message['pict'];
          isVisit = message['visit'] == null ? '0' : message['visit'];
          isRecruit = message['recruit'] == null ? '0' : message['recruit'];
          isTarif = message['tarif'];
        });
        Navigator.of(context).pop();
      } else {
        setState(() {
          visible = false;
        });
        Alert(
          context: context,
          style: alertStyle(),
          type: AlertType.error,
          desc: "Username tidak ditemukan",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show().then((value) {
          Navigator.of(context).pop();
        });
      }
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return visible
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: const Text('FR-Mobile',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45)),
                    ),
                  ],
                ),
                Form(
                  key: formLoginKey,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'username diperlukan';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'USERNAME',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 13),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.black45,
                                size: 25,
                              ),
                            ),
                            style: const TextStyle(color: Colors.black45),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password diperlukan';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 13),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black45,
                                size: 25,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _toggleVisibility();
                                },
                                icon: const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black45),
                          ),
                          const SizedBox(height: 5.0),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CheckboxListTile(
                              checkColor: Colors.black45,
                              activeColor: Colors.black45,
                              title: const Text(
                                'Simpan username',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: 'Lato-Regular',
                                    fontSize: 13),
                              ),
                              value: checkedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = !checkedValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- leading Checkbox
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          SizedBox(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: FieldReqruitmentPalette.grey,
                              color: FieldReqruitmentPalette.menuBluebird,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {
                                  if (formLoginKey.currentState!.validate()) {
                                    userLogin().then((value) {
                                      if (isLogin) {
                                        setPref();
                                        Navigator.pushNamed(
                                            context, '/landing');
                                      }
                                    });
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    'MASUK',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: const Alignment(1.0, 0.0),
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 20,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/forgotpassword');
                              },
                              child: const Text(
                                'Lupa Password',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ));
  }
}
