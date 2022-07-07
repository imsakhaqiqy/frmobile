import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool visible = false;
  bool icon = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.bounceOut);
    _controller!.forward();
  }

  removePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("username");
    preferences.remove("password");
  }

  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation!,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: FieldReqruitmentPalette.menuBluebird,
            centerTitle: false,
            titleSpacing: 0.0,
            title: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isFullname,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isPosition,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )),
        backgroundColor: FieldReqruitmentPalette.grey200,
        body: WillPopScope(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: MultipleRoundedCurveClipper(),
                  child: Container(
                    height: 100,
                    color: FieldReqruitmentPalette.menuBluebird,
                    child: Center(
                      child: Text(""),
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.redAccent,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Info personal',
                                            style: TextStyle(
                                              fontFamily: 'Roboto-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/address');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.greenAccent,
                                          ),
                                          child: Icon(
                                            Icons.home_filled,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Info alamat',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/placement');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.blueAccent,
                                          ),
                                          child: Icon(
                                            Icons.work_outline,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Info pekerjaan',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/account_bank');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.amberAccent,
                                          ),
                                          child: Icon(
                                            MdiIcons.bank,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Info rekening',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/income');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.deepOrangeAccent,
                                          ),
                                          child: Icon(
                                            Icons.monetization_on,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Info payroll',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/support');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          child: Icon(
                                            Icons.support_agent,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Bantuan',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/faq');
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.indigoAccent,
                                          ),
                                          child: Icon(
                                            Icons.help_center,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'FAQ',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
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
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 470.0,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'Version 1.0.2',
                      style: TextStyle(
                        fontFamily: 'Roboto-Medium',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 510.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 2.0,
                      color: FieldReqruitmentPalette.menuBluebird,
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Center(
                            child: Text(
                              'Apakah Anda yakin ingin keluar ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color:
                                          FieldReqruitmentPalette.menuBluebird,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                                removePref();
                                SystemNavigator.pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Ya',
                                    style: TextStyle(
                                      color:
                                          FieldReqruitmentPalette.menuBluebird,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Keluar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            color: FieldReqruitmentPalette.menuBluebird,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: () async => false,
        ),
      ),
    );
  }
}
