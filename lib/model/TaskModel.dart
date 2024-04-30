// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ToDoModel {
  String? docID;
  final String TitleTask;
  final String Description;
  final String Category;
  final String DateTask;
  final String TimeTask;
  bool isDone;
  ToDoModel({
    this.docID,
    required this.TitleTask,
    required this.Description,
    required this.Category,
    required this.DateTask,
    required this.TimeTask,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docID': docID,
      'TitleTask': TitleTask,
      'Description': Description,
      'Category': Category,
      'DateTask': DateTask,
      'TimeTask': TimeTask,
      'isDone': isDone,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      TitleTask: map['TitleTask'] as String,
      Description: map['Description'] as String,
      Category: map['Category'] as String,
      DateTask: map['DateTask'] as String,
      TimeTask: map['TimeTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
