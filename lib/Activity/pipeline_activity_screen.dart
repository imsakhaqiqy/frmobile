import 'dart:convert';

import 'package:field_recruitment/Recruit/detail_recruit.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:field_recruitment/constans.dart';

// ignore: must_be_immutable
class PipelineActivityScreen extends StatefulWidget {
  String nik;
  PipelineActivityScreen(this.nik);
  @override
  _PipelineActivityScreen createState() => _PipelineActivityScreen();
}

class _PipelineActivityScreen extends State<PipelineActivityScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getPipelineActivity';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {
      'nik': widget.nik,
    });
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Pipeline'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Pipeline'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _tanggal(dynamic user) {
    return user['tgl_pipeline'];
  }

  String _cadeb(dynamic user) {
    return user['cadeb'];
  }

  String _noKtp(dynamic user) {
    return user['no_ktp'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _nominal(dynamic user) {
    return user['nominal'];
  }

  String _cabang(dynamic user) {
    return user['cabang'];
  }

  String _keterangan(dynamic user) {
    return user['keterangan'];
  }

  String _status(dynamic user) {
    return user['status'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Pipeline Activitas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
        child: CircularProgressIndicator(
          color: FieldReqruitmentPalette.menuBluebird,
        ),
      );
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    ;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _cadeb(_users[index]),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Tanggal',
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _tanggal(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Telepon',
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _telepon(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Nominal',
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatRupiah(_nominal(_users[index])),
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          Text(
                            statusPipeline(_status(_users[index])),
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Pipeline tidak ditemukan',
              style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }
}
