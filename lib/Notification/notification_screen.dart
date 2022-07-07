import 'dart:convert';

import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:field_recruitment/constans.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getNotification';
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
        if (json.decode(result.body)['Daftar_Notification'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Notification'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _nik(dynamic user) {
    return user['nik'];
  }

  String _judul(dynamic user) {
    return user['judul'];
  }

  String _keterangan(dynamic user) {
    return user['keterangan'];
  }

  String _status(dynamic user) {
    return user['status'];
  }

  String _createdAt(dynamic user) {
    return user['created_at'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  Future updateNotification() async {
    //showing CircularProgressIndicator
    setState(() {
      _isLoading = true;
    });

    //server save api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/updateNotification';

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': isNiksales,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Notification'];
      if (message['message'].toString() == 'Update Success') {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future getNotification() async {
    //showing CircularProgressIndicator
    setState(() {
      _isLoading = true;
    });

    //server save api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getNotificationCount';

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': isNiksales,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Notification'];
      setState(() {
        isNotification = message[0]['jml'].toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    updateNotification();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                updateNotification()
                    .then((value) => Navigator.pop(context, true));
              });
            }),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notifikasi',
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
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            _judul(_users[index]),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular'),
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
                              Expanded(
                                child: Text(
                                  _keterangan(_users[index]),
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
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
                            _createdAt(_users[index]),
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
              'Notifikasi tidak ditemukan',
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
