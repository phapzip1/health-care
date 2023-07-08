import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/firebase_options.dart';
import 'package:health_care/repos/firebase/appointment_firebase_repo.dart';
import 'package:health_care/repos/firebase/doctor_firebase_repo.dart';
import 'package:health_care/repos/firebase/patient_firebase_repo.dart';
import 'package:health_care/repos/firebase/post_firebase_repo.dart';
import 'package:health_care/repos/json_symptom_repo.dart';
import 'package:health_care/screens/Doctor/doctor_home_screen.dart';
import 'package:health_care/screens/Doctor/main_page_doctor.dart';
import 'package:health_care/screens/Patient/main_page_patient.dart';
import 'package:health_care/screens/Patient/patient_home_page.dart';
import 'package:health_care/screens/general/splash.dart';
import 'package:health_care/services/auth/firebase_auth_provider.dart';
import 'package:health_care/services/storage/firebase_storage_provider.dart';
import 'package:health_care/utils/app_theme.dart';

//screen import
import './screens/general/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      title: "Health Care",
      theme: getDefaultTheme(),
      home: BlocProvider<AppBloc>(
        create: (ctx) => AppBloc(
          appointmentProvider: AppointmentFirebaseRepo(),
          doctorProvider: DoctorFirebaseRepo(),
          patientProvider: PatientFirebaseRepo(),
          postProvider: PostFirebaseRepo(),
          symptomRepo: JsonSymptomRepo(),
          authProvider: FirebaseAuthProvider(),
          storageProvider: FirebaseStorageProvider(),
        ),
        child: const HomePage(),
      ),
      routes: {
        "/login": (ctx) => LoginScreen(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEventInitialize());
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) {
        return (previous.user == null && current.user != null) || (previous.user != null && current.user == null || (previous.user == null && current.user == null));
      },
      builder: (ctx, state) {
        if (state.isLoading) {
          return const SplashScreen();
        }

        if (state.user == null) {
          return LoginScreen();
        }

        if (state.doctor != null) {
          // return SplashScreen("doctor");
          return const MainPageDoctor();
        }

        // return SplashScreen("patient");
        return const MainPagePatient();
      },
    );
  }
}
