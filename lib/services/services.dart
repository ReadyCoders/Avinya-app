import 'package:avinyaapp/modals/Classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Services{
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  Future<void> addNews(News newNews) async{
    Map<String,dynamic> obj = {
      "Title":newNews.title,
      "Description": newNews.desc,
      "isImportant": newNews.isImportant,
      "DatePosted": newNews.dateposted,
      "id":newNews.id

    };
  String docId = newNews.id;
  final DocumentReference tasksRef=firestore.collection("News").doc(docId);
  await tasksRef.set(obj);
  print("Added");
  }
  Future<void> addUser(Users newuser) async{
    Map<String,dynamic> obj={
      "UserName":newuser.Username,
      "Emailid": newuser.emailid,
      "Dob":newuser.Dob,
      "role":newuser.role,
      "id":newuser.id,
    };
    String docId = newuser.id;
    final DocumentReference userref= firestore.collection("Users").doc(docId);
    await userref.set(obj);
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
  Future<String> fetchRole(String mail) async{
    String role="";
    final snapshot=await firestore.collection("Users").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      if((element["Emailid"]==mail)){
        role=element["role"];
      }
    }
    return role;

  }
  Future<List> getprofile(String mail) async{
    List<Profile> list=[];
    final snapshot=await firestore.collection("Users").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      if(element["Emailid"]==mail){
        Profile currentProfile= Profile(Username: element["UserName"], desc:element["role"], courses: 0, books: 0, projects: 0, Dob: element["Dob"], emailid: mail, premium: element["premium"]);
        list.add(currentProfile);
      }
    }
  return list;

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
  Future<bool> validatePremium(String code) async{
    var profileemail;
    FirebaseAuth.instance.userChanges().listen((user) {
      if(user!=null){
        profileemail=FirebaseAuth.instance.currentUser!.email!;
      }
    });
    List codes=[];
    final snapshot = await firestore.collection("PremiumCodes").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    codes = documents[0]["codeid"];
    if(codes.contains(code)){
      final DocumentReference eventref=firestore.collection("Users").doc(profileemail);
      await eventref.update({"premium":true});
      print("Exists");
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> ispremium() async{
    bool prem=false;
    var profileemail;
    FirebaseAuth.instance.userChanges().listen((user) {
      if(user!=null){
        profileemail=FirebaseAuth.instance.currentUser!.email!;
      }
    });
    final snapshot = await firestore.collection("Users").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      if(element["Emailid"]==profileemail){
        prem=element["premium"];
      }
    }
    return prem;
  }
  Future<List> read() async{
    List<News>news=[];
    final snapshot=await firestore.collection("News").get();
    final List<DocumentSnapshot> documents= snapshot.docs;
    for(DocumentSnapshot element in documents){
      news.add(News(title: element["Title"], desc: element["Description"], isImportant: element["isImportant"], id: element["id"],dateposted: element["DatePosted"]));
    }
    return news;
  }
  Future<List> getallCodes() async{
    List codes=[];
    final snapshot= await firestore.collection("PremiumCodes").get();
    final List<DocumentSnapshot> documents= snapshot.docs;
    codes = documents[0]["codeid"];
    return codes;
  }
  Future<void> addcode(String newcode) async{
    List codes=[];
    final snapshot= await firestore.collection("PremiumCodes").get();
    final List<DocumentSnapshot> documents= snapshot.docs;
    codes = documents[0]["codeid"];
    codes.add(newcode);
    final DocumentReference eventref=firestore.collection("Premium").doc("codes");
    Map<String,dynamic> obj={
      "codeid":codes
    };
    eventref.update({"codeid": codes});

  }



  Future<void> addBookData(Books newbook) async{
    Map<String,dynamic> obj={
      "title": newbook.title,
      "author": newbook.author,
      "description": newbook.description,
      "imageURL": newbook.imageUrl,
      "websiteUrl":newbook.websiteUrl,
      "id": newbook.id
    };

    String docId = newbook.id;
    final DocumentReference eventsRef=firestore.collection("Books").doc(docId);
    await eventsRef.set(obj);
    print("Added Book");
  }

  Future<void> addInternData(Internship newintern) async{
    Map<String,dynamic> obj={
      "name": newintern.name,
      "job_type": newintern.job_type,
      "description": newintern.description,
      "imageURL": newintern.imageUrl,
      "websiteUrl":newintern.websiteUrl,
      "id": newintern.id
    };

    String docId = newintern.id;
    final DocumentReference eventsRef=firestore.collection("Internship").doc(docId);
    await eventsRef.set(obj);
    print("Added Internship");
  }

  Future<List> readBooks() async{
    List<Books> books=[];
    final snapshot=await firestore.collection("Books").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      books.add(
          Books(
          title: element["title"],
          author: element["author"],
          description: element["description"],
          imageUrl: element["imageURL"],
          websiteUrl: element["websiteUrl"],
          id: element["id"]));
    }
    return books;
  }

  Future<List> readInternship() async{
    List<Internship> internship=[];
    final snapshot=await firestore.collection("Internship").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for(DocumentSnapshot element in documents){
      internship.add(
          Internship(
          name: element["name"],
          job_type: element["job_type"],
          description: element["description"],
          imageUrl: element["imageURL"],
          websiteUrl: element["websiteUrl"],
          id: element["id"]));
    }
    return internship;
  }

}
