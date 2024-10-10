import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final Timestamp bookingAt;
  final Timestamp bookingTime;
  final String doctorId;
  final String doctorName;
  final String note;
  final String status;
  final String userId;
  final String userName;
  final Color statusColor;
  String? formattedBookingAt;
  String? formattedBookingTime;

  Booking({
    required this.id,
    required this.bookingAt,
    required this.bookingTime,
    required this.doctorId,
    required this.doctorName,
    required this.note,
    required this.status,
    required this.userId,
    required this.userName,
    required this.statusColor,
    this.formattedBookingAt,
    this.formattedBookingTime,
  });

  factory Booking.fromFirestore(
    DocumentSnapshot doc,
    String doctorName,
    String userName,
    Color statusColor,
    String formattedBookingAt,
    String formattedBookingTime,
  ) {
    final data = doc.data() as Map<String, dynamic>;

    return Booking(
      id: doc.id,
      bookingAt: data['bookingAt'] as Timestamp,
      bookingTime: data['booking_time'] as Timestamp,
      doctorId: data['doctorId'] as String,
      doctorName: doctorName,
      note: data['note'] as String,
      status: data['status'] as String,
      userId: data['userId'] as String,
      userName: userName,
      statusColor: statusColor,
      formattedBookingAt: formattedBookingAt,
      formattedBookingTime: formattedBookingTime,
    );
  }
}
