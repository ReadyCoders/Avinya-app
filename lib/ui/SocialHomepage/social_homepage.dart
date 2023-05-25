import 'package:avinyaapp/ui/SocialHomepage/member_selector.dart';
import 'package:flutter/material.dart';

import '../../modals/constants.dart';

class HomePageSocial extends StatefulWidget {
  const HomePageSocial({Key? key}) : super(key: key);

  @override
  State<HomePageSocial> createState() => _HomePageSocialState();
}

class _HomePageSocialState extends State<HomePageSocial> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return Scaffold(
      backgroundColor: myConstants.bgColor,
      appBar: AppBar(
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: myConstants.bgColor,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
              child: SizedBox(width:size.width,child: Center(child: Text("FOR SOCIAL WELFARE",style: TextStyle(color: myConstants.DarkBlue,fontSize: 30,fontWeight: FontWeight.bold))))),
          Positioned(
              bottom: 0,
              child: Container(
            width: size.width,
            height: size.height*0.4,
                decoration: BoxDecoration(
                  color: myConstants.DarkBlue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                ),
          )),
          Positioned(
              top:200,
              left: 0,
              child: SizedBox(width:size.width,child: Center(child: Text("SELECT LANGUAGE",style: TextStyle(color: myConstants.DarkBlue,fontSize: 30,fontWeight: FontWeight.bold))))),
          Positioned(
              top: 300,
              left: 35,
              child: Container(
            width: size.width*.85,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topCenter,
                    colors: [
                      myConstants.bgColor.withOpacity(0.85),
                      Colors.white,
                    ]),
              boxShadow: [
                BoxShadow(color: Colors.black,blurRadius: 2),
              ]
            ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    languageSelector(myConstants: myConstants,text: "ENGLISH",isEnglish: true,),
                    languageSelector(myConstants: myConstants,text: "HINDI",isEnglish: false,),
                    SizedBox(height: 150,)
                  ],

                ),
          ))
        ],
      )
    );
  }
}

class languageSelector extends StatelessWidget {
  const languageSelector({
    super.key,
    required this.myConstants,
    required this.text,
    required this.isEnglish,
  });

  final Constants myConstants;
  final String text;
  final bool isEnglish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MemberSelection()));
        },
        child: Container(width: 150,height: 60,decoration: BoxDecoration(color: myConstants.DarkBlue,borderRadius: BorderRadius.all(Radius.circular(40))),child: Center( child: Text(text,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)))));
  }
}

