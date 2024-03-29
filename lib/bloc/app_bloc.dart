import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/repos/appointment_repo.dart';
import 'package:health_care/repos/doctor_repo.dart';
import 'package:health_care/repos/patient_repo.dart';
import 'package:health_care/repos/post_repo.dart';
import 'package:health_care/repos/symptom_repo.dart';
import 'package:health_care/services/auth/auth_provider.dart';
import 'package:health_care/services/storage/storage_provider.dart';
import 'package:uuid/uuid.dart';

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
  }) : super(const AppState(true, null, null, null, null, null, null, null, null, null, null)) {
    on<AppEventInitialize>((event, emit) async {
      try {
        final symptom = await symptomRepo.getAll();
        final user = authProvider.currentUser;
        if (user == null) {
          emit(AppState(
            false,
            null,
            null,
            null,
            symptom,
            null,
            null,
            null,
            null,
            null,
            null,
          ));
          return;
        }
        final doctor = await doctorProvider.getById(user.uid);
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
            null,
            null,
          ));
        } else {
          final patient = await patientProvider.getById(user.uid);
          final doctors = await doctorProvider.getAll();
          emit(AppState(
            false,
            user,
            null,
            patient,
            symptom,
            doctors,
            null,
            null,
            null,
            null,
            null,
          ));
        }
      } catch (e) {
        print(e);
      }
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
            null,
            null,
          ));
        }
      } catch (e) {}
    });

    on<AppEventCreatePatientAccount>((event, emit) async {
      try {
        final user = await authProvider.createUser(email: event.email, password: event.password);
        final avatarurl = await storageProvider.uploadImage(event.image, "cover/${user.uid}.jpg");
        await patientProvider.add(
          id: user.uid,
          name: event.username,
          phoneNumber: event.phone,
          image: avatarurl,
          gender: event.gender,
          birthdate: event.birthday,
          email: event.email,
        );
        final patient = PatientModel(
          user.uid,
          event.username,
          event.phone,
          event.gender,
          event.birthday,
          event.email,
          avatarurl,
        );
        emit(AppState(false, user, null, patient, state.symptom, state.doctors, state.posts, state.appointments, state.records, state.history, state.availableTime));
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
          event.licenseId,
          event.exp,
          event.price,
          event.workplace,
          event.specialization,
          false,
          0,
          {
            "mon": [],
            "tue": [],
            "wed": [],
            "thu": [],
            "fri": [],
            "sat": [],
            "sun": [],
          },
        );
        emit(AppState(false, user, doctor, null, state.symptom, state.doctors, state.posts, state.appointments, state.records, state.history, state.availableTime));
      } catch (e) {}
    });

    on<AppEventLogout>((event, emit) async {
      try {
        await authProvider.logOut();
        emit(AppState(false, null, null, null, state.symptom, null, null, null, null, null, null));
      } catch (e) {}
    });

    on<AppEventLoadAppointments>((event, emit) async {
      try {
        if (state.doctor != null) {
          final list1 = await appointmentProvider.getAppointmentByDoctorId(state.user!.uid);
          final list2 = await appointmentProvider.getOldAppointmentByDoctorId(state.user!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, state.posts, [list1, list2], state.records, state.history, state.availableTime));
        } else if (state.patient != null) {
          final list1 = await appointmentProvider.getAppointmentByPatientId(state.user!.uid);
          final list2 = await appointmentProvider.getOldAppointmentByPatientId(state.user!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, state.posts, [list1, list2], state.records, state.history, state.availableTime));
        }
      } catch (e) {
        print(e);
      }
    });

    on<AppEventLoadDoctors>((event, emit) async {
      try {
        final doctors = <DoctorModel>[];
        if (event.specialization != null) {
          doctors.addAll(await doctorProvider.getBySpecification(event.specialization!));
        } else {
          doctors.addAll(await doctorProvider.getAll());
        }
        emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, doctors, state.posts, state.appointments, state.records, state.history, state.availableTime));
      } catch (e) {}
    });

    on<AppEventLoadPosts>((event, emit) async {
      try {
        if (event.specialization != null) {
          final posts = await postProvider.getByField(event.specialization);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records, state.history, state.availableTime));
        }
      } catch (e) {}
    });

    on<AppEventLoadHistory>((event, emit) async {
      try {
        final history = await appointmentProvider.getCompletedAppointmentCount(event.doctorId);
        emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, state.posts, state.appointments, state.records, history, state.availableTime));
      } catch (e) {}
    });

    on<AppEventLoadOwnPosts>((event, emit) async {
      try {
        if (state.doctor != null) {
          final posts = await postProvider.getByDoctorId(authProvider.currentUser!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records, state.history, state.availableTime));
        } else {
          final posts = await postProvider.getByPatientId(authProvider.currentUser!.uid);
          emit(AppState(false, state.user, state.doctor, state.patient, state.symptom, state.doctors, posts, state.appointments, state.records, state.history, state.availableTime));
        }
      } catch (e) {}
    });

    on<AppEventLoadAvailableTime>((event, emit) async {
      try {
        final available = await appointmentProvider.getAvailableTime(event.date, event.doctorId);
        emit(AppState(
          false,
          state.user,
          state.doctor,
          state.patient,
          state.symptom,
          state.doctors,
          state.posts,
          state.appointments,
          state.records,
          state.history,
          available,
        ));
      } catch (e) {}
    });

    on<AppEventUpdateDoctorInfomation>((event, emit) async {
      try {
        String? avatar;
        if (event.avatar != null) {
          avatar = await storageProvider.uploadImage(event.avatar!, "cover/${state.doctor!.id}.jpg");
        }
        await doctorProvider.update(
          id: state.doctor!.id,
          avatar: avatar,
          birthdate: event.birthdate,
          exp: event.exp,
          gender: event.gender,
          phone: event.phone,
          price: event.price,
          username: event.username,
          workplace: event.workplace,
        );
        final oldDoctor = state.doctor!;
        final newDoctor = DoctorModel(
          oldDoctor.id,
          event.username,
          event.phone,
          avatar ?? oldDoctor.image,
          event.gender,
          event.birthdate,
          event.phone,
          oldDoctor.licenseId,
          event.exp,
          event.price,
          event.workplace,
          oldDoctor.specialization,
          oldDoctor.verified,
          oldDoctor.rating,
          oldDoctor.availableTime,
        );
        emit(AppState(false, state.user, newDoctor, state.patient, state.symptom, state.doctors, state.posts, state.appointments, state.records, state.history, state.availableTime));
      } catch (e) {}
    });

    on<AppEventUpdatePatientInfomation>((event, emit) async {
      try {
        String? avatar;
        if (event.image != null) {
          avatar = await storageProvider.uploadImage(event.image!, "cover/${state.patient!.id}.jpg");
        }
        await patientProvider.update(id: state.patient!.id, name: event.name, gender: event.gender, birthdate: event.birthdate, phoneNumber: event.phoneNumber, image: avatar);
        final oldPatient = state.patient!;
        final newPatient = PatientModel(oldPatient.id, event.name, event.phoneNumber, event.gender, event.birthdate, oldPatient.email, avatar ?? oldPatient.image);

        emit(AppState(false, state.user, state.doctor, newPatient, state.symptom, state.doctors, state.posts, state.appointments, state.records, state.history, state.availableTime));
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
          price: event.price,
          datetime: event.datetime,
        );
      } catch (e) {
        print(e);
      }
    });

    on<AppEventCancelAppointment>((event, emit) async {
      try {
        await appointmentProvider.cancelAppointment(event.appointmentId);
      } catch (e) {}
    });

    on<AppEventAcceptAppointment>((event, emit) async {
      try {
        await appointmentProvider.acceptAppointment(event.appointmentId);
      } catch (e) {}
    });

    on<AppEventDeclineAppointment>((event, emit) async {
      await appointmentProvider.declineAppointment(event.appointmentId);
    });

    on<AppEventSendFeedback>((event, emit) async {
      try {
        await doctorProvider.giveFeedback(
          doctorId: event.feedback.doctorId,
          patientId: event.feedback.patientId,
          patientName: event.feedback.patientName,
          patientImage: event.feedback.patientImage,
          createAt: event.feedback.createAt,
          rating: event.feedback.rating,
          message: event.feedback.message,
        );
      } catch (e) {}
    });

    on<AppEventCreatePost>((event, emit) async {
      try {
        final images = <String>[];

        for (final file in event.image) {
          final id = const Uuid().v4();
          String url = await storageProvider.uploadImage(file, "question/$id.jpg");
          images.add(url);
        }

        final now = DateTime.now();
        final id = await postProvider.create(
          patientId: event.patientId,
          age: event.age,
          specialization: event.specialization,
          description: event.content,
          gender: event.gender,
          private: event.private,
          images: images,
        );

        final posts = state.posts ?? [];

        posts.add(PostModel(
          id: id,
          patientId: event.patientId,
          age: event.age,
          specialization: event.specialization,
          description: event.content,
          gender: event.gender,
          private: event.private,
          time: now,
          images: images,
          count: 0,
        ));

        emit(AppState(
          false,
          state.user,
          state.doctor,
          state.patient,
          state.symptom,
          state.doctors,
          posts,
          state.appointments,
          state.records,
          state.history,
          state.availableTime,
        ));
      } catch (e) {}
    });

    on<AppEventReplyPost>((event, emit) async {
      try {
        if (state.doctor != null) {
          await postProvider.replyasDoctor(event.message, state.user!.uid, state.doctor!.name, event.postId, state.doctor!.image);
        } else {
          await postProvider.reply(event.message, state.user!.uid, event.postId);
        }
      } catch (e) {}
    });

    on<AppEventUpdateDoctorSchedule>((event, emit) async {
      try {
        if (event.weekday != null) {
          await doctorProvider.updateAvailableTime(state.doctor!.id, event.times, event.weekday!);
          final old = state.doctor!.toMap();
          (old["available_time"] as Map).update("${event.weekday}", (value) => event.times);
          emit(AppState(
            false,
            state.user,
            DoctorModel.fromMap(old),
            state.patient,
            state.symptom,
            state.doctors,
            state.posts,
            state.appointments,
            state.records,
            state.history,
            state.availableTime,
          ));
        } else {
          await Future.wait([
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "mon"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "tue"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "wed"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "thu"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "fri"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "sat"),
            doctorProvider.updateAvailableTime(state.doctor!.id, event.times, "sun"),
          ]);
          final old = state.doctor!.toMap();
          old["available_time"] = {
            "mon": event.times,
            "tue": event.times,
            "wed": event.times,
            "thu": event.times,
            "fri": event.times,
            "sat": event.times,
            "sun": event.times,
          };
          emit(AppState(
            false,
            state.user,
            DoctorModel.fromMap(old),
            state.patient,
            state.symptom,
            state.doctors,
            state.posts,
            state.appointments,
            state.records,
            state.history,
            state.availableTime,
          ));
        }
      } catch (e) {}
    });
  }
}
