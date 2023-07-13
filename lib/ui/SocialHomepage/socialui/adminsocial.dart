import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/Books_page.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/events.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/news_feed.dart';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/material.dart';

class SocialAdmin extends StatefulWidget {
  const SocialAdmin({Key? key}) : super(key: key);
  @override
  State<SocialAdmin> createState() => _SocialAdminState();
}

class _SocialAdminState extends State<SocialAdmin> {
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
    int notificationno=34;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              top: 10,
              child: SizedBox(width:size.width,child: Center(child: Text("FOR ADMINS",style: TextStyle(color: myConstants.DarkBlue,fontSize: 30,fontWeight: FontWeight.bold))))),
          Positioned(
              top: 110,
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
              top: 250,
              left: 20,
              child: SizedBox(
                width: size.width*0.9,
                height: 700,
                child: GridView.count(crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: (1/1.4),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 50,
                  children: [
                    Featureswidget(myConstants: myConstants, heading: 'News Feed', page: UserFeed(isadmin: true),Imageurl: "assets/news.png",),
                    Featureswidget(myConstants: myConstants, heading: "Books", page: BooksPage(), Imageurl: "assets/Books.png"),
                    Featureswidget(myConstants: myConstants, heading: 'Event List', page: EventsPage(),Imageurl: "assets/Events.png",),
                    Featureswidget(myConstants: myConstants, heading: 'My Zone ', page: UserSelection(),Imageurl: "assets/Internship.jpeg",),
                    Featureswidget(myConstants: myConstants, heading: 'Meeting', page: UserSelection(),Imageurl: "assets/Internship.jpeg",),
                    Featureswidget(myConstants: myConstants, heading: 'Raising Fund', page: UserSelection(),Imageurl: "assets/Internship.jpeg",),
                    Featureswidget(myConstants: myConstants, heading: 'Best Performer', page: UserSelection(),Imageurl: "assets/Internship.jpeg",),
                  ],),
              ))
        ],


      ),
    );
  }
}


