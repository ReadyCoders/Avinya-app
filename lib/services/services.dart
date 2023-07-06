import 'package:avinyaapp/modals/NewsClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services{
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  Future<void> addNews(News newNews) async{
    Map<String,dynamic> obj = {
      "Title":newNews.title,
      "Description": newNews.desc,
      "isImportant": newNews.isImportant,
      "id":newNews.id
    };
  String docId = newNews.id;
  final DocumentReference tasksRef=firestore.collection("News").doc(docId);
  await tasksRef.set(obj);
  print("Added");
  }

  Future<List> read() async{
    List<News>news=[];
    final snapshot=await firestore.collection("News").get();
    final List<DocumentSnapshot> documents= snapshot.docs;
    for(DocumentSnapshot element in documents){
      news.add(News(title: element["Title"], desc: element["Description"], isImportant: element["isImportant"], id: element["id"]));
    }
    return news;
  }
}