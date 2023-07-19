import 'package:avinyaapp/modals/widgets.dart';
import 'package:flutter/material.dart';

import '../../modals/constants.dart';

class HomePageEntrepreneurs extends StatefulWidget {
  const HomePageEntrepreneurs({Key? key}) : super(key: key);

  @override
  State<HomePageEntrepreneurs> createState() => _HomePageEntrepreneursState();
}

class _HomePageEntrepreneursState extends State<HomePageEntrepreneurs> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return Scaffold(
      appBar: AppBar(
        leading: Profileroute(),
        title:Center(child: Text("AVINYA")),
        centerTitle: true,
      ),
      body: Center(child: Text("Entrepreneurs page here")),
    );
  }
}

