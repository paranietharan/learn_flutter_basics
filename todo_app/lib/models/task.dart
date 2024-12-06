class Task {
  final int id;
  final int status;
  final String content;
  final String? description;

  Task({
    required this.id,
    required this.status,
    required this.content,
    this.description,
  });
}
