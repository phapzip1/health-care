import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/repos/appointment_repo.dart';
import 'package:health_care/repos/doctor_repo.dart';
import 'package:health_care/repos/patient_repo.dart';
import 'package:health_care/repos/post_repo.dart';
import 'package:health_care/repos/symptom_repo.dart';
import 'package:health_care/services/auth/auth_provider.dart';
import 'package:health_care/services/storage/storage_provider.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppointmentRepo appointmentProvider;
  final DoctorRepo doctorProvider;
  final PatientRepo patientProvider;
  final PostRepo postProvider;
  final SymptomRepo symptomRepo;
  final AuthProvider authProvider;
  final StorageProvider storageProvider;

  AppBloc({
    required this.appointmentProvider,
    required this.doctorProvider,
    required this.patientProvider,
    required this.postProvider,
    required this.symptomRepo,
    required this.authProvider,
    required this.storageProvider,
  }) : super(const AppState(false, null, null, null, null, null, null, null, null)) {
    on<AppEventInitialize>((event, emit) async {
      try {
        final symptom = await symptomRepo.getAll();
        final user = authProvider.currentUser;
        final doctor = await doctorProvider.getById(user!.uid);
        if (doctor != null) {
          emit(AppState(
            false,
            user,
            doctor,
            null,
            symptom,
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
            symptom,
            null,
            null,
            null,
            null,
          ));
        }
      } catch (e) {}
    });

    on<AppEventLogin>((event, emit) async {
      try {
        final user = await authProvider.logIn(email: event.email, password: event.password);

        final doctor = await doctorProvider.getById(user.uid);
        if (doctor != null) {
          emit(AppState(
            false,
            user,
            doctor,
            null,
            state.symptom,
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
            state.symptom,
            null,
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
        await doctorProvider.add(
          id: user.uid,
          name: event.username,
          phoneNumber: event.phone,
          image: avatarurl,
          gender: event.gender,
          birthdate: event.birthdate,
          email: event.email,
          identityId: event.identityId,
          licenseId: event.licenseId,
          experience: event.exp,
          price: event.price,
          workplace: event.workplace,
          specialization: event.specialization,
        );
        final doctor = DoctorModel(
          user.uid,
          event.username,
          event.phone,
          avatarurl,
          event.gender,
          event.birthdate,
          event.email,
          event.identityId,
          event.licenseId,
          event.exp,
          event.price,
          event.workplace,
          event.specialization,
          false,
          0,
        );
        emit(AppState(false, user, doctor, null, state.symptom, state.doctors, state.posts, state.appointments, state.records));
      } catch (e) {}
    });

    on<AppEventLogout>((event, emit) async {
      try {
        await authProvider.logOut();
        emit(AppState(false, null, null, null, state.symptom, null, null, null, null));
      } catch (e) {}
    });

    on<AppEventLoadAppointments>((event, emit) async {
      try {
        if (state.doctor != null) {
          final list1 = await appointmentProvider.getAppointmentByDoctorId(state.user!.uid);
          final list2 = await appointmentProvider.getOldAppointmentByDoctorId(state.user!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, state.posts, [...list1, ...list2], state.records));
        } else if (state.patient != null) {
          final list1 = await appointmentProvider.getAppointmentByPatientId(state.user!.uid);
          final list2 = await appointmentProvider.getOldAppointmentByPatientId(state.user!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, state.posts, [...list1, ...list2], state.records));
        }
      } catch (e) {}
    });

    on<AppEventLoadDoctors>((event, emit) async {
      try {
        if (event.specialization != null) {
          final doctors = await doctorProvider.getBySpecification(event.specialization!);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, doctors, state.posts, state.appointments, state.records));
        }
      } catch (e) {}
    });

    on<AppEventLoadPosts>((event, emit) async {
      try {
        if (event.specialization != null) {
          final posts = await postProvider.getByField(event.specialization);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records));
        }
      } catch (e) {}
    });

    on<AppEventLoadPostsAsPatient>((event, emit) async {
      try {
        final posts = await postProvider.getByPatientId(authProvider.currentUser!.uid);
        emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records));
      } catch (e) {}
    });

    on<AppEventLoadPostsAsDoctor>((event, emit) async {
      try {
        final posts = await postProvider.getByPatientId(authProvider.currentUser!.uid);
        emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records));
      } catch (e) {}
    });

    on<AppEventUpdateDoctorInfomation>((event, emit) async {
      try {
        await doctorProvider.update(event.doctor);
        emit(AppState(false, state.user, event.doctor, state.patient, state.symptom, state.doctors, state.posts, state.appointments, state.records));
      } catch (e) {}
    });

    on<AppEventUpdatePatientInfomation>((event, emit) async {
      try {
        await patientProvider.update(event.patient);
        emit(AppState(false, state.user, state.doctor, event.patient, state.symptom, state.doctors, state.posts, state.appointments, state.records));
      } catch (e) {}
    });

    on<AppEventUpdateHealthRecord>((event, emit) async {
      try {
        await appointmentProvider.updateHeathRecord(event.appointmentId, event.healthRecord);
      } catch (e) {}
    });

    on<AppEventMakeAppointment>((event, emit) async {
      try {
        await appointmentProvider.makeAppointment(
            doctorId: event.doctorId,
            doctorName: event.doctorName,
            doctorPhone: event.doctorPhone,
            doctorImage: event.doctorImage,
            patientId: state.patient!.id,
            patientName: state.patient!.name,
            patientImage: state.patient!.image,
            patientPhone: state.patient!.phoneNumber,
            specialization: event.specialization,
            datetime: event.datetime);
      } catch (e) {}
    });

    on<AppEventCancelAppointment>((event, emit) async {
      try {
        await appointmentProvider.cancelAppointment(event.appointmentId);
      } catch (e) {}
    });

    on<AppEventDeclineAppoitment>((event, emit) async {
      await appointmentProvider.declineAppointment(event.appointmentId);
    });
  }
}
