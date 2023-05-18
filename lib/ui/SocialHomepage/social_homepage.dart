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
      appBar: AppBar(
        title:
        Center(child: Text("AVINYA")),
      ),
      body: Center(child: Text("Social page here")),
    );
  }
}

