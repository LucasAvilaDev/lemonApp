class ScheduledClass {
  final int reservationId;
  final int userId;
  final int scheduleId;
  final DateTime reservationDate;
  final String reservationTime;

  ScheduledClass({
    required this.reservationId,
    required this.userId,
    required this.scheduleId,
    required this.reservationDate,
    required this.reservationTime,
  });

  factory ScheduledClass.fromMap(Map<String, dynamic> map) {
    return ScheduledClass(
      reservationId: map['reservation_id'],
      userId: map['user_id'],
      scheduleId: map['schedule_id'],
      reservationDate: DateTime.parse(map['reservation_date']),
      reservationTime: map['reservation_time'],
    );
  }
}
