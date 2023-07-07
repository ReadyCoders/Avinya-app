import 'dart:ui';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext , BoxConstraints ) {
          var myapp= context.watch<ApplicationState>();
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
                    top: 100,right: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Signup",style: TextStyle(fontSize: 40),),
                        SizedBox(height: 20,),
                        Container(width: size.width*.6,height: 10,
                          child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 0,sigmaX: 2),
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Colors.black, Colors.black.withOpacity(0)],
                                      stops: [0.2, 0.9]).createShader(rect);
                                },
                                blendMode: BlendMode.dstOut,
                                child: Container(color: Colors.black),
                              )
                          ),),
                      ],)),
                Positioned(top:200,child: SizedBox(
                  width: size.width*.92,
                  height: size.height*.8,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: size.width*.8,
                        height: size.height*.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFD9D9D9),
                                filled: true,
                                labelText: "User Name",
                                hintText: "User Name",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text){
                                myapp.namecontroller.text=text;
                                myapp.notifyListeners();
                              },
                            ),
                            SizedBox(height: 40,),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFD9D9D9),
                                filled: true,
                                labelText: "Email id",
                                hintText: "Email id",
                                border: OutlineInputBorder(),

                              ),
                              onChanged: (text){
                                myapp.emailController.text=text;
                                myapp.notifyListeners();
                              },
                            ),
                            SizedBox(height: 40,),
                            TextField(
                              controller: myapp.datecontroller,
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFD9D9D9),
                                filled: true,
                                hintText: "Date Of Birth",
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1990),
                                    lastDate: DateTime.now());
                                if(pickedDate!=null){
                                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                  print(formattedDate);
                                  setState(() {
                                    myapp.datecontroller.text=formattedDate;
                                    myapp.notifyListeners();
                                  });
                                }
                              },

                            ),
                            SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Choose Role",style: TextStyle(fontSize: 20),),
                                Spacer(),
                                DropdownButton(
                                    value: myapp.dropdown,
                                    icon: Icon(Icons.person),
                                    underline: Container(height: 2,width: size.width,color: Colors.black,),
                                    items: myapp.roleselection.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value){
                                      myapp.dropdown=value!;
                                      myapp.notifyListeners();
                                    }),
                              ],
                            ),
                            SizedBox(height: 40,),
                            TextFormField(
                              //initialValue: "Password",
                              decoration: InputDecoration(
                                  fillColor: const Color(0xFFD9D9D9),
                                  filled: true,
                                  labelText: "Password",
                                  border: OutlineInputBorder()
                              ),
                              obscureText: true,
                              onChanged: (text){
                                myapp.passwordcontroller.text=text;
                                myapp.notifyListeners();
                              },
                            ),
                            SizedBox(height: 40,),
                            TextFormField(
                              //initialValue: "Password",
                              decoration: InputDecoration(

                                  fillColor: const Color(0xFFD9D9D9),
                                  filled: true,
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                              onChanged: (text){
                                myapp.confirmpasswordcontroller.text=text;
                                myapp.notifyListeners();
                              },
                            ),
                            SizedBox(height: 20,),
                            Center(child: ElevatedButton(

                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,foregroundColor: Colors.white),
                                onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              print(myapp.namecontroller.text);
                              print(myapp.dropdown);
                            }, child: Text("Register",style: TextStyle(fontFamily: "Open Sans",fontSize: 32),))),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),),
              ],
            ),

          );});
  }
}
