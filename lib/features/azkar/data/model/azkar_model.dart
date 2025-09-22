class AzkarModel {
  String? title;
  List<Content>? content;

  AzkarModel({this.title, this.content});

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      title: json['title'],
      content: json['content'] != null
          ? (json['content'] as List)
          .map((e) => Content.fromJson(e))
          .toList()
          : [],
    );
  }
}

class Content {
  String? zekr;
  int? repeat;
  String? bless;

  Content({this.zekr, this.repeat, this.bless});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      zekr: json['zekr'],
      repeat: json['repeat'],
      bless: json['bless'],
    );
  }
}
