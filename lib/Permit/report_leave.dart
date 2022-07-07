import 'package:field_recruitment/Provider/leave_provider.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportLeaveScreen extends StatefulWidget {
  @override
  _ReportLeaveScreenState createState() => _ReportLeaveScreenState();
}

class _ReportLeaveScreenState extends State<ReportLeaveScreen>
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
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Laporan Cuti',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: slider(),
        ),
      ),
    );
  }

  Widget slider() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: Provider.of<LeaveProvider>(context, listen: false)
            .getLeave(LeaveItem(
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
                  'Laporan Cuti tidak ditemukan',
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
            return Consumer<LeaveProvider>(
              builder: (context, data, _) {
                if (data.dataLeave.length == 0) {
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
                            'Laporan Cuti tidak ditemukan',
                          ),
                        ]),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.dataLeave.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {},
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
                                      'PENGAJUAN CUTI',
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
                                        'Tanggal Cuti',
                                      ),
                                    ),
                                    Text(
                                      data.dataLeave[index].tanggalAwal +
                                          ' sd ' +
                                          data.dataLeave[index].tanggalAkhir,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Tanggal Masuk',
                                      ),
                                    ),
                                    Text(
                                      data.dataLeave[index].tanggalKerja,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Keterangan',
                                      ),
                                    ),
                                    Text(
                                      data.dataLeave[index].keterangan,
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
                                    data.dataLeave[index].status,
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
