import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/socialui/SocialDonate.dart';
import 'package:avinyaapp/ui/SocialHomepage/socialui/adminsocial.dart';
import 'package:avinyaapp/ui/SocialHomepage/socialui/member_social.dart';
import 'package:avinyaapp/ui/SocialHomepage/socialui/volunteer.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:flutter/material.dart';

import '../../modals/constants.dart';
import '../../modals/widgets.dart';



class MemberSelection extends StatefulWidget {
  const MemberSelection({Key? key}) : super(key: key);

  @override
  State<MemberSelection> createState() => _MemberSelectionState();
}

class _MemberSelectionState extends State<MemberSelection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return Scaffold(
        backgroundColor: myConstants.bgColor,
        appBar: AppBar(
          backgroundColor: myConstants.bgColor,
          elevation: 0,
          title: Center(child: Text("AVINYA",style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: myConstants.DarkBlue,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                    //boxShadow: [BoxShadow(color: Colors.black,blurRadius: 15,)]
                  ),

                  width: size.width,
                  height: size.height*0.55,
                )),
            Positioned(
                top: 140,
                left: 25,
                child: Center(
                  child: Container(
                    width: size.width*0.9,
                    height: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black,blurRadius: 1)
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Text("SELECT USER",style: TextStyle(color: myConstants.DarkBlue,fontWeight: FontWeight.bold,fontSize: 40),),
                        SizedBox(height: 15,),
                        UserSelector(size: size, myConstants: myConstants,title: "MEMBER", page: SocialMember(),),
                        UserSelector(size: size, myConstants: myConstants,title: "VOLUNTEER",page: SocialVolunteer(),),
                        UserSelector(size: size, myConstants: myConstants,title: "ADMIN",page: SocialAdmin(),),
                        UserSelector(size: size, myConstants: myConstants,title: "DONATE",page: SocialDonate(),),
                        SizedBox(height: 40,),
                      ],

                    ),


                  ),
                ))
          ],
        )
    );
  }
}
