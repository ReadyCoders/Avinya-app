import 'package:avinyaapp/ui/StudentHomepage/feature/Books_page.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/CoursesPage.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/Gift_page.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/Internship_page.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/MentorshipPage.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/Review_page.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/events.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/news_feed.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/projects.dart';
import 'package:avinyaapp/ui/profile_page.dart';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modals/constants.dart';
import '../../modals/widgets.dart';

class HomePageStudentsMembers extends StatefulWidget {
  const HomePageStudentsMembers({Key? key}) : super(key: key);

  @override
  State<HomePageStudentsMembers> createState() => _HomePageStudentsMembersState();
}

class _HomePageStudentsMembersState extends State<HomePageStudentsMembers> {

  int selectedIndex = 0;
  Future<void> OnTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
    if(index==2){
      Uri url= Uri.parse("https://meet.google.com/");
      if(!await launchUrl(url,mode: LaunchMode.externalApplication)){
    throw Exception("Count launch");
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
    Constants myConstants= Constants();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xeeffffff),
      appBar: AppBar(
        leading: Profileroute(),
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: Color(0xeeeeeeee),
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
              left: 20,
              child: Container(
                width: size.width*0.9,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Marquee(
                      text: "Technology was the key to my freedom.",
                    style: GoogleFonts.poppins(fontSize: 24),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    blankSpace: 100.0,
                    velocity: 30.0,
                    startPadding: 50.0,

                  ),
                )

                ),


              )),
          Positioned(
              top:20,left:20,child: Image.asset("assets/Quotes1.png",width: 60,)),
          Positioned(
              top: 70,right: 20,
              child: Image.asset("assets/Quotes2.png",width: 60,)),
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
                  Featureswidget(myConstants: myConstants, heading: 'NEWS FEED', page: UserFeed(isadmin: false),Imageurl: "assets/news.png",premiummatter: false,),
                  Featureswidget(myConstants: myConstants, heading: 'MENTORSHIP', page: MentorsPage(),Imageurl: "assets/Mentorship.png",premiummatter: true,),
                  Featureswidget(myConstants: myConstants, heading: 'PROJECTS', page: ProjectsPage(),Imageurl: "assets/Projects.png",premiummatter: true,),
                  Featureswidget(myConstants: myConstants, heading: 'EVENTS', page: EventsPage(),Imageurl: "assets/Events.png",premiummatter: false,),
                  Featureswidget(myConstants: myConstants, heading: 'COURSES', page: CoursesPage(),Imageurl: "assets/Courses.png",premiummatter: true,),
                  Featureswidget(myConstants: myConstants, heading: 'BOOKS', page: BooksPage(isadmin: false,),Imageurl: "assets/Books.png",premiummatter: true,),
                  Featureswidget(myConstants: myConstants, heading: 'INTERNSHIP', page: InternPage(isadmin: false,),Imageurl: "assets/Internship.png",premiummatter: true,),
                  Featureswidget(myConstants: myConstants, heading: 'GIFT', page: GiftPage(),Imageurl: "assets/Gift.png",premiummatter: false,),
                  Featureswidget(myConstants: myConstants, heading: 'REVIEW', page: ReviewPage(),Imageurl: "assets/Review.png",premiummatter: false,),
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



