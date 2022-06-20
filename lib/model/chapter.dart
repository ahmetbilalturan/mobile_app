class Chapter {
  final int id;
  final String title;
  final String pages;

  const Chapter({required this.id, required this.title, required this.pages});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['_id'],
        title: json['chaptername'],
        pages: json['pages'],
      );
}
