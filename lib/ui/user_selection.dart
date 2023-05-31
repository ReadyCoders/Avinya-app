import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

import '../modals/constants.dart';
import '../modals/widgets.dart';

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
    var appState=context.watch<ApplicationState>();
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

        )),
        Positioned(
            top: size.height*0.6,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("WELCOME TO AVINYA",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("A singular App to \nConnect, Learn and Help",style: TextStyle(color: Colors.white,fontSize: 30)),

                ]
            )),
        Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2)]
              ),
          width: size.width,
          height: size.height*0.23,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: 10,
                      left: 0,
                      child: SizedBox( height: 50,width:size.width,child: Center(child: Text("LOGIN AS",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: myConstants.DarkBlue),)))),
                  Positioned(
                      top:65,
                      left:size.width*.05,
                      child: Swipe(
                        onSwipeLeft: (){appState.nextuser();},
                        onSwipeRight: (){appState.prevuser();},
                        child: Container(
                          width: size.width*.9,
                          height: 80,
                          decoration: BoxDecoration(
                            color: myConstants.bgColor,
                            borderRadius: const BorderRadius.all(Radius.circular(30))

                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(child: Container(height: 300,width: 40,decoration: BoxDecoration(color: myConstants.primaryColor.withOpacity(.3),borderRadius: const BorderRadius.all(Radius.circular(30),),),child: Center(child: Text("<",style: TextStyle(fontSize: 40,color: myConstants.DarkBlue),)),),onTap: (){appState.prevuser();}),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(child: Text(appState.user.toUpperCase(),style: const TextStyle(fontSize: 30),)),
                                    ),
                                    GestureDetector(child: Container(height: 300,width: 40,decoration: BoxDecoration(color: myConstants.primaryColor.withOpacity(.3),borderRadius: const BorderRadius.all(Radius.circular(30),),),child: Center(child: Text(">",style: TextStyle(fontSize: 40,color: myConstants.DarkBlue),)),),onTap: (){appState.nextuser();},),

                                  ],
                                ),
                              )

                            ],
                        ),
                          ),
                  ),
                      )),
                  Positioned(
                    bottom: 30,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(height: 10,width: 40,decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),color: appState.user_selected==0?myConstants.primaryColor:myConstants.DarkBlue,)),
                          const SizedBox(width: 15,),
                          Container(height: 10,width: 40,decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),color: appState.user_selected==1?myConstants.primaryColor:myConstants.DarkBlue,)),
                          const SizedBox(width: 15,),
                          Container(height: 10,width: 40,decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),color: appState.user_selected==2?myConstants.primaryColor:myConstants.DarkBlue,))
                        ],)),
                  Positioned(bottom:20,right:40,child: GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> appState.pushpage()));},child: Container(decoration:BoxDecoration(color: myConstants.primaryColor,borderRadius: const BorderRadius.all(Radius.circular(30))),height: 40,width: 80,child: const Icon(Icons.arrow_forward)),))
                ],
              ),
        )),
      ],
    )
    );
  }
}
