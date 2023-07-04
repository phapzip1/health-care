import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/repos/appointment_repo.dart';
import 'package:health_care/repos/doctor_repo.dart';
import 'package:health_care/repos/patient_repo.dart';
import 'package:health_care/repos/post_repo.dart';
import 'package:health_care/services/auth/auth_provider.dart';
import 'package:health_care/services/storage/storage_provider.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppointmentRepo appointmentProvider;
  final DoctorRepo doctorProvider;
  final PatientRepo patientProvider;
  final PostRepo postProvider;
  final AuthProvider authProvider;
  final StorageProvider storageProvider;

  AppBloc({
    required this.appointmentProvider,
    required this.doctorProvider,
    required this.patientProvider,
    required this.postProvider,
    required this.authProvider,
    required this.storageProvider,
  }) : super(const AppState(false, null, null, null, null, null, null)) {
    on<AppEventInitialize>((event, emit) {});

    on<AppEventLogin>((event, emit) async {
      try {
        emit(const AppState(
          true,
          null,
          null,
          null,
          null,
          null,
          null,
        ));

        final user = await authProvider.logIn(email: event.email, password: event.password);

        final doctor = await doctorProvider.getById(user.uid);
        if (doctor != null) {
          emit(AppState(
            false,
            user,
            doctor,
            null,
            null,
            null,
            null,
          ));
        } else {
          final patient = await patientProvider.getById(user.uid);
          emit(AppState(
            false,
            user,
            null,
            patient,
            null,
            null,
            null,
          ));
        }
      } catch (e) {}
    });

    on<AppEventCreateDoctorAccount>((event, emit) async {
      try {
        final user = await authProvider.createUser(email: event.email, password: event.password);
        final avatarurl = await storageProvider.uploadImage(event.image, "cover/${user.uid}.jpg");
        await doctorProvider.add(id: user.uid, name: event.username, phoneNumber: event.phone, image: avatarurl, gender: event.gender, birthdate: event., email: email, identityId: identityId, licenseId: licenseId, experience: experience, price: price, workplace: workplace, specialization: specialization)
      } catch (e) {
        
      }
    });

    on<AppEventLogout>((event, emit) async {
      try {
        await authProvider.logOut();
      } catch (e) {
        
      }
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
