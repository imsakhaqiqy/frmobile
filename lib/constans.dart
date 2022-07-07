import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class FieldReqruitmentPalette {
  static Color purple = Color(0xFF483D8B);
  static Color green = Color.fromARGB(255, 69, 170, 74);
  static Color grey = Color.fromARGB(255, 242, 242, 242);
  static Color grey200 = Color.fromARGB(200, 242, 242, 242);
  static Color menuRide = Color(0xffe99e1e);
  static Color menuCar = Color(0xff14639e);
  static Color menuBluebird = Color(0xff2da5d9);
  static Color menuFood = Color(0xffec1d27);
  static Color menuSend = Color(0xff8dc53e);
  static Color menuDeals = Color(0xfff43f24);
  static Color menuPulsa = Color(0xff72d2a2);
  static Color menuOther = Color(0xffa6a6a6);
  static Color menuShop = Color(0xff0b945e);
  static Color menuMart = Color(0xff68a9e3);
  static Color menuTix = Color(0xffe86f16);
}

loadingScreen(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // background color
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog", // label for barrier
    transitionDuration: Duration(
        milliseconds:
            400), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpinKitThreeInOut(
            color: Colors.white,
            size: 30.0,
          )
        ],
      );
    },
  );
}

setStatusPerkawinan(String value) {
  switch (value) {
    case "0":
      return 'BELUM MENIKAH';
      break;
    case "1":
      return 'MENIKAH';
      break;
  }
}

setJenisKelamin(String value) {
  switch (value) {
    case "0":
      return 'LAKI-LAKI';
      break;
    case "1":
      return 'PEREMPUAN';
      break;
  }
}

setAgama(String value) {
  switch (value) {
    case "0":
      return 'ISLAM';
      break;
    case "1":
      return 'KATOLIK';
      break;
    case "2":
      return 'PROTESTAN';
      break;
    case "3":
      return 'HINDU';
      break;
    case "4":
      return 'BUDHA';
      break;
  }
}

setPendidikan(String value) {
  switch (value) {
    case "0":
      return 'SD';
      break;
    case "1":
      return 'SMP';
      break;
    case "2":
      return 'SMA';
      break;
    case "3":
      return 'DIPLOMA';
      break;
    case "4":
      return 'SARJANA';
      break;
    case "5":
      return 'MAGISTER';
      break;
  }
}

setStatusKaryawan(String value) {
  switch (value) {
    case "0":
      return 'KARYAWAN TETAP';
      break;
    case "1":
      return 'KARYAWAN KONTRAK';
      break;
    case "2":
      return 'KARYAWAN DI HOLD';
      break;
    case "3":
      return 'KARYAWAN RESIGN';
      break;
    case "4":
      return 'KARYAWAN PERCOBAAN';
      break;
    case "5":
      return 'KARYAWAN AGENT';
      break;
  }
}

formatRupiah(String a) {
  const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(double.parse(s));
  a = '${_formatNumber(a.replaceAll(',', ''))}';
  return a;
}

setNull(String data) {
  if (data == null || data == '' || data.isEmpty) {
    return 'NULL';
  } else {
    return data;
  }
}

alertStyle() {
  return AlertStyle(
    animationType: AnimationType.fromLeft,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    alertAlignment: Alignment.center,
  );
}

statusPipeline(String status) {
  if (status == '1') {
    return 'Pipeline';
  } else if (status == '2') {
    return 'Pencairan';
  } else if (status == '3') {
    return 'Submit Dokumen';
  } else if (status == '4') {
    return 'Akad Kredit';
  }
}

_launchURL() async {
  if (await canLaunch(
      'https://drive.google.com/drive/folders/1xbc7xRJRAw_n8zys0h2xhbH_LBBMUtH_?usp=sharing')) {
    await launch(
        'https://drive.google.com/drive/folders/1xbc7xRJRAw_n8zys0h2xhbH_LBBMUtH_?usp=sharing');
  } else {
    throw 'Could not launch https://drive.google.com/drive/folders/1xbc7xRJRAw_n8zys0h2xhbH_LBBMUtH_?usp=sharing';
  }
}

alertBalance(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: FieldReqruitmentPalette.menuBluebird,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Icon(
              Icons.info_outline_rounded,
              size: 100,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mohon untuk download aplikasi FR-Mobile terbaru.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton(
              color: Colors.white,
              onPressed: () {
                _launchURL();
              },
              child: Text(
                'Download',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        );
      });
}
