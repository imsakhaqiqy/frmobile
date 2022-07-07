import 'dart:convert';

import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';
import 'package:field_recruitment/beranda/beranda_model.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/beranda/beranda_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with TickerProviderStateMixin {
  AnimationController? _controllerAnimation;
  Animation<double>? _animation;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<Titled> _fieldRecruitmentServiceList = [];

  final List<String> imgList = [];
  bool loadingScreen = false;
  String? title;
  String? userId;
  bool visible = false;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position? _currentPosition;
  String _currentLatitude = '';
  String _currentLongitude = '';

  Future _getCurrentLocation() async {
    setState(() {
      visible = true;
    });
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {});
    return _currentPosition;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentLatitude = "${place.position.latitude}";
        _currentLongitude = "${place.position.longitude}";
        isLat = double.parse(_currentLatitude);
        isLong = double.parse(_currentLongitude);
      });
    } catch (e) {}
  }

  Future saveToken() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //server save api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/updateToken';

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': isNiksales,
      'token': userId,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Token'];
      if (message['message'].toString() == 'Update Success') {
        setState(() {
          visible = false;
        });
      } else {
        setState(() {
          visible = false;
        });
      }
    }
  }

  Future getNotification() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
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

    _fieldRecruitmentServiceList.add(Titled(
      "Check In",
      "assets/images/check-in.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Check Out",
      "assets/images/check-out.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Visit",
      "assets/images/visitor.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Recruit",
      "assets/images/recruitment.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Document",
      "assets/images/document.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Incentive",
      "assets/images/incentive.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Fee",
      "assets/images/money.png",
    ));
    _fieldRecruitmentServiceList.add(Titled(
      "Permit",
      "assets/images/permit.png",
    ));
    _controllerAnimation = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controllerAnimation!, curve: Curves.bounceOut);
    _controllerAnimation!.forward();
    getAbsensi();
    userLogin();
    getBanner();
    getNotification();

    OneSignal.shared.getDeviceState().then((deviceState) {
      setState(() {
        userId = deviceState!.userId;
      });
      saveToken();
    });
    _getCurrentLocation().then((value) {});
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future userLogin() async {
    String uname = isUsername;
    String nik = isNiksales;

    //server login api
    var url =
        'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getLogin';

    //starting web api call
    var response = await http.post(url, body: {
      'uname': uname,
      'nik': nik,
    });

    //if the response message is matched
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Login'];
      if (message['message'].toString() == 'Login Success') {
        setState(() {
          isUsername = message['uname'];
          isNiksales = message['nik'];
          isFullname = message['uname'];
          isPoints = '1000';
          isPosition = 'Field Recruitment';
          isPict = message['pict'];
          isVisit = message['visit'] == null ? '0' : message['visit'];
          isRecruit = message['recruit'] == null ? '0' : message['recruit'];
          isTarif = message['tarif'];
        });
      } else {}
    } else {
      print('error');
    }
  }

  final String urlabsensi =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getAbsensi';
  Future getAbsensi() async {
    setState(() {
      loadingScreen = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.post(urlabsensi, body: {
      'nik': isNiksales,
    });
    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Absensi'] == '') {
          loadingScreen = false;
        } else {
          var resBody = json.decode(res.body)['Daftar_Absensi'];
          loadingScreen = false;
          isCheckin = resBody[0]['checkin'].toString();
          isCheckout = resBody[0]['checkout'].toString();
        }
      });
    }
  }

  final String urlBanner =
      'https://www.nabasa.co.id/api_field_recruitment_v1/services.php/getBanner';
  Future getBanner() async {
    setState(() {
      loadingScreen = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.get(urlBanner);
    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Banner'] == '') {
          loadingScreen = false;
        } else {
          var resBody = json.decode(res.body)['Daftar_Banner'];
          loadingScreen = false;
          for (int i = 0;
              i < json.decode(res.body)['Daftar_Banner'].length;
              i++) {
            imgList.add(resBody[i]['path'].toString());
          }
        }
      });
    }
  }

  void _onRefresh() {
    userLogin();
    getAbsensi();
    _getCurrentLocation().then((value) {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return loadingScreen
        ? Container(
            color: Colors.white,
            child: Center(
              child: SpinKitThreeInOut(
                color: FieldReqruitmentPalette.menuBluebird,
                size: 30.0,
              ),
            ),
          )
        : ScaleTransition(
            scale: _animation!,
            child: SafeArea(
                child: Scaffold(
              appBar: BerandaAppBar(context),
              backgroundColor: Colors.white,
              body: WillPopScope(
                onWillPop: () async => false,
                child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: FieldReqruitmentPalette.menuBluebird,
                    color: Colors.white,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            _buildBannerMenu(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: FieldReqruitmentPalette.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Center(
                                      child: Text(
                                        'Hallo, ' + isFullname,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto-Regular',
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: FieldReqruitmentPalette.grey,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Center(
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: _buildKreditPensiunMenu(),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: FieldReqruitmentPalette.grey,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Visit',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Roboto-Regular',
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Card(
                                      elevation: 4,
                                      color: Colors.cyan,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ListTile(
                                              leading: Image.asset(
                                                'assets/images/visitor.png',
                                                width: 40,
                                                height: 40,
                                              ),
                                              title: Text(
                                                isVisit + ' Orang',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto-Regular',
                                                ),
                                              ),
                                              subtitle: const Text(
                                                'Sejak Bergabung',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto-Regular',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: FieldReqruitmentPalette.grey,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Recruit',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Roboto-Regular',
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Card(
                                      elevation: 4,
                                      color: Colors.cyan,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ListTile(
                                              leading: Image.asset(
                                                'assets/images/recruitment.png',
                                                width: 40,
                                                height: 40,
                                              ),
                                              title: Text(
                                                isRecruit + ' Orang',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto-Regular',
                                                ),
                                              ),
                                              subtitle: const Text(
                                                'Sejak Bergabung',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto-Regular',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
  }

  Widget _buildBannerMenu() {
    final double width = MediaQuery.of(context).size.width;
    final List<Widget> imageSliders = imgList
        .map((item) => ClipRRect(
              child: Image.network(
                  'https://www.nabasa.co.id/field_recruitment/' + item,
                  fit: BoxFit.cover,
                  width: width),
            ))
        .toList();
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            // autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildKreditPensiunMenu() {
    return SizedBox(
        width: double.infinity,
        height: 200.0,
        child: Container(
            margin: const EdgeInsets.only(top: 0.0, bottom: 8.0),
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: _fieldRecruitmentServiceList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 0.1),
              itemBuilder: (context, position) {
                return _rowKreditPensiunService(
                    _fieldRecruitmentServiceList[position]);
              },
            )));
  }

  Widget _rowKreditPensiunService(Titled titled) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: FieldReqruitmentPalette.grey,
                  border: Border.all(color: Colors.cyan, width: 1.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    switch (titled.title) {
                      case "Check In":
                        if (isCheckin == '1') {
                          Alert(
                            context: context,
                            style: alertStyle(),
                            type: AlertType.info,
                            desc: "Anda sudah Check In",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Colors.cyan,
                                radius: BorderRadius.circular(0.0),
                              ),
                            ],
                          ).show();
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/checkin',
                          );
                        }
                        break;
                      case "Check Out":
                        if (isCheckout == '1') {
                          Alert(
                            context: context,
                            style: alertStyle(),
                            type: AlertType.info,
                            desc: "Anda sudah Check Out",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                                radius: BorderRadius.circular(0.0),
                              ),
                            ],
                          ).show();
                        } else {
                          Navigator.pushNamed(context, '/checkout');
                        }
                        break;
                      case "Visit":
                        Navigator.pushNamed(context, '/visit');
                        break;
                      case "Recruit":
                        Navigator.pushNamed(context, '/recruit');
                        break;
                      case "Document":
                        Navigator.pushNamed(context, '/documents');
                        break;
                      case "Incentive":
                        Navigator.pushNamed(context, '/incentive');
                        break;
                      case "Fee":
                        Navigator.pushNamed(context, '/fee');
                        break;
                      case "Permit":
                        Navigator.pushNamed(context, '/permit');
                        break;
                    }
                  },
                  child: Image.asset(
                    titled.image,
                    width: 32.0,
                    height: 32.0,
                  ),
                )),
            const Padding(
              padding: EdgeInsets.only(top: 2.0),
            ),
            Text(
              titled.title,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto-Regular',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
