import 'package:field_recruitment/Incentive/tracking_screen.dart';
import 'package:field_recruitment/Provider/incentive_provider.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class IncentiveScreen extends StatefulWidget {
  @override
  _IncentiveScreenState createState() => _IncentiveScreenState();
}

class _IncentiveScreenState extends State<IncentiveScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Incentive',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                content: Text(
                  'Insentif bisa didapat jika marketing yang direkrut mendapat booking (plafond * tarif)',
                ),
                duration: Duration(seconds: 3),
              ));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<InsentifProvider>(context, listen: false)
            .getInsentif(InsentifItem(isNiksales)),
        color: Colors.red,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<InsentifProvider>(context, listen: false)
                .getInsentif(InsentifItem(isNiksales)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          FieldReqruitmentPalette.menuBluebird)),
                );
              }
              return Consumer<InsentifProvider>(
                builder: (context, data, _) {
                  if (data.dataInsentif.length == 0) {
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
                                  child: Icon(Icons.hourglass_empty, size: 70),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Incentive tidak ditemukan!',
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        itemCount: data.dataInsentif.length,
                        itemBuilder: (context, i) {
                          double nominal =
                              double.parse(data.dataInsentif[i].plafond);
                          double jumlah = nominal * double.parse(isTarif) / 100;
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                topLeft: Radius.circular(25.0),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    FieldReqruitmentPalette.menuBluebird,
                                    Color(0xffa6ffcb),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0),
                                ),
                              ),
                              child: InkWell(
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
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            data.dataInsentif[i].namaSales,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Tanggal Input',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            data.dataInsentif[i]
                                                .tanggalPencairan,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Debitur',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            data.dataInsentif[i].debitur,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Plafond',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            formatRupiah(
                                                data.dataInsentif[i].plafond),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
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
                                              color: FieldReqruitmentPalette
                                                  .menuBluebird,
                                            ),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Text(
                                          formatRupiah(jumlah.toString()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard(Color color, String cardNumber, String cardHolder,
      String cardExpiration, String status, String noAkad) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        height: 150,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(status, noAkad),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock('SALES', cardHolder),
                _buildDetailsBlock('INPUT', cardExpiration),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildLogosBlock(status, noAkad) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Tooltip(
            message: noAkad,
            child: Icon(
              MdiIcons.bank,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        iconStatus(status)
      ],
    );
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Belum Dibayar';
    } else {
      return 'Sudah Dibayar';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Tooltip(
          message: messageStatus(status),
          child: Icon(
            Icons.info,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          Icons.check,
          size: 20,
          color: Colors.white,
        ),
      );
    }
  }
}
