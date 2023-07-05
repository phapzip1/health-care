import 'package:flutter/material.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/screens/Doctor/update_doctor_information.dart';
import 'package:health_care/screens/Patient/cards_and_wallets_screen.dart';
import 'package:health_care/screens/Patient/patientRecord.dart';
import 'package:health_care/screens/Patient/updatePatientInformation.dart';
import 'package:health_care/screens/general/appointment_detail_for_doctor.dart';
import 'package:health_care/screens/general/appointment_detail_for_patient.dart';
import 'package:health_care/screens/general/doctor_schedule_screen.dart';
import 'package:health_care/screens/Patient/payment_screen.dart';
import 'package:health_care/screens/general/login_screen.dart';
import 'package:health_care/screens/general/splash.dart';
import 'package:health_care/widgets/record_screen/record_detail.dart';
import 'package:health_care/widgets/record_screen/write_record.dart';
import 'package:health_care/widgets/schedule_screen/patient_section.dart';

// screens
// import '../screens/page_not_found_screen.dart';
import '../screens/general/call_screen.dart';
// import '../screens/Doctor/homePageDoctor.dart';
import '../screens/general/communityQA.dart';

class NavigationService {
  static bool isCalling = false;

  static const String home = "/";
  static const String community = "/community";
  static const String schedule = "/schedule";
  static const String payment = "/payment";
  static const String wallets = "/wallets";
  static const String call = "/call";
  static const String login = "/login";
  static const String splash = "/splash";
  static const String record = "/record";
  static const String writeRecord = "/writerecord";
  static const String recordPage = "/recordpage";
  static const String patientSchedule = "/patientschedule";
  static const String doctorUpdateInfo = "/doctorupdateinfo";
  static const String patientUpdateInfo = "/patientupdateinfo";
  static const String appointmenDetailForPatient =
      "/appointmentdetailforpatient";
  static const String appointmenDetailForDoctor = "/appointmentdetailfordoctor";

  static final GlobalKey<NavigatorState> _navState =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navKey => _navState;

  static Route<dynamic> generateRoute(
      RouteSettings settings, Widget Function(BuildContext) homepageBuilder) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: homepageBuilder);
      case community:
        return MaterialPageRoute(builder: (_) => CommunityQA());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case doctorUpdateInfo:
        {
          final data = settings.arguments as DoctorModel;
          return MaterialPageRoute(
              builder: (_) => UpdateDoctorInformation(data));
        }
      case appointmenDetailForDoctor:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
              builder: (_) => AppointmentDetailForDoctor(
                    data["appointment"],
                    data["updateStatus"],
                  ));
        }
      case appointmenDetailForPatient:
        {
          final data = settings.arguments as AppointmentModel;
          return MaterialPageRoute(
              builder: (_) => AppointmentDetailForPatient(data));
        }
      case patientUpdateInfo:
        {
          final data = settings.arguments as PatientModel;
          return MaterialPageRoute(
            builder: (_) => UpdatePatientInfo(data),
          );
        }
      case patientSchedule:
        {
          final data = settings.arguments as List<AppointmentModel>;
          return MaterialPageRoute(
            builder: (_) => PatientSection(data),
          );
        }
      case recordPage:
        {
          final data = settings.arguments as bool;
          return MaterialPageRoute(
            builder: (_) => PatientRecords(data),
          );
        }
      case writeRecord:
        {
          final data = settings.arguments as AppointmentModel;
          return MaterialPageRoute(
            builder: (_) => WriteRecord(data),
          );
        }
      case record:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => RecordDetail(
              data["record"],
              data["isDoctor"],
              data["appointmentId"],
            ),
          );
        }
      case call:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => CallScreen(
              token: data["token"],
              channelId: data["channel_id"],
              remotename: data["remote_name"],
              remotecover: data["remote_cover"],
              caller: data["caller"],
            ),
          );
        }
      case schedule:
        {
          return MaterialPageRoute(
            builder: (_) => DoctorScheduleScreen(),
          );
        }
      case payment:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => PaymentScreen(
              data["doctorId"],
              data["doctorName"],
              data["price"],
              data["doctorPhone"],
              data["doctorImage"],
              data["doctorSpecialization"],
              data["date"],
              data["hour"],
            ),
          );
        }
      case wallets:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => CardsAndWalletsScreen(
              data["doctorId"],
              data["doctorName"],
              data["price"],
              data["doctorPhone"],
              data["doctorImage"],
              data["doctorSpecialization"],
              data["date"],
              data["hour"],
              data["patient"],
            ),
          );
        }
      default:
        // return MaterialPageRoute(builder: (_) => PageNotFoundScreen(settings.name!));
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
