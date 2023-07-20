class Entry {
  final String title;
  final String body;
  final DateTime date;
  final String id;
  final String emotion;
  Entry(
      {required this.date,
      required this.title,
      required this.body,
      required this.id,
      required this.emotion});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
      'emotion': emotion
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      date: DateTime.parse(map['date']),
      emotion: map['emotion'],
    );
  }
}
