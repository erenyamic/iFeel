import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ifeel/homepage.dart';
import 'dart:async';
import 'package:ifeel/createAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:ifeel/googleSignIn.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context)=>ChangeNotifierProvider(create: (context)=>GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  MyHomePage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
      ),
  );
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _auth;

  void startRun(){
    _auth=FirebaseAuth.instance;
    var deger=0;
    Timer.periodic(Duration(milliseconds: 1600), (timer) {
      setState(() {
        if(deger==2){
          if(_auth.currentUser!=null){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>homepage()));
            timer.cancel();
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>createAccount()));
            timer.cancel();
          }
        }
        else
          deger++;
      });
    });
  }



  @override
  void initState(){
    startRun();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/ss.png"),
            fit: BoxFit.cover
          ),
        ),
        child: Padding(padding: EdgeInsets.only(bottom: 40),child: Align(alignment: Alignment.bottomCenter,child: CircularProgressIndicator(color: Colors.grey.shade800,),),)
      )
    );
  }
}
