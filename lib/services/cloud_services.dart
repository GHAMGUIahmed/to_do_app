import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/model/TaskModel.dart';
import 'package:to_do/services/auth_services.dart';
import 'package:uuid/uuid.dart';

class CloudService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String? userid =
      AuthService().uu(FirebaseAuth.instance.currentUser)!.uid;
  final String? userName =
      AuthService().uu(FirebaseAuth.instance.currentUser)!.name;
  Future<bool> CreateUser(String email) async {
    try {
      fireStore
          .collection("users")
          .doc(userid)
          .set({"id": userid, "email": email});
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> Addote(
    String Title,
    String Description,
    String Date,
    String Time,
    String Category,
  ) async {
    try {
      var uuid = const Uuid().v4();

      fireStore
          .collection("users")
          .doc(userid)
          .collection("notes")
          .doc(uuid)
          .set({
        "id": uuid,
        "Title": Title,
        "Description": Description,
        "Data": Date,
        "Time": Time,
        "Category": Category,
        "isDone": false
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ToDoModel(
          TitleTask: data["Title"],
          Description: data["Description"],
          Category: data["Category"],
          DateTask: data["Data"],
          TimeTask: data["Time"],
          isDone: data["isDone"],
          docID: data["id"],
        );
      }).toList();

      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream() {
    // print(userid);
    return fireStore
        .collection('users')
        .doc(userid)
        .collection('notes')
        .snapshots();
  }

  Future<bool> update(bool isDon, String uid) async {
    try {
      await fireStore
          .collection("users")
          .doc(userid)
          .collection("notes")
          .doc(uid)
          .update({'isDone': isDon});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNote(String docId) async {
    try {
      await fireStore
          .collection("users")
          .doc(userid)
          .collection('notes')
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
