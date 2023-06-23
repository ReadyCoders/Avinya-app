import 'package:avinyaapp/ui/StudentHomepage/feature/news_feed.dart';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/material.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:outlined_text/outlined_text.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  Map<String,dynamic> Startups= {"Name":["Details1","Description"],"Name1":["Details1","Description"],"Name2":["Details1","Description"],"Name3":["Details1","Description"],
    "Name4":["Details1","Description"],"Name5":["Details1","Description"],"Name6":["Details1","Description"],"Name7":["Details1","Description"],"Name8":["Details1","Description"],};
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
      backgroundColor: Color(0xeeffffff),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRect(
            child: Image.asset("assets/profile.png"),
          ),
        ),
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: Color(0xeeeeeeee),
        actions: [SizedBox(width: 50,)],
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
                  //color: myConstants.secondaryColor,
                  image: DecorationImage(
                      image: AssetImage("assets/UserBG.jpeg",),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                ),

              )),
          Positioned(
              top:15,
              left: 0,
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: Container(
                    width: size.width*0.8,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const Center(child: OutlinedText(text: Text("PROJECTS/STARTUP",style: TextStyle(fontSize: 32),))),


                  ),
                ),
              )),
          Positioned(
              top: 155,
              left: 20,
              child: SizedBox(
                width: size.width*0.9,
                height: size.height,
                child: GridView.count(crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: (1/1.4),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 50,
                  children: [
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[0], page: UserFeed(),Imageurl: "assets/news.png",StartupsList: Startups,index: 0,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[1], page: UserSelection(),Imageurl: "assets/Mentorship.png",StartupsList: Startups,index: 1,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[2], page: UserSelection(),Imageurl: "assets/Projects.png",StartupsList: Startups,index: 2,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[3], page: UserSelection(),Imageurl: "assets/Events.png",StartupsList: Startups,index: 3,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[4], page: UserSelection(),Imageurl: "assets/Courses.png",StartupsList: Startups,index: 4,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[5], page: UserSelection(),Imageurl: "assets/Books.png",StartupsList: Startups,index: 5,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[6], page: UserSelection(),Imageurl: "assets/Internship.png",StartupsList: Startups,index: 6,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[7], page: UserSelection(),Imageurl: "assets/Gift.png",StartupsList: Startups,index: 7,),
                    Startupwidget(myConstants: myConstants, heading: Startups.keys.toList()[8], page: UserSelection(),Imageurl: "assets/Review.png",StartupsList: Startups,index: 8,),
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

