import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
class ApplicationState extends ChangeNotifier{
  String name="Login As";
  int user_selected= 0;
  String user= "Student/Members";
  void change(){
    this.name="Changed";
    notifyListeners();
  }
  void getUser(){
    switch(user_selected){
      case 0:{
        this.user="Student/Members";
      }
      break;
      case 1:{
        this.user="Entrepreneurs";
      }
      break;
      case 2:{
        this.user="Social Welfare";
      }
      break;
    }
    notifyListeners();


  }
  Widget pushpage(){
    switch(user_selected){
      case 0:{
        return HomePageStudentsMembers();
      }
      break;
      case 1:{
        return HomePageEntrepreneurs();
      }
      break;
      case 2:{
        return HomePageSocial();
      }
      break;
      default:{
        return Scaffold();
      }
    }
  }
  void nextuser(){
    this.user_selected=this.user_selected==2?0:this.user_selected+1;
    notifyListeners();
    getUser();

  }
  void prevuser(){
    this.user_selected=this.user_selected==0?2:this.user_selected-1;
    notifyListeners();
    getUser();

  }




}