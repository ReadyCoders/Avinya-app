import 'dart:ui';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:avinyaapp/ui/EntrepreneursHomepage/entre_homepage.dart';
import 'package:avinyaapp/ui/SocialHomepage/social_homepage.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:avinyaapp/ui/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _s= Services();
  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    var myapp = context.watch<ApplicationState>();
    var emailid=TextEditingController();
    var pwd= TextEditingController();
    var pwderror=false;

    return LayoutBuilder(
      builder: (BuildContext , BoxConstraints ) {var loading = false;
       return Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: Color(0xeeeeeeee),
         //appBar: AppBar(backgroundColor:  Color(0xdddddddd),title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),),
         body: Stack(
           alignment: Alignment.bottomCenter,
           fit: StackFit.expand,
           children: <Widget>[
             Image.asset("assets/UserBG.jpeg",height: size.height,fit: BoxFit.cover,alignment: Alignment.bottomCenter,),
             ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                 child: ShaderMask(
                   shaderCallback: (rect) {
                     return LinearGradient(
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                         colors: [Colors.black, Colors.black.withOpacity(0)],
                         stops: [0.7, 0.9]).createShader(rect);
                   },
                   blendMode: BlendMode.dstIn,
                   child: Container(color: Color(0xeeeeeeee)),
                 )
             ),
             Positioned(
                 top: 80,left: 20,
                 child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text("Login",style: TextStyle(fontSize: 40),),
                 SizedBox(height: 20,),
                 Container(width: size.width*.5,height: 10,
                     child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 0,sigmaX: 2),
                     child: ShaderMask(
                       shaderCallback: (rect) {
                         return LinearGradient(
                             begin: Alignment.centerLeft,
                             end: Alignment.centerRight,
                             colors: [Colors.black, Colors.black.withOpacity(0)],
                             stops: [0.4, 0.95]).createShader(rect);
                       },
                       blendMode: BlendMode.dstIn,
                       child: Container(color: Colors.black),
                     )
                 ),),
               ],)),
             Positioned(top:100,child: SizedBox(
               width: size.width*.92,
               height: size.height*.7,
               child: Center(
                 child: Container(
                   width: size.width*.8,
                   height: size.height*.5,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       //Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),

                       ReusableTextfields(controller: myapp.emailController,isPassword: false, icon: Icons.person_2, text: 'Email Id',),
                       SizedBox(height: 40,),
                       ReusableTextfields(controller: myapp.passwordcontroller, isPassword: true, icon: Icons.lock, text: "Password"),
                       Visibility(visible:pwderror,child: Column(
                         children: [
                           SizedBox(height: 20,),
                           Text("Invalid Password",style: GoogleFonts.poppins(color: Colors.red,fontSize: 20),),
                         ],
                       )),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(child: Text("Forgot Password",
                             style: TextStyle(fontSize:20,color:Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),),
                             onPressed: (){

                             },
                           )

                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(child: Text("I Dont Have An Account",style: TextStyle(fontSize:20,color:Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),),
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                             },)
                         ],
                       ),

                       SizedBox(height: 20,),
                       Column(
                         children: [
                           Center(child: ElevatedButton(
                             onPressed: () async{
                               FocusScope.of(context).unfocus();
                               setState(() {
                                 loading=true;
                               });
                               Widget? page;
                               FirebaseAuth.instance.signInWithEmailAndPassword(email: myapp.emailController.text, password: myapp.passwordcontroller.text).then((value) async {
                                 var role = await _s.fetchRole(myapp.emailController.text) as String;
                                 switch(role){
                                   case "Student/Member":
                                     {
                                       setState(() {
                                         page = HomePageStudentsMembers();
                                       });
                                     }
                                     break;
                                   case "Entrepreneurs":{
                                     setState(() {
                                       page= HomePageEntrepreneurs();
                                     });

                                   }
                                   break;
                                   case "Social Welfare":{
                                     setState(() {
                                       page= HomePageSocial();
                                     });

                                   }
                                 }
                                 setState(() {
                                   myapp.emailController.clear();
                                   myapp.passwordcontroller.clear();
                                   myapp.notifyListeners();
                                 });

                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>page!));

                               }).onError((error, stackTrace){
                                 if(error.toString()=="[firebase_auth/wrong-password] The password is invalid or the user does not have a password."){
                                   const snackbar=SnackBar(content: Center(child: Text("Credentials dont match")));
                                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                 }
                                 print("Error: ${error.toString()}");
                               });

                             },
                             child: Text("LOGIN",
                               style: TextStyle(fontFamily: "Open Sans",fontSize: 32),),
                             style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,foregroundColor: Colors.white),)),
                           Visibility(
                             visible: loading,
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: SpinKitFadingCircle(
                                 color: Colors.black,
                                 size: 50,

                               ),
                             ),
                           ),
                         ],
                       ),

                     ],
                   ),
                 ),
               ),
             ),),
           ],
         ),

       );});
  }
}

