import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/repos/appointment_repo.dart';
import 'package:health_care/repos/doctor_repo.dart';
import 'package:health_care/repos/patient_repo.dart';
import 'package:health_care/repos/post_repo.dart';
import 'package:health_care/services/auth/auth_provider.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppointmentRepo appointmentProvider;
  final DoctorRepo doctorProvider;
  final PatientRepo patientProvider;
  final PostRepo postProvider;
  final AuthProvider authProvider;

  AppBloc({
    required this.appointmentProvider,
    required this.doctorProvider,
    required this.patientProvider,
    required this.postProvider,
    required this.authProvider,
  }) : super(const AppState(false, null, null, null, null, null, null)) {
    on<AppEventInitialize>((event, emit) {});

    on<AppEventLogin>((event, emit) {
      authProvider.logIn(email: event.email, password: event.password);
    });

    on<AppEventCreateAccount>((event, emit) {
      authProvider.createUser(email: event.email, password: event.password);
    });

    on<AppEventLogout>((event, emit) {
      authProvider.logOut();
    });

    on<AppEventLoadAppointments>((event, emit) {});

    on<AppEventLoadDoctors>((event, emit) {});

    on<AppEventLoadPosts>((event, emit) {});

    on<AppEventLoadDoctorInfomation>((event, emit) {});

    on<AppEventLoadPatientInfomation>((event, emit) {});

    on<AppEventUpdateDoctorInfomation>((event, emit) {});

    on<AppEventUpdatePatientInfomation>((event, emit) {});
  }
}
