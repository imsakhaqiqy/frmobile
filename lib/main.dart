import 'package:field_recruitment/Checkin/checkin_screen.dart';
import 'package:field_recruitment/Checkout/checkout_screen.dart';
import 'package:field_recruitment/Document/document_screen.dart';
import 'package:field_recruitment/FAQ/faqscreen.dart';
import 'package:field_recruitment/Fee/fee_screen.dart';
import 'package:field_recruitment/Forgot/forgot_password.dart';
import 'package:field_recruitment/Incentive/incentive_screen.dart';
import 'package:field_recruitment/Landing/landing_screen.dart';
import 'package:field_recruitment/Notification/notification_screen.dart';
import 'package:field_recruitment/Permit/add_leave.dart';
import 'package:field_recruitment/Permit/add_permission.dart';
import 'package:field_recruitment/Permit/add_sick.dart';
import 'package:field_recruitment/Permit/permit_screen.dart';
import 'package:field_recruitment/Permit/report_leave.dart';
import 'package:field_recruitment/Permit/report_permission.dart';
import 'package:field_recruitment/Permit/report_sick.dart';
import 'package:field_recruitment/Profil/address_screen.dart';
import 'package:field_recruitment/Profil/bank_account_screen.dart';
import 'package:field_recruitment/Profil/employee_screen.dart';
import 'package:field_recruitment/Profil/income_screen.dart';
import 'package:field_recruitment/Profil/profil_screen.dart';
import 'package:field_recruitment/Provider/checkin_provider.dart';
import 'package:field_recruitment/Provider/checkout_provider.dart';
import 'package:field_recruitment/Provider/fee_provider.dart';
import 'package:field_recruitment/Provider/incentive_provider.dart';
import 'package:field_recruitment/Provider/leave_provider.dart';
import 'package:field_recruitment/Provider/personal_provider.dart';
import 'package:field_recruitment/Provider/sick_provider.dart';
import 'package:field_recruitment/Provider/visit_provider.dart';
import 'package:field_recruitment/Recruit/detail_recruit.dart';
import 'package:field_recruitment/Recruit/info_screen.dart';
import 'package:field_recruitment/Recruit/recruit_add1_screen.dart';
import 'package:field_recruitment/Recruit/recruit_add2_screen.dart';
import 'package:field_recruitment/Recruit/recruit_add3_screen.dart';
import 'package:field_recruitment/Recruit/recruit_add4_screen.dart';
import 'package:field_recruitment/Recruit/recruit_list_screen.dart';
import 'package:field_recruitment/Report/report_screen.dart';
import 'package:field_recruitment/Support/support_screen.dart';
import 'package:field_recruitment/Visit/visit_screen.dart';
import 'package:field_recruitment/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import 'Provider/permission_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CheckInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckOutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VisitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeaveProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SickProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PermissionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InsentifProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonalProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'FieldReqruitment Apps',
        debugShowCheckedModeBanner: false,
        color: Colors.red,
        initialRoute: '/',
        routes: {
          '/': (context) => OnBoardingPage(),
          '/landing': (context) => LandingPage(),
          '/checkin': (context) => const CheckinScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/visit': (context) => const VisitScreen(),
          '/documents': (context) => DocumentScreen(),
          '/recruit': (context) => RecruitListScreen(),
          '/addrecruit': (context) => const AddRecruitScreen(),
          '/profile': (context) => ProfilScreen(),
          '/address': (context) => AddressScreen(),
          '/placement': (context) => PlacementScreen(),
          '/account_bank': (context) => AccountBankScreen(),
          '/income': (context) => IncomeScreen(),
          '/incentive': (context) => IncentiveScreen(),
          '/fee': (context) => FeeScreen(),
          '/permit': (context) => PermitScreen(),
          '/addleave': (context) => const AddLeaveScreen(),
          '/addsick': (context) => const AddSickScreen(),
          '/addpermission': (context) => const AddPermissionScreen(),
          '/reportleave': (context) => ReportLeaveScreen(),
          '/reportsick': (context) => ReportSickScreen(),
          '/reportpermission': (context) => ReportPermissionScreen(),
          '/forgotpassword': (context) => ForgetPasswordScreen(),
          '/faq': (context) => FaqScreen(),
          '/support': (context) => SupportScreen(),
          '/information': (context) => InfoScreen(),
          '/notifikasi': (context) => NotificationScreen(),
        },
      ),
    );
  }
}
