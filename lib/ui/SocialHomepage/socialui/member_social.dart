import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:flutter/material.dart';

class SocialMember extends StatefulWidget {
  const SocialMember({Key? key}) : super(key: key);

  @override
  State<SocialMember> createState() => _SocialMemberState();
}

class _SocialMemberState extends State<SocialMember> {

  int selectedIndex = 0;
  void OnTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> news=["news1","news2","news3","news4","news5","news6","news7"];
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();

    return Scaffold(
      backgroundColor: myConstants.bgColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRect(
            child: Image.asset("assets/profile.png"),
          ),
        ),
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: myConstants.bgColor,
        actions: [
          SizedBox(width: 50,)
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 10,
              child: SizedBox(width:size.width,child: Center(child: Text("FOR SOCIAL WELFARE",style: TextStyle(color: myConstants.DarkBlue,fontSize: 30,fontWeight: FontWeight.bold))))),
          Positioned(
              top: 110,
              child: Container(

                width: size.width,
                height: size.height*0.9,
                decoration: BoxDecoration(
                  color: myConstants.DarkBlue,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                ),

              )),
          Positioned(
              top:70,
              left: 20,
              child: Container(
                width: size.width*0.9,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Center(child: Text("BANNER HERE")),


              )),
          Positioned(
              top: 200,
              left: 40,
              child: SizedBox(height: 450,width: size.width*0.8,child: ListView.builder(
    itemCount: news.length,
                  scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context,int index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: myConstants.bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,1),
                      blurRadius: 5,
                      color: Colors.white.withOpacity(.3),

                    )
                  ]
              ),
              child: Center(child: Text(news[index])),
            ),
          );
    }
              ),)),
          Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          memberfeature(size: size,width: size.width*0.3,text: "HELP",),
                          memberfeature(size: size,width: size.width*0.3,text: "EVENTS",),
                          memberfeature(size: size,width: size.width*0.3,text: "COURSE",),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          memberfeature(size: size,width: size.width*0.46,text: "ONLINE SABHA",),
                          memberfeature(size: size,width: size.width*0.46,text: "SUPPORT",),

                        ],
                      ),
                      SizedBox(height: 10,),
                    ],

          ),
                ),
              ))
        ],


      ),
    );
  }
}


