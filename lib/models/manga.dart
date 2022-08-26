class Manga {
  final int id;
  final String title;
  final String artist;
  final String urlImage;
  final String genre;
  final int chaptercount;
  final String plot;
  final String weeklyPublishDay;
  final String bannerUrl;
  final String status;

  const Manga({
    required this.id,
    required this.artist,
    required this.title,
    required this.urlImage,
    required this.genre,
    required this.chaptercount,
    required this.plot,
    required this.weeklyPublishDay,
    required this.bannerUrl,
    required this.status,
  });

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
        id: json['_id'],
        artist: json['mangaArtist'],
        title: json['mangaName'],
        urlImage: json['mangaCoverUrl'],
        genre: json['mangaGenre'],
        chaptercount: json['chapterCount'],
        plot: json['mangaPlot'],
        weeklyPublishDay: json['mangaWeeklyPublishDay'],
        bannerUrl: json['mangaBannerUrl'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'mangaName': title,
        'mangaArtist': artist,
        'mangaCoverUrl': urlImage,
        'mangaGenre': genre,
      };
}
