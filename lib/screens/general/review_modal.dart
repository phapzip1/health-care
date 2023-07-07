// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ReviewModal extends StatefulWidget {
  String doctorId;
  String patientId;
  String patientName;
  String patientImage;
  ReviewModal(
      this.doctorId, this.patientId, this.patientName, this.patientImage,
      {super.key});

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  var _rating = 0.0;
  final TextEditingController _feedback = TextEditingController();

  void _submitFeedback() async {
    try {
      
      // final review = await ReviewModel.getByDoctorIdAndPatientId(
      //   widget.doctorId,
      //   widget.patientId,
      // );
      // if (review == null) {
      //   await ReviewModel.create(
      //           widget.doctorId,
      //           widget.patientId,
      //           widget.patientName,
      //           widget.patientImage,
      //           DateTime.now(),
      //           _rating,
      //           _feedback.text)
      //       .save();
      //   Fluttertoast.showToast(
      //     msg: "Rating successfully",
      //     toastLength: Toast.LENGTH_SHORT,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.greenAccent,
      //     textColor: Colors.black,
      //     fontSize: 16.0,
      //   );
      // } else {
      //   await ReviewModel(
      //           review.id,
      //           review.doctorId,
      //           review.patientId,
      //           review.patientName,
      //           widget.patientImage,
      //           DateTime.now(),
      //           _rating,
      //           _feedback.text)
      //       .save();
      //   Fluttertoast.showToast(
      //     msg: "Update successfully",
      //     toastLength: Toast.LENGTH_SHORT,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.grey,
      //     textColor: Colors.black,
      //     fontSize: 16.0,
      //   );
      // }
      _feedback.clear();
      // NavigationService.navKey.currentState!.pop();
    } catch (e) {
      print(e);
    }
  }

  _showFullModal(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Modal",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xfff8f8f8),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, right: 16, left: 16),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Give feedback",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text('How did the doctor do?'),
                              const SizedBox(
                                height: 16,
                              ),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 40,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text('Care to share more about it?'),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: _feedback,
                                maxLines: 12,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2F80ED),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16)),
                                    onPressed: _submitFeedback,
                                    child: const Text(
                                      'PUBLISH FEEDBACK',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F80ED),
              elevation: 0,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 12)),
          onPressed: () => _showFullModal(context),
          child: const Text(
            'Rating',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )),
    );
  }
}
