import 'dart:developer';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/modals/Classes.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:avinyaapp/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(){
    readprofile();
  }
  void initstate(){
    readprofile();
    super.initState();
  }
  var profilelist =[];
  var noofCourses= 42;
  var noofBooks= 37;
  var noofProjects=23;
  var details="Determined to make a change";
  var designation ="Member";
  var selected="";
  var emailid="sharanprakash2003@gmail.com";
  var dob="06-07-2003";
  List<String> dropdown= ["Edit profile","Sign Out"];
  var _s = Services();
  String? selectedMenu;
  String mail="";
  Future<void> readprofile() async{
    List<Profile> temp = await _s.getprofile(FirebaseAuth.instance.currentUser!.email!) as List<Profile>;
    setState(() {
      profilelist=temp;
    });
  }
  @override
  Widget build(BuildContext context){
    var currentprofile= profilelist[0]!;
    Size size = MediaQuery.of(context).size;
    Future<void> signoutconfirm() async{
      return showDialog(
          barrierDismissible: false,
          context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Sign Out?"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            OutlinedButton(onPressed: (){
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }).onError((error, stackTrace){
                print(error.toString());
                Navigator.of(context).pop();
              });
            }, child: Text("Yes")),
            OutlinedButton(onPressed: (){
              Navigator.of(context).pop();
            },
                child: Text("No"))
          ],
        );

      });
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xeeffffff),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 40,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text("My Corner",style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black,shadows: <Shadow>[
          Shadow(color: Colors.white,blurRadius: 10),
          Shadow(color: Colors.white,blurRadius: 10),
          Shadow(color: Colors.white,blurRadius: 10)
        ]),),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (String? item) {

              setState(() {
                selectedMenu = item;
              }
              );
              switch(selectedMenu){
                case "Sign Out":{
                  signoutconfirm();
                }
                break;
                case "Edit Profile":{
                  print("Edit Profile");
                }
                break;
              }
              print(selectedMenu);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "Edit Profile",
                child: Text('Edit Profile'),
              ),
              const PopupMenuItem<String>(
                value: "Sign Out",
                child: Text('Sign Out'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top:0,
            child: Container(
              width: size.width,
              height: size.height*0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Positioned(
            top: size.height*0.42,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(currentprofile.Username,style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold,color: Colors.white),),
                Text(currentprofile.desc,style: GoogleFonts.poppins(fontSize: 24,color: Colors.white),),
            ],

          ),
              )),
          Positioned(
            bottom: 0,
              child: Container(
                width: size.width,
                height: size.height*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(color: Colors.black,blurRadius: 5,offset: Offset(0,-2))
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height*0.06,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(currentprofile.courses.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Courses",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Purchased",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(currentprofile.books.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Books",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Purchased",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(currentprofile.projects.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Projects",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Alloted",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DOB: ",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),
                            SizedBox(height: 15,),
                            Text("Email id: ",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentprofile.Dob,style: GoogleFonts.poppins(fontSize: 18),),
                            SizedBox(height: 15,),
                            Text(FirebaseAuth.instance.currentUser!.email!,style: GoogleFonts.poppins(fontSize: 18),),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),

          )),
          Positioned(
              bottom: 40,
              child: SizedBox(width:size.width,child: Center(child: OutlinedButton(onPressed: signoutconfirm, child: Text("Sign Out",style: GoogleFonts.poppins(fontSize: 24,color: Colors.black),)))))
        ],

      ),

    );
  }
}
