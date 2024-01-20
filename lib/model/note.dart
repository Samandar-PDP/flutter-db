class Note {
  int? id;
  String title;
  String desc;
  String date;
  Type type;

  Note({this.id, required this.title, required this.desc, required this.date, required this.type});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'desc': desc, 'date': date, "type": type.name};
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        desc = json['desc'],
        type = json['type'],
        date = json['date'];
}

enum Type {
  personal, family, study, love
}
