class TodoModel {
  final String title;
  final String content;
  final String dateTime;
  final bool isDone;

  TodoModel({this.title, this.content, this.dateTime, this.isDone});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        title: json['title'],
        content: json['content'],
        dateTime: json['dateTime'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'dateTime': dateTime,
        'isDone': isDone,
      };
}
