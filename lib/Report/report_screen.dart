import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:field_recruitment/Provider/checkin_provider.dart';
import 'package:field_recruitment/Provider/checkout_provider.dart';
import 'package:field_recruitment/Provider/visit_provider.dart';
import 'package:field_recruitment/Report/detail_check_report.dart';
import 'package:field_recruitment/Report/detail_visit_report.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
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
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Laporan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
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
                          'assets/images/check-in.png',
                          width: 32,
                          height: 32,
                        ),
                        text: "Check In",
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/images/check-out.png',
                          width: 32,
                          height: 32,
                        ),
                        text: "Check Out",
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/images/visitor.png',
                          width: 32,
                          height: 32,
                        ),
                        text: "Visit",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        sliderCheckIn(),
                        sliderCheckOut(),
                        sliderVisit(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderCheckIn() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<CheckInProvider>(context, listen: false)
            .getCheckin(CheckInItem(
          isNiksales,
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
                  'Check In tidak ditemukan',
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
            return Consumer<CheckInProvider>(
              builder: (context, data, _) {
                if (data.dataCheckin.length == 0) {
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
                            'Check In tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataCheckin.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailCheckScreen(
                                      data.dataCheckin[index].id,
                                      data.dataCheckin[index].tanggal,
                                      data.dataCheckin[index].jamMasuk,
                                      data.dataCheckin[index].absen,
                                      data.dataCheckin[index].status,
                                      data.dataCheckin[index].latitude,
                                      data.dataCheckin[index].longitude,
                                      data.dataCheckin[index].path,
                                      'checkin',
                                    )));
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: FieldReqruitmentPalette.purple,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      data.dataCheckin[index].absen
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Tanggal',
                                      ),
                                    ),
                                    Text(
                                      data.dataCheckin[index].tanggal,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Jam',
                                      ),
                                    ),
                                    Text(
                                      data.dataCheckin[index].jamMasuk,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: FieldReqruitmentPalette.purple,
                                      ),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    data.dataCheckin[index].status
                                        .replaceAll('_', ' ')
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget sliderCheckOut() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<CheckOutProvider>(context, listen: false)
            .getCheckout(CheckOutItem(
          isNiksales,
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
                  'Check Out tidak ditemukan',
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
            return Consumer<CheckOutProvider>(
              builder: (context, data, _) {
                if (data.dataCheckout.length == 0) {
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
                            'Check Out tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataCheckout.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailCheckScreen(
                                      data.dataCheckout[index].id,
                                      data.dataCheckout[index].tanggal,
                                      data.dataCheckout[index].jamMasuk,
                                      data.dataCheckout[index].absen,
                                      data.dataCheckout[index].status,
                                      data.dataCheckout[index].latitude,
                                      data.dataCheckout[index].longitude,
                                      data.dataCheckout[index].path,
                                      'checkout',
                                    )));
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: FieldReqruitmentPalette.purple,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      data.dataCheckout[index].absen
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Tanggal',
                                      ),
                                    ),
                                    Text(
                                      data.dataCheckout[index].tanggal,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Jam',
                                      ),
                                    ),
                                    Text(
                                      data.dataCheckout[index].jamMasuk,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: FieldReqruitmentPalette.purple,
                                      ),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    data.dataCheckout[index].status
                                        .replaceAll('_', ' ')
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget sliderVisit() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<VisitProvider>(context, listen: false)
            .getVisit(VisitItem(
          isNiksales,
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
                  'Visit tidak ditemukan',
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
            return Consumer<VisitProvider>(
              builder: (context, data, _) {
                if (data.dataVisit.length == 0) {
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
                            'Visit tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataVisit.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailReportScreen(
                                      data.dataVisit[index].id,
                                      data.dataVisit[index].tanggal,
                                      data.dataVisit[index].jam,
                                      data.dataVisit[index].namaLengkap,
                                      data.dataVisit[index].telepon,
                                      data.dataVisit[index].keterangan,
                                      data.dataVisit[index].latitude,
                                      data.dataVisit[index].longitude,
                                      data.dataVisit[index].foto,
                                      data.dataVisit[index].tandaTangan,
                                    )));
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: FieldReqruitmentPalette.purple,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      data.dataVisit[index].namaLengkap,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Tanggal',
                                      ),
                                    ),
                                    Text(
                                      data.dataVisit[index].tanggal,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Telepon',
                                      ),
                                    ),
                                    Text(
                                      data.dataVisit[index].telepon,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: FieldReqruitmentPalette.purple,
                                      ),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    data.dataVisit[index].keterangan,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
