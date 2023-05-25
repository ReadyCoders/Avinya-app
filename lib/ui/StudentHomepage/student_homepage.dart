import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/material.dart';
import '../../modals/constants.dart';
import '../../modals/widgets.dart';

class HomePageStudentsMembers extends StatefulWidget {
  const HomePageStudentsMembers({Key? key}) : super(key: key);

  @override
  State<HomePageStudentsMembers> createState() => _HomePageStudentsMembersState();
}

class _HomePageStudentsMembersState extends State<HomePageStudentsMembers> {

  int selectedIndex = 0;
  void OnTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
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
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 5,
                    right: 25,

                    child: IconButton(onPressed: (){print("Open chat");},icon: Icon(Icons.message,color: myConstants.DarkBlue,size: 35,),)),
                Positioned(
                  top: 4,
                    right: 15,
                    child: Container(
                    decoration: BoxDecoration(
                      color: myConstants.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          color: Colors.black,
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(notificationno.toString(),style: TextStyle(color: myConstants.DarkBlue,fontWeight: FontWeight.bold, fontSize: 15),),
                    )))
              ],
            ),
          )
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [

          Positioned(
              top: 50,
              child: Container(

            width: size.width,
            height: size.height*0.9,
            decoration: BoxDecoration(
              color: myConstants.DarkBlue,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
            ),

          )),
          Positioned(
              top:15,
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
              top: 175,
              left: 20,
              child: SizedBox(
              width: size.width*0.9,
              height: size.height,
                child: GridView.count(crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: (1/1.4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                children: [
                  Featureswidget(myConstants: myConstants, heading: 'News Feed', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Mentorship', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Projects', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Events', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Courses', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Books', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Internship', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Gift', page: UserSelection(),),
                  Featureswidget(myConstants: myConstants, heading: 'Review', page: UserSelection(),),
                ],),
          ))
          /*Positioned(
              child: Text("Details here"),

          ),*/
        ],
        

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38,blurRadius: 10),
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.book),label: "My Resources"),
              BottomNavigationBarItem(icon: Icon(Icons.quiz),label: "Quiz"),
              BottomNavigationBarItem(icon: Icon(Icons.video_call),label: "Meet")
            ],
            selectedItemColor: myConstants.DarkBlue,
            currentIndex: selectedIndex,
            onTap: OnTapped,
          ),
        ),
      ),
      );
  }
}

