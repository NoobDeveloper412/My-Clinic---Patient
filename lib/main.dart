import 'dart:io';
import 'package:demopatient/Screen/chooseCityDrPage.dart';
import 'package:demopatient/Screen/cityListPage.dart';
import 'package:demopatient/Screen/cityListReachUsPage.dart';
import 'package:demopatient/Screen/clinicListPage.dart';
import 'package:demopatient/Screen/contactuspage.dart';
import 'package:demopatient/Screen/departmentPage.dart';
import 'package:demopatient/Screen/editUserprofiel.dart';
import 'package:demopatient/Screen/feedbackpage.dart';
import 'package:demopatient/Screen/gallery.dart';
import 'package:demopatient/Screen/prescription/prescriptionListPage.dart';
import 'package:demopatient/Screen/privicypage.dart';
import 'package:demopatient/Screen/refundpolicyPage.dart';
import 'package:demopatient/Screen/services.dart';
import 'package:demopatient/Screen/aboutus.dart';
import 'package:demopatient/Screen/appointment/registerpatient.dart';
import 'package:demopatient/Screen/appointment/appointment.dart';
import 'package:demopatient/Screen/appointment/appointmentStatus.dart';
import 'package:demopatient/Screen/appointment/choosetimeslots.dart';
import 'package:demopatient/Screen/appointment/confirmation.dart';
import 'package:demopatient/Screen/availiblity.dart';
import 'package:demopatient/Screen/home.dart';
import 'package:demopatient/Screen/login.dart';
import 'package:demopatient/Screen/reachus.dart';
import 'package:demopatient/Screen/notificationPage.dart';
import 'package:demopatient/Screen/testimonials.dart';
import 'package:demopatient/Service/AuthService/authservice.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:demopatient/Screen/blogPost/blogPostPage.dart';

import 'package:demopatient/Screen/moreService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
    debug: true,
  );
  initializeDateFormatting();

  // if (USE_FIRESTORE_EMULATOR) {
  //   FirebaseFirestore.instance.settings = Settings(
  //       host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  // }

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      runApp(MyApp());
    }
  } on SocketException catch (_) {
    runApp(NoInterConnectionApp());
    print('not connected');
  }
}

class NoInterConnectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => Scaffold(
            body: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoInternetErrorWidget(),
            )),
          )
    });
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return //      <--- ChangeNotifierProvider
        MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: _defaultHome,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            // HomeScreen(),

            AuthService().handleAuth(),
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomeScreen(),
        '/AppoinmentPage': (context) => AppointmentPage(),
        '/AboutusPage': (context) => AboutUs(),
        "/ChooseTimeSlotPage": (context) => ChooseTimeSlotPage(),
        '/AvaliblityPage': (context) => AvailabilityPage(),
        '/GalleryPage': (context) => GalleryPage(),
        '/ContactUsPage': (context) => AboutUs(), // ContactUs(),
        '/Appointmentstatus': (context) => AppointmentStatus(),
        '/ReachUsPage': (context) => ReachUS(),
        '/TestimonialsPage': (context) => Testimonials(),
        '/ServicesPage': (context) => ServicesPage(),
        '/RegisterPatientPage': (context) => RegisterPatient(),
        '/ConfirmationPage': (context) => ConfirmationPage(),
        '/NotificationPage': (context) => NotificationPage(),
        '/MoreServiceScreen': (context) => MoreServiceScreen(),
        '/BlogPostPage': (context) => BlogPostPage(),
        '/AuthScreen': (context) => AuthService().handleAuth(),
        '/EditUserProfilePage': (context) => EditUserProfilePage(),
        '/PrescriptionListPage': (context) => PrescriptionListPage(),
        '/ChooseDepartmentPage': (context) => ChooseDepartmentPage(),
        '/PrivacyPage': (context) => PrivacyPage(),
        '/RefundPolicyPage': (context) => RefundPolicyPage(),
        '/Contactuspage': (context) => Contactuspage(),
        '/FeedBackPage': (context) => FeedBackPage(),
        '/ClinicListPage': (context) => ClinicListPage(),
        '/CityListPage': (context) => CityListPage(),
        '/CityDRListPage': (context) => CityDRListPage(),
        '/CityListReachUsPage': (context) => CityListReachUsPage(),


      },
    );
  }
}

class NotificationDotModel {}
