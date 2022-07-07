import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _loading = false;
  String? telepon;
  final formKey = GlobalKey<FormState>();

  //getting value from TextField widget.
  final teleponController = TextEditingController();

  var alertStyle = AlertStyle(
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
  );

  Future kirimForget() async {
    setState(() {
      _loading = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/forgetPassword';
    telepon = teleponController.text;
    print(telepon);
    //starting web api call
    var response = await http.post(url, body: {'telepon': telepon});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Request_Forget'];
      print(message);
      if (message['message'].toString() == 'Forget Success') {
        setState(() {
          _loading = false;
        });
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.success,
          desc: "Password berhasil dikirim ke nomor Anda.",
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FieldReqruitmentPalette.menuBluebird,
        title: Text(
          'Lupa Password',
          style: TextStyle(
            fontFamily: 'Poppins-Regular',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: FieldReqruitmentPalette.grey200,
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        fieldTelepon(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '*Silakan masukkan nomor telepon yang terdaftar di aplikasi FR-Mobile',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fieldKirim()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Telepon diperlukan';
        } else if (value.length < 10) {
          return 'Telepon minimal 10 digit';
        } else if (value.length > 13) {
          return 'Telepon maksimal 13 digit';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "e.g 08123456789",
          hintStyle: TextStyle(fontFamily: 'Poppins-Regular'),
          labelText: "Telepon"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontSize: 12, fontFamily: 'Poppins-Regular'),
    );
  }

  Widget fieldKirim() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: FieldReqruitmentPalette.menuBluebird,
        color: FieldReqruitmentPalette.menuBluebird,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () {
            kirimForget();
          },
          child: Center(
            child: _loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Text(
                    'Kirim',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
          ),
        ),
      ),
    );
  }
}
