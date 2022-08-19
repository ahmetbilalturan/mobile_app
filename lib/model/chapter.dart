class Chapter {
  final int id;
  final String title;
  final String chapterCoverUrl;
  final String chapterDate;

  const Chapter(
      {required this.id,
      required this.title,
      required this.chapterCoverUrl,
      required this.chapterDate});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['chapterID'],
        title: json['chapterName'],
        chapterCoverUrl: json['chapterCoverUrl'],
        chapterDate: json['chapterDate'],
      );
}
