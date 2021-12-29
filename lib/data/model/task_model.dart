// TODO (max):: equitable
class Task {
  final int? id;
  final String title;
  final String date;
  final String time;
  String status;

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    this.status = 'new',
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, Object?> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title']! as String,
      date: map['date']! as String,
      time: map['time']! as String,
      status: map['status']! as String,
    );
  }

  @override
  String toString() {
    return 'Task {id :$id title: $title, date: $date, time: $time, status:$status }';
  }
}
