import 'package:avinyaapp/modals/Classes.dart';
import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
class ApplicationState extends ChangeNotifier{
  ApplicationState(){
    init();
  }
  List<News> Message=[];
  List<News> ImportantMessage=[];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  List<String> roleselection = <String>["Student/Member","Entrepreneurs","Social Welfare"];
  String dropdown = "Student/Member";
  List<Events> OnlineEvents=[];
  List<Events> OfflineEvents=[];
  List<Events> allEvents=[];
  var currentregistered=true;
  var selected =-1;
  var currentimportant=true;
  Future<void> init() async{
    await Firebase.initializeApp(
    );

  }

}