import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class KotaKabupatenScreen extends StatefulWidget {
  @override
  _KotaKabupatenScreen createState() => _KotaKabupatenScreen();
}

class _KotaKabupatenScreen extends State<KotaKabupatenScreen> {
  final _formKey = GlobalKey<FormState>();
  final searchingController = TextEditingController();
  bool _isLoading = false;
  final String url =
      'https://www.tetranabasainovasi.com/api_marsit_v1/recruitment.php/postKota';

  List<dynamic> _users = [];

  void fetchUsers(search) async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(
      url,
      body: {
        'search': search,
      },
    );
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Kota'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Kota'];
          _isLoading = false;
        }
      });
    }
  }

  String _desc1(dynamic user) {
    return user['city'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers('');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FieldReqruitmentPalette.menuBluebird,
        title: Form(
          key: _formKey,
          child: fieldSearching(),
        ),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget fieldSearching() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Cari Kota / Kabupaten',
        hintStyle: TextStyle(color: Colors.black45, fontSize: 12),
        suffixIcon: searchingController.text != ''
            ? GestureDetector(
                onTap: Feedback.wrapForTap(
                  searchingController.clear,
                  context,
                ),
                child: Icon(Icons.clear, color: Colors.red),
              )
            : null,
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Kota / Kabupaten wajib diisi ya';
        }
        return null;
      },
      onChanged: (value) {
        fetchUsers(searchingController.text);
        print(searchingController.text);
      },
      onFieldSubmitted: (value) {
        fetchUsers(searchingController.text);
      },
      controller: searchingController,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(FieldReqruitmentPalette.menuBluebird),
      ));
    } else {
      if (_users.length > 0) {
        return ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, _desc1(_users[index]));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _desc1(_users[index]),
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
              'Kota / Kabupaten tidak ditemukan',
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
