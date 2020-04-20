class LatestUpdatesModel {
  final String date;
  final List<String> newsPost;

  LatestUpdatesModel({this.date, this.newsPost});

  factory LatestUpdatesModel.fromJson(Map<String, dynamic> json) {
    var postsfromjson = json['news'];
    List<String> posts = new List<String>.from(postsfromjson);

    return LatestUpdatesModel(
      date: json['date'],
      newsPost: posts,
    );
  }
}
