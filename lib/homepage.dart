import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifeel/createAccount.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:collection';
import 'package:ifeel/charts.dart';
import 'package:fl_chart/fl_chart.dart';


class homepage extends StatefulWidget{
  @override
  State createState()=> home_page();
}
class home_page extends State{






  var t1=TextEditingController();
  var t2=TextEditingController();
  var _auth;
  var emojiParser=EmojiParser();
  Color _color=Colors.yellow;
  var _deger=0.0;var _durum="Normal";
  var db= FirebaseDatabase.instance.ref().child("Çalışanlar");
  var _aciklama="-";var _mood=TextEditingController();

  @override
  void initState(){
    _auth=FirebaseAuth.instance;
  }
  void kayitOl(){
    _auth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
      return createAccount();
    }), (route) => false);
  }

  void gonder(){
    setState(() {
      DateTime now = DateTime.now();


      if ((now.hour >= 8 && now.hour < 9) || (now.hour >= 19 && now.hour < 20)) {

        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Icon(Icons.question_mark,size: 100,color: Colors.red,),),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Text("Modunuzu daha ayrıntılı açıklar mısınız ?"),),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: TextField(controller: _mood,),),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Padding(padding: EdgeInsets.only(right: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: (){
                        if(_mood.text!=""){
                          var value1=new HashMap<String,dynamic>();
                          value1["Email"]="${_auth.currentUser!.email.toString()} ---";
                          value1["Durum_1"]="${_deger.toString()} ---";
                          value1["Durum_2"]="${_durum} ---";
                          value1["Durum_3"]="${_mood.text} ---";
                          value1["Tarih"]="${DateTime.now().toString()} ---";
                          db.push().set(value1);
                          Navigator.pop(context);
                          var _snackBar=new SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Icon(Icons.check,color: Colors.white,),
                            Padding(padding: EdgeInsets.only(left: 10),child: Text("Yanıtınız kaydedildi !",style: TextStyle(fontWeight: FontWeight.bold),),)
                          ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }else{
                          var _snackBar=new SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Icon(Icons.warning_amber,color: Colors.white,),
                            Padding(padding: EdgeInsets.only(left: 10),child: Text("Boş bırakmayınız !",style: TextStyle(fontWeight: FontWeight.bold),),)
                          ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }
                      }, child: Text("Gönder")),),
                      Padding(padding: EdgeInsets.only(left: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: (){Navigator.pop(context);}, child: Text("İptal")),),
                    ],),),
                  ],
                ),
              )
            ],
          );
        });

      }else{
        var _snackBar=new SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Icon(Icons.warning_amber,color: Colors.white,),
          Padding(padding: EdgeInsets.only(left: 10),child: Text("08.00-09.00 veya 19.00-20.00\nsaatleri arasında gönderebilirsiniz",style: TextStyle(fontWeight: FontWeight.bold),),)
        ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      }
    });
  }


  void analiz(){

     /* showDialog(context: context, builder: (BuildContext context){
        return charts();
      });*/
    Navigator.push(context, MaterialPageRoute(builder: (context)=>charts()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.transparent,color: Color.fromRGBO(237, 125, 105, 1.0),
          items: <Widget>[
            Icon(Icons.bar_chart, size: 30,color: Colors.white,),
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.exit_to_app, size: 30,color: Colors.white,),
          ],
          onTap: (index) {
            //Handle button tap
            if(index==2){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Icon(Icons.warning_amber,size: 100,color: Colors.red,),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Text("Çıkmak istediğinizden emin misiniz ?"),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Padding(padding: EdgeInsets.only(right: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: (){
                              _auth.signOut();Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                            }, child: Text("Evet")),),
                            Padding(padding: EdgeInsets.only(left: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: (){Navigator.pop(context);}, child: Text("İptal")),),
                          ],),),
                        ],
                      ),
                    )
                  ],
                );
              });
            }
            else if(index==0){
              analiz();
            }
          },
        ),


      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("lib/img/art.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
          Padding(padding: EdgeInsets.only(left: 10,right:10,top:30,bottom: 5),child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/home_background.png"),
                    fit: BoxFit.cover
                )
            ),
          ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 15),child: Align(alignment: Alignment.center,child: Text("Şu an kendini nasıl hissediyorsun ?",style: TextStyle(fontSize: 20),),),),
            Align(alignment: Alignment.bottomCenter,child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                    size: 250,
                  customColors: CustomSliderColors(trackColor: _color,progressBarColor: _color,
                  shadowColor: _color
                  )
                ),
                onChange: (double value) {
                  setState(() {
                      if(value>=0&&value<16.6){_color=Colors.red;_durum="Yorgun";}
                      else if(value>=16.6&&value<33.2){_color=Colors.orange;_durum="Üzgün";}
                      else if(value>=33.2&&value<49.8){_color=Colors.yellow;_durum="Stresli";}
                      else if(value>=49.8&&value<66.4){_color=Colors.grey;_durum="Normal";}
                      else if(value>=66.4&&value<83){_color=Colors.lightGreenAccent;_durum="Neşeli";}
                      else if(value>=83&&value<=100){_color=Colors.green;_durum="Mutlu";}
                      _deger=value;

                  });
                },innerWidget: (double value){
                  if(value>=0&&value<16.6){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("😴").code,style: TextStyle(fontSize: 100),),Text("Yorgun",style: TextStyle(fontSize: 20),)],));
                  }else if(value>=16.6&&value<33.2){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("😔").code,style: TextStyle(fontSize: 100),),Text("Üzgün",style: TextStyle(fontSize: 20))],),);
                  }else if(value>=33.2&&value<49.8){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("😬").code,style: TextStyle(fontSize: 100),),Text("Stresli",style: TextStyle(fontSize: 20))],),);
                  }else if(value>=49.8&&value<66.4){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("😐").code,style: TextStyle(fontSize: 100),),Text("Normal",style: TextStyle(fontSize: 20))],),);
                  }else if(value>=66.4&&value<83){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("🙂").code,style: TextStyle(fontSize: 100),),Text("Neşeli",style: TextStyle(fontSize: 20))],),);
                  } else if(value>=83&&value<=100){
                    return Align(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(emojiParser.getEmoji("😂").code,style: TextStyle(fontSize: 100),),Text("Mutlu",style: TextStyle(fontSize: 20))],),);
                  }
                  return Text("-");


            },),),

            Padding(padding:EdgeInsets.only(top: 10),child: ElevatedButton(onPressed: gonder, child: Text("Gönder",style: TextStyle(fontWeight: FontWeight.bold),),style: ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30,vertical: 15)),backgroundColor: MaterialStatePropertyAll(Colors.white),foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105,1.0)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 2,color: Color.fromRGBO(237, 125, 105, 1.0)))),shadowColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105,1.0))
            ),), )
        ],)

      )
    );
  }
}