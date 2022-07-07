import 'dart:convert';

import 'package:field_recruitment/Recruit/detail_recruit.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:field_recruitment/constans.dart';

// ignore: must_be_immutable
class RecruitListScreen extends StatefulWidget {
  @override
  _RecruitListScreen createState() => _RecruitListScreen();
}

class _RecruitListScreen extends State<RecruitListScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getCandidate';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {
      'niksales': isNiksales,
    });
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Candidate'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Candidate'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _noKtp(dynamic user) {
    return user['no_ktp'];
  }

  String _namaLengkap(dynamic user) {
    return user['nama_lengkap'];
  }

  String _tempatLahir(dynamic user) {
    return user['tempat_lahir'];
  }

  String _tanggalLahir(dynamic user) {
    return user['tanggal_lahir'];
  }

  String _provinsi(dynamic user) {
    return user['provinsi'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _email(dynamic user) {
    return user['email'];
  }

  String _pendidikan(dynamic user) {
    return user['pendidikan'];
  }

  String _createdAt(dynamic user) {
    return user['created_at'];
  }

  String _updatedAt(dynamic user) {
    return user['updated_at'];
  }

  String _status(dynamic user) {
    return user['status'];
  }

  String _nikx(dynamic user) {
    return user['nikx'];
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
          'Daftar Recruitan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/information');
            },
            icon: Icon(Icons.person_add_alt_outlined),
          ),
        ],
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailRecruitScreen(
                        _id(_users[index]),
                        _nikx(_users[index]),
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _namaLengkap(_users[index]),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Regular'),
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
                                message: 'No KTP',
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _noKtp(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 11,
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
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _telepon(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 11,
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
                                message: 'Status',
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  _status(_users[index]),
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 11,
                                  ),
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
                            _updatedAt(_users[index]),
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 11,
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
              'Cari Candidate Yuk!',
              style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dapatkan insentif besar dari candidate kamu.',
              style: TextStyle(
                fontFamily: "Poppins-Regular",
                fontSize: 12,
              ),
            ),
          ]),
        );
      }
    }
  }
}
