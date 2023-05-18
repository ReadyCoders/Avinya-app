import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: myConstants.bgColor,
      appBar: AppBar(
        backgroundColor: myConstants.bgColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(child: Text("AVINYA",style: TextStyle(color: myConstants.avinyaText,fontSize: 50),)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100,bottom: 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Container(
            width: size.width,
            height: size.height*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserSelector(size: size, myConstants: myConstants,title: "Student/Members", page: HomePageStudentsMembers(),),
                UserSelector(size: size, myConstants: myConstants,title: "Entrepreneurs",page: HomePageEntrepreneurs(),),
                UserSelector(size: size, myConstants: myConstants,title: "Social Welfare",page: HomePageSocial(),),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
