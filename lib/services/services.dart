import 'package:avinyaapp/modals/Classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  Future<void> addProjectData(Projects newproject) async{
    Map<String,dynamic> obj={
      "Name": newproject.ProjectName,
      "Detail": newproject.Details,
      "Description": newproject.Description,
      "ImageURL": newproject.ImageUrl,
      "WebsiteUrl": newproject.Websiteurl,
      "id": newproject.id
    };
    String docId = newproject.id;
    final DocumentReference eventsRef=firestore.collection("Projects").doc(docId);
    await eventsRef.set(obj);
    print("Added Project");
  }
  Future<void> addEventsData(Events newevent) async{
    Map<String,dynamic> obj={
      "Name": newevent.EventName,
      "Details": newevent.Details,
      "Last Date":newevent.lastdate,
      "isOnline": newevent.isonline,
      "isRegistered": newevent.registered,
      "Registered Date": newevent.registereddate,
      "id":newevent.id
    };
    String docId = newevent.id;
    final DocumentReference eventsRef=firestore.collection("Events").doc(docId);
    await eventsRef.set(obj);
    print("Added EVent");

  }
  Future<void> RegisterEvent(String id) async{
    print("called");
    var now = DateTime.now();
    var formattedDate= DateFormat("dd-MM-yyyy").format(now);
    final DocumentReference eventref=firestore.collection("Events").doc(id);
    await eventref.update({"isRegistered":true,"Registered Date": formattedDate});
  }
  Future<List> readEvents() async{
    List<Events> events=[];
    final snapshot=await firestore.collection("Events").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      events.add(Events(EventName: element["Name"],
          Details: element["Details"],
          isonline: element["isOnline"],
          lastdate: element["Last Date"],
          registereddate: element["Registered Date"],
          registered: element["isRegistered"], id: element["id"]));
    }
    return events;
  }
  Future<List> readProjects() async{
    List<Projects> projects=[];
    final snapshot=await firestore.collection("Projects").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      projects.add(
          Projects(
          ProjectName: element["Name"],
          Details: element["Detail"],
          Description: element["Description"],
          ImageUrl: element["ImageURL"],
          Websiteurl: element["WebsiteUrl"],
          id: element["id"]));
    }
    return projects;
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