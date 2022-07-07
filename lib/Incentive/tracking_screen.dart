import 'dart:convert';

import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackingVoucherScreen extends StatefulWidget {
  @override
  _TrackingVoucherScreenState createState() => _TrackingVoucherScreenState();

  String noAkad;
  String idPencairan;
  String plafond;
  String insentif;

  TrackingVoucherScreen(
      this.noAkad, this.idPencairan, this.plafond, this.insentif);
}

class _TrackingVoucherScreenState extends State<TrackingVoucherScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/services.php/getTrackingVoucher';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl,
        body: {'no_akad': widget.noAkad, 'id_pencairan': widget.idPencairan});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Tracking'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Tracking'];
          _isLoading = false;
        }
      });
    }
  }

  String _tglDaftarLap(dynamic user) {
    return user['TGL_DAFTARLAP'];
  }

  String _tglPencairan(dynamic user) {
    return user['tgl_pencairan'];
  }

  String _jamPencairan(dynamic user) {
    return user['jam_pencairan'];
  }

  String _statusPencairan(dynamic user) {
    return user['STATUS_PENCAIRAN'];
  }

  String _sysupdatedate(dynamic user) {
    return user['sysupdatedate'];
  }

  String _approvalAkuntan(dynamic user) {
    return user['approval_akuntan'];
  }

  String _dateApproval3(dynamic user) {
    return user['date_approval_3'];
  }

  String _approvalBisnis(dynamic user) {
    return user['approval_bisnis'];
  }

  String _dateApproval2(dynamic user) {
    return user['date_approval_2'];
  }

  String _createdAtCallAudit(dynamic user) {
    return user['created_at_call'];
  }

  String _createdAtApprovalFinal(dynamic user) {
    return user['created_at_call_final'];
  }

  String _approvalSl(dynamic user) {
    return user['approval_sl'];
  }

  String _sysupdatedateSl(dynamic user) {
    return user['sysupdatedate'];
  }

  String _tglPembayaran(dynamic user) {
    return user['tgl_pembayaran'];
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
    print(widget.noAkad);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status Insentif',
          style: TextStyle(
            fontFamily: 'Poppins-Regular',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20),
        color: Colors.white,
        child: _buildList(),
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
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'NO APLIKASI',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  widget.noAkad,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'PLAFOND',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  formatRupiah(widget.plafond),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black12,
                    ))),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'INSENTIF',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  formatRupiah(widget.insentif),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _tglDaftarLap(_users[index]) != null
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: setNull(_tglPencairan(_users[index])) +
                                  ' ' +
                                  setNull(_jamPencairan(_users[index])),
                              child: Icon(
                                Icons.date_range_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'PENCAIRAN',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'PENCAIRAN',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _tglDaftarLap(_users[index]) != null
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        setTanggal(setNull(_tglPencairan(_users[index])) +
                            setNull(_jamPencairan(_users[index]))),
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  _statusPencairan(_users[index]) == 'success'
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: setNull(_sysupdatedateSl(_users[index])),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'APPROVAL SALES LEADER',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'APPROVAL SALES LEADER',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _statusPencairan(_users[index]) == 'success'
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _statusPencairan(_users[index]) == 'success'
                          ? Text(
                              setTanggal(
                                  setNull(_sysupdatedateSl(_users[index]))),
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                                fontSize: 11,
                              ),
                            )
                          : Text(''),
                    ),
                  ),
                  _approvalAkuntan(_users[index]) != null
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: setNull(_dateApproval3(_users[index])),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'VERIFIKASI AKUNTANSI',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'VERIFIKASI AKUNTANSI',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _approvalAkuntan(_users[index]) != null
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        setTanggal(setNull(_dateApproval3(_users[index]))),
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  _approvalBisnis(_users[index]) != null
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: setNull(_dateApproval3(_users[index])),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'APPROVAL SALES MARKETING HEAD',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'APPROVAL SALES MARKETING HEAD',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _approvalBisnis(_users[index]) != null
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        setTanggal(setNull(_dateApproval3(_users[index]))),
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  _createdAtCallAudit(_users[index]) != null
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message:
                                  setNull(_createdAtCallAudit(_users[index])),
                              child: Icon(
                                Icons.call_end_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'CALL AUDIT',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.call_end_outlined,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'CALL AUDIT',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _createdAtCallAudit(_users[index]) != null
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        setTanggal(setNull(_createdAtCallAudit(_users[index]))),
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  _createdAtApprovalFinal(_users[index]) != null
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: setNull(
                                  _createdAtApprovalFinal(_users[index])),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Text(
                              'APPROVAL FINAL',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'APPROVAL FINAL',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _createdAtApprovalFinal(_users[index]) != null
                              ? Colors.blueAccent
                              : Colors.redAccent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        setTanggal(
                            setNull(_createdAtApprovalFinal(_users[index]))),
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  int.parse(_approvalSl(_users[index])) == 4
                      ? Row(
                          children: <Widget>[
                            Tooltip(
                              message: _tglPembayaran(_users[index]),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.payment_outlined,
                                    color: Colors.blueAccent,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      'PEMBAYARAN',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              Icons.payment_outlined,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'PEMBAYARAN',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                    child: Text(
                      setTanggal(setNull(_tglPembayaran(_users[index]))),
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Text('');
      }
    }
  }

  setTanggal(String tanggal) {
    if (tanggal == 'NULL' || tanggal == null || tanggal.isEmpty) {
      return '';
    } else {
      return 'Tanggal ' + tanggal;
    }
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return 'NULL';
    } else {
      return data;
    }
  }
}
