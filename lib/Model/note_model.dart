class Note {
  String id;
  String title;
  String content;

  Note({
    this.id = '',
    required this.title,
    required this.content,
  });

  // From Firestore snapshot
  factory Note.fromFirestore(Map<String, dynamic> data) {
    return Note(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
    );
  }
}
