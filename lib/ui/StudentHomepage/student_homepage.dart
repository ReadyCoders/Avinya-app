import 'package:flutter/material.dart';

import '../../modals/constants.dart';

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
        title:
        Center(child: Text("AVINYA")),
      ),
      body: Center(child: Text("Studentpage here")),
    );
  }
}

