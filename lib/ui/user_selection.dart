import 'dart:ui';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:avinyaapp/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/constants.dart';

class UserSelection extends StatefulWidget {
  const UserSelection({Key? key}) : super(key: key);

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return ChangeNotifierProvider(
      create: (context)=>ApplicationState(),
      child: UserHome(myConstants: myConstants, size: size));
  }
}
class UserHome extends StatelessWidget {
  const UserHome({
    super.key,
    required this.myConstants,
    required this.size,
  });

  final Constants myConstants;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: myConstants.bgColor,
    body: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/UserBG.jpeg"), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.0,
                  sigmaY: 2.0
                ),
                child: Container(),
              ),

        )),
        Positioned(
            top: size.height*0.65,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("WELCOME TO AVINYA",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
                  SizedBox(height: 10,),
                  Text("A Single Platform to \nConnect, Learn and Help",style: TextStyle(color: Colors.white,fontSize: 30)),

                ]
            )),

        Positioned(
          bottom: size.height*0.07,
            child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Opacity(
                    opacity: 0.85,
                    child: SizedBox(
                        width:size.width,
                        child: Center(
                            child: Container(
                                decoration:const BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20)),color: Colors.white,),
                                width: size.width*.6,
                                height: 50,
                                child: Center(
                                    child: Text("Get Started",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.7)),))))))))
      ],
    )
    );
  }
}
