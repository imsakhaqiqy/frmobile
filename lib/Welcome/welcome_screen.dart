import 'package:field_recruitment/Login/login_screen.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/images/$assetName',
      width: width,
    );
  }

  String? title;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    OneSignal.shared.setAppId("8e500521-492c-41f9-b74b-dde533941d81");
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      setState(() {
        title = event.notification.title;
        title = event.notification.body;
      });
    });
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult notification) {
      print("notifikasi di tap");
    });
  }

  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Penyaluran Kredit Per-Tahun",
          body: "Penyaluran kredit mencapai lebih dari 700 milyar pertahun.",
          image: _buildImage('pencairan.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Jumlah Database",
          body:
              "Memiliki 2.000.000 database yang terus bertambah dan diperbaharui.",
          image: _buildImage('database.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Mentor Berpengalaman",
          body:
              "Mentor berpengalaman hingga belasan tahun yang siap membantu dan membimbing.",
          image: _buildImage('mentor.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Jangkauan Area Tugas",
          body: "Menjangkau hingga 34 provinsi di Indonesia.",
          image: _buildImage('jangkauan.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(color: Color(0xFFBDBDBD)),
      ),
      next: const Text(
        'Next',
        style: TextStyle(color: Color(0xFFBDBDBD)),
      ),
      done: const Text('Login',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
