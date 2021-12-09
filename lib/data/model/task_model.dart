// TODO (max):: immutable
// TODO (max):: equtable
class Task {
  int? id;
  String title;
  String date;
  String time;
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

  static List<Task> mapToTasks(tasksMap) {
    return List.generate(tasksMap.length, (i) {
      return Task(
        id: tasksMap[i]['id'],
        title: tasksMap[i]['title'],
        date: tasksMap[i]['date'],
        time: tasksMap[i]['time'],
        status: tasksMap[i]['status'],
      );
    });
  }

  @override
  String toString() {
    return 'Task {id :$id title: $title, date: $date, time: $time, status:$status }';
  }
}
