class Note {
  int? id;
  String title;
  String desc;
  String date;

  Note({this.id, required this.title, required this.desc, required this.date});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'desc': desc, 'date': date};
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        desc = json['desc'],
        date = json['date'];
}
