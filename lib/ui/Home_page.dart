import 'package:flutter/material.dart';

import '../modals/constants.dart';

class HomePageStudentsMembers extends StatefulWidget {
  const HomePageStudentsMembers({Key? key}) : super(key: key);

  @override
  State<HomePageStudentsMembers> createState() => _HomePageStudentsMembersState();
}

class _HomePageStudentsMembersState extends State<HomePageStudentsMembers> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return Scaffold(
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset("assets/profile.png",width: 40,height: 40,),
        ),
        title:
            Center(child: Text("AVINYA")),

      ),
    );
  }
}

