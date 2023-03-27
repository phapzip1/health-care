import '../models/reivew.dart';

class Doctor {
  // final String avatar;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final double rating;
  final int experience;
  final int patientChecked;
  final List<DateTime> availableTime;
  final List<Review> reviews;

  Doctor(this.doctorId, this.doctorName, this.doctorSpecialization, this.rating,
      this.experience, this.patientChecked, this.availableTime, this.reviews);
}
