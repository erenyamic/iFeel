import 'package:fl_chart/fl_chart.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'dart:io';



class charts extends StatefulWidget{
 State createState()=>charts_();
}
class charts_ extends State{
  var emojiParser=EmojiParser();
  var _auth;
  var db;
  List<String> veriler=[];
  List<String> veriler2=[];
  List<String> veriler3=[];
  List<int> veriler_sayisal=[];
  double a_=0,b_=0,c_=0,d_=0,e_=0,f_=0;
  var dizi_;
  var dizi2;
  var sayac1_=0;
  var sayac2_=0;
  var sayac3_=0;
  var sayac4_=0;
  var sayac5_=0;
  var sayac6_=0;

  @override
  void initState(){
    _auth=FirebaseAuth.instance;
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref('Çalışanlar');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      var g=data.toString().replaceAll(RegExp("{|}|subtitle: |title: "),"");
      g.trim();
     // print(g);
      veriler3=g.split('-N');
      for(var item in veriler3){
        if(item.contains(_auth.currentUser!.email.toString())&&Platform.isIOS){
           dizi_=item.split("---");
           dizi2=dizi_[4].split(" ");
           //dizi2[2].toString().replaceAll(" ", "");
           veriler.add(dizi2[2]);


        }
        else if(item.contains(_auth.currentUser!.email.toString())&&Platform.isAndroid){
          dizi_=item.split("---");
          dizi2=dizi_[3].split(" ");
          //print(dizi2[2]);
          //dizi2[2].toString().replaceAll(" ", "");
          veriler.add(dizi2[2]);
        }
      }
      if(!veriler.isEmpty){
        for(var aaa in veriler){

          double value=double.parse(aaa);
          if(value>=0&&value<16.6){sayac1_++;}
          else if(value>=16.6&&value<33.2){sayac2_++;}
          else if(value>=33.2&&value<49.8){sayac3_++;}
          else if(value>=49.8&&value<66.4){sayac4_++;}
          else if(value>=66.4&&value<83){sayac5_++;}
          else if(value>=83&&value<=100){sayac6_++;}


        }
      }else{
        sayac1_=1;
        sayac2_=1;
        sayac3_=1;
        sayac4_=1;
        sayac5_=1;
        sayac6_=1;
      }
      veriler_sayisal.add(sayac1_);
      veriler_sayisal.add(sayac2_);
      veriler_sayisal.add(sayac3_);
      veriler_sayisal.add(sayac4_);
      veriler_sayisal.add(sayac5_);
      veriler_sayisal.add(sayac6_);
      veriler_sayisal.sort();
      setState(() {
        if(sayac1_==veriler_sayisal[0]){
          a_=1;
        }else if(sayac1_==veriler_sayisal[1]){
          a_=2;
        }else if(sayac1_==veriler_sayisal[2]){
          a_=3;
        }else if(sayac1_==veriler_sayisal[3]){
          a_=4;
        }else if(sayac1_==veriler_sayisal[4]){
          a_=5;
        }else if(sayac1_==veriler_sayisal[5]){
          a_=6;
        }

        if(sayac2_==veriler_sayisal[0]){
          b_=1;
        }else if(sayac2_==veriler_sayisal[1]){
          b_=2;
        }else if(sayac2_==veriler_sayisal[2]){
          b_=3;
        }else if(sayac2_==veriler_sayisal[3]){
          b_=4;
        }else if(sayac2_==veriler_sayisal[4]){
          b_=5;
        }else if(sayac2_==veriler_sayisal[5]){
          b_=6;
        }

        if(sayac3_==veriler_sayisal[0]){
          c_=1;
        }else if(sayac3_==veriler_sayisal[1]){
          c_=2;
        }else if(sayac3_==veriler_sayisal[2]){
          c_=3;
        }else if(sayac3_==veriler_sayisal[3]){
          c_=4;
        }else if(sayac3_==veriler_sayisal[4]){
          c_=5;
        }else if(sayac3_==veriler_sayisal[5]){
          c_=6;
        }

        if(sayac4_==veriler_sayisal[0]){
          d_=1;
        }else if(sayac4_==veriler_sayisal[1]){
          d_=2;
        }else if(sayac4_==veriler_sayisal[2]){
          d_=3;
        }else if(sayac4_==veriler_sayisal[3]){
          d_=4;
        }else if(sayac4_==veriler_sayisal[4]){
          d_=5;
        }else if(sayac4_==veriler_sayisal[5]){
          d_=6;
        }

        if(sayac5_==veriler_sayisal[0]){
          e_=1;
        }else if(sayac5_==veriler_sayisal[1]){
          e_=2;
        }else if(sayac5_==veriler_sayisal[2]){
          e_=3;
        }else if(sayac5_==veriler_sayisal[3]){
          e_=4;
        }else if(sayac5_==veriler_sayisal[4]){
          e_=5;
        }else if(sayac5_==veriler_sayisal[5]){
          e_=6;
        }

        if(sayac6_==veriler_sayisal[0]){
          f_=1;
        }else if(sayac6_==veriler_sayisal[1]){
          f_=2;
        }else if(sayac6_==veriler_sayisal[2]){
          f_=3;
        }else if(sayac6_==veriler_sayisal[3]){
          f_=4;
        }else if(sayac6_==veriler_sayisal[4]){
          f_=5;
        }else if(sayac6_==veriler_sayisal[5]){
          f_=6;
        }
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("iFeel Analizi"),
          backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/img/art.png"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),child: Container(
                      height: MediaQuery.of(context).size.height/3,
                      child: Padding(padding: EdgeInsets.all(20),child: BarChart(BarChartData(
                        maxY: 6,
                        minY: 0,
                        barGroups: [
                          BarChartGroupData(x: 1,barRods: [
                            BarChartRodData(toY: a_,color: Colors.red,width: 15,borderRadius: BorderRadius.circular(10))
                          ]),
                          BarChartGroupData(x: 2,barRods: [
                            BarChartRodData(toY: b_,color: Colors.orange,width: 15,borderRadius: BorderRadius.circular(10))
                          ]),
                          BarChartGroupData(x: 3,barRods: [
                            BarChartRodData(toY: c_,color: Colors.yellow,width: 15,borderRadius: BorderRadius.circular(10))
                          ]),
                          BarChartGroupData(x: 4,barRods: [
                            BarChartRodData(toY: d_,color: Colors.grey,width: 15,borderRadius: BorderRadius.circular(10))
                          ]),
                          BarChartGroupData(x: 5,barRods: [
                            BarChartRodData(toY: e_,color: Colors.lightGreenAccent,width: 15,borderRadius: BorderRadius.circular(10))
                          ]),
                          BarChartGroupData(x: 6,barRods: [
                            BarChartRodData(toY: f_,color: Colors.green,width: 15,borderRadius: BorderRadius.circular(20))
                          ]),
                        ],
                      )),),
                    ),),
                    Align(
                      alignment: Alignment.center,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                        Text("1=${emojiParser.getEmoji("😴").code}",style: TextStyle(fontSize: 30),),
                        Text("2=${emojiParser.getEmoji("😔").code}",style: TextStyle(fontSize: 30)),
                      ],),

                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                        Text("3=${emojiParser.getEmoji("😬").code}",style: TextStyle(fontSize: 30)),
                        Text("4=${emojiParser.getEmoji("😐").code}",style: TextStyle(fontSize: 30)),
                      ],),

                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                        Text("5=${emojiParser.getEmoji("🙂").code}",style: TextStyle(fontSize: 30)),
                        Text("6=${emojiParser.getEmoji("😂").code}",style: TextStyle(fontSize: 30)),
                      ],),

                    ),
                  ],
                ),
              ),)
            ],
          ),
        )
    );
  }
}