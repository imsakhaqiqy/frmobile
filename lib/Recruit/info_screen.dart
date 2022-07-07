import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool visible = false;
  List<String> tugasList = [];
  List<String> syaratList = [];
  List<String> benefitList = [];

  Future getTugas() async {
    setState(() {
      visible = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getTugas';

    //starting web api call
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Tugas'];
      if (message != '') {
        setState(() {
          for (int a = 0;
              a < json.decode(response.body)['Daftar_Tugas'].length;
              a++) {
            tugasList.add(message[a]['deskripsi']);
          }
          visible = false;
        });
      }
    }
  }

  Future getSyarat() async {
    setState(() {
      visible = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getSyarat';

    //starting web api call
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Syarat'];
      if (message != '') {
        setState(() {
          for (int a = 0;
              a < json.decode(response.body)['Daftar_Syarat'].length;
              a++) {
            syaratList.add(message[a]['deskripsi']);
          }
          visible = false;
        });
      }
    }
  }

  Future getBenefit() async {
    setState(() {
      visible = true;
    });
    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getBenefit';

    //starting web api call
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Benefit'];
      if (message != '') {
        setState(() {
          for (int a = 0;
              a < json.decode(response.body)['Daftar_Benefit'].length;
              a++) {
            benefitList.add(message[a]['deskripsi']);
          }
          visible = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getTugas();
    getSyarat();
    getBenefit();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          backgroundColor: FieldReqruitmentPalette.menuBluebird,
          title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Informasi',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addrecruit');
              },
              icon: Icon(Icons.person_add_alt_outlined),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.bold), //For Selected tab
            unselectedLabelStyle: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.bold), //For Un-selected Tabs
            tabs: <Widget>[
              Tab(
                text: 'Uraian Tugas',
              ),
              Tab(
                text: 'Persyaratan',
              ),
              Tab(
                text: 'Benefit',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _tugasBuildList(),
            _syaratBuildList(),
            _benefitBuildList(),
          ],
        ),
      ),
    );
  }

  Widget _tugasBuildList() {
    if (tugasList.length > 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: tugasList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text(tugasList[index]),
            )),
          );
        },
      );
    } else {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SpinKitThreeInOut(
            color: Colors.black,
            size: 30.0,
          )
        ]),
      );
    }
  }

  Widget _syaratBuildList() {
    if (syaratList.length > 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: syaratList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text(syaratList[index]),
            )),
          );
        },
      );
    } else {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SpinKitThreeInOut(
            color: Colors.black,
            size: 30.0,
          )
        ]),
      );
    }
  }

  Widget _benefitBuildList() {
    if (benefitList.length > 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: benefitList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: ListTile(
              title: Text(benefitList[index]),
            )),
          );
        },
      );
    } else {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SpinKitThreeInOut(
            color: Colors.black,
            size: 30.0,
          )
        ]),
      );
    }
  }
}
