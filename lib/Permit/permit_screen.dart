import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:field_recruitment/Provider/checkin_provider.dart';
import 'package:field_recruitment/Provider/checkout_provider.dart';
import 'package:field_recruitment/Provider/visit_provider.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermitScreen extends StatefulWidget {
  @override
  _PermitScreenState createState() => _PermitScreenState();
}

class _PermitScreenState extends State<PermitScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.bounceOut);
    _controller!.forward();
  }

  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation!,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Permit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ButtonsTabBar(
                  contentPadding: EdgeInsets.all(4.0),
                  backgroundColor: Colors.red,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        'assets/images/exit (1).png',
                        width: 32,
                        height: 32,
                      ),
                      text: "Cuti",
                    ),
                    Tab(
                      icon: Image.asset(
                        'assets/images/sick.png',
                        width: 32,
                        height: 32,
                      ),
                      text: "Sakit",
                    ),
                    Tab(
                      icon: Image.asset(
                        'assets/images/permission.png',
                        width: 32,
                        height: 32,
                      ),
                      text: "Izin",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/addleave');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: FieldReqruitmentPalette
                                              .menuBluebird,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      'Request Cuti',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/reportleave');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color:
                                              FieldReqruitmentPalette.menuTix,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text('Laporan'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/addsick');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: FieldReqruitmentPalette
                                              .menuBluebird,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text('Request Sakit'),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/reportsick');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color:
                                              FieldReqruitmentPalette.menuTix,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text('Laporan'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/addpermission');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: FieldReqruitmentPalette
                                              .menuBluebird,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text('Request Izin'),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/reportpermission');
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color:
                                              FieldReqruitmentPalette.menuTix,
                                          width: 20), // red as border color
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text('Laporan'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
