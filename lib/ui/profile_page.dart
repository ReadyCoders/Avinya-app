import 'package:avinyaapp/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var noofCourses= 42;
  var noofBooks= 37;
  var noofProjects=23;
  var name="Sharan Prakash";
  var details="Determined to make a change";
  var designation ="Member";
  var selected="";
  var emailid="sharanprakash2003@gmail.com";
  var dob="06-07-2003";
  List<String> dropdown= ["Edit profile","Sign Out"];

  String? selectedMenu;
  @override
  Widget build(BuildContext context) {
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
                Text(name,style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold,color: Colors.white),),
                Text(details,style: GoogleFonts.poppins(fontSize: 24,color: Colors.white),),
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
                    SizedBox(height: size.height*0.1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(noofCourses.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Courses",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Purchased",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(noofBooks.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Books",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Purchased",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(noofProjects.toString(),style: GoogleFonts.poppins(fontSize: 42,fontWeight: FontWeight.bold),),
                            Text("Projects",style: GoogleFonts.poppins(fontSize: 24,),),
                            Text("Alloted",style: GoogleFonts.poppins(fontSize: 24,),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Text("DOB: "+dob),
                    Text("Email id: "+emailid)
                  ],
                ),

          ))
        ],

      ),

    );
  }
}
