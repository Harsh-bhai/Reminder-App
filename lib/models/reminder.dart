class ReminderModel {
  int id;
  String title;
  String time;
  String period; // AM or PM

  ReminderModel({
    required this.id,
    required this.title,
    required this.time,
    required this.period,
  });
}
