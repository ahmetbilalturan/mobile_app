class Manga {
  final int id;
  final String title;
  final String artist;
  final String urlImage;
  final String genre;
  final int chaptercount;
  final String status;

  const Manga(
      {required this.id,
      required this.artist,
      required this.title,
      required this.urlImage,
      required this.genre,
      required this.chaptercount,
      required this.status});

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
        id: json['_id'],
        artist: json['mangaartist'],
        title: json['manganame'],
        urlImage: json['mangacoverurl'],
        genre: json['mangagenre'],
        chaptercount: json['chaptercount'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'manganame': title,
        'mangaartist': artist,
        'mangacoverurl': urlImage,
        'mangagenre': genre,
      };
}
