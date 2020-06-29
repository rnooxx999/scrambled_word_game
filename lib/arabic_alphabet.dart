import 'dart:collection';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ArabicAlphabet extends StatefulWidget {
  @override
  _ArabicAlphabetState createState() => _ArabicAlphabetState();
}

List <String> listWordToBeGuessed = ["ارادة", "معلم" , "اعصار" , "شفر" , "سلال" , "عامود","فرج", "رغبات" , "ملاذ" , "زرافة"];


// الكلمة الاساسية المختارة
String word = "";
//الحرف الذي يتم الغط عليه
String letterPressed = "";

String value = "";
//محاولات التخمين
int tries = 3;

// ارتفاع انميشن زر الاعادة
double height = 400 ;

bool reveal = false;
bool win = false;

 final random = Random();



class _ArabicAlphabetState extends State<ArabicAlphabet> with TickerProviderStateMixin {
// كونترولر للازرار
  AnimationController animationController;
  Animation animation;

  //كونترولر لزر الاعادة الذي يحدث بعد الخسارة او الفوز
AnimationController slideAnimationController;
Animation<double>slideAnimation;


  @override
  void initState() {
    super.initState();
    wordScreen();
    animationController = AnimationController(vsync:this,duration: Duration(milliseconds: 90));
    animation =  Tween(begin: 2.0,end: 0.0).animate(animationController)
    ..addListener((){
      setState(() {
      });
    })..addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reverse();
        }else if(status == AnimationStatus.dismissed){
        animationController.reset();
        }
      });
        slideAnimationController = AnimationController(
  duration: Duration(seconds: 2, ),vsync: this);
  slideAnimation = Tween<double>(
  begin: 490.0 , end: 30.0).animate(CurvedAnimation(parent: slideAnimationController,
  curve: Curves.fastLinearToSlowEaseIn))
  ..addListener((){
  setState(() {});});

  }


// ميثود اختيار كلمة رئيسية عشوائية
void wordScreen(){
 var value = List<String>.generate(1, (i)=>listWordToBeGuessed[random.nextInt(listWordToBeGuessed.length)]);
 for(int i=0 ; i < value.length ; i++){
      word = value[i] ;
     print(word);
 }
}



//ميثود ترجع لست الحروف ونضعها في الازرار
List lettersList(int o){
if(word == "شفر" || word ==  "سلال"  ){
List <String> theLetter1 = [ "ع" , "ت", "ا", "ح" ,"⌫" , "ل","ف", "ر" , "س" , "م","ا", "ش", "ق","و" ,"خ"];
value = theLetter1[o];
return theLetter1;
}
else if(word ==  "عامود" || word == "فرج" ){
List <String> theLetter2 = ["ش", "ب" , "ت" , "و", "⌫" ,"ص","ر"  , "ط" , "د" , "ف", "ع" , "م","ا","ق", "ج"];
value = theLetter2[o];
return theLetter2;

}
else if(word == "ارادة" || word == "رغبات" ){
List <String> theLetter3 = ["ر", "ع" , "ب" , "و","⌫",  "ز", "د" , "غ","ك", "ن" , "ا" , "س","ه","ت","ة"];
value = theLetter3[o];
return theLetter3;}
else if(word == "معلم" ||word == "اعصار"  ){
List <String> theLetter4 = ["ط", "م" , "ص" , "و","⌫", "ع" , "س","ت" , "ح","ك", "ل" , "ا" ,"ه","ر","ي"];
value = theLetter4[o];
return theLetter4;

}
else if(word == "ملاذ" ||word == "زرافة"  ){
List <String> theLetter5 = ["ر", "م" , "ش" , "ل","⌫", "ع" , "ذ" , "ف","ك", "ن" , "ا" , "س","ه","ز","ة"];
value = theLetter5[o];
return theLetter5;}
}


//ميثود النجاح في التخمين
void winning(){
  if( word.compareTo(letterPressed)==0 ){
  slideAnimationController.forward();
    win = true;
    reveal =true;
   print("you win");}
}

//ميثود عدد المحاولات
void triedCounter(){
  if(letterPressed.length >= word.length && win != true  ){
  setState(() {
      tries -- ;
      letterPressed = "";
      print("o $tries");
      if(tries == 2){
      }
      else if(tries == 1){
      }
      else if (tries == 0 ){
      //الفشل بالتخمين
        letterPressed = "game over";
        reveal =true;
          slideAnimationController.forward();}
  });}
}

//ميثود لتجديد كلمات جديدة و تخمين جديد
void refresh(){
  wordScreen();
  setState(() {
  tries = 3;
  win = false;
  reveal = false;
  letterPressed = "";
});
slideAnimationController.reverse();
}

  @override
  void dispose() {
    slideAnimationController.dispose();
    animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
    elevation: 0.1,
    backgroundColor: Colors.grey,
    title: Text('الحروف العربية', textDirection: TextDirection.rtl,)),
      backgroundColor:  Colors.grey[300],
      body: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
            Container(height: 30,
            padding: EdgeInsets.only( top :10.0 , left: 40 ),
            child: Row(children: <Widget>[
                    tries >= 3 ?  Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                     SizedBox(width: 13,),
                     tries >= 2 ? Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                     SizedBox(width: 13,),
                     tries >= 1 ? Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                             ],),),
            Padding(
              padding: const EdgeInsets.only( top :30.0 , bottom:  40),
              child: Text(reveal == false ? word.replaceAllMapped(RegExp(r'[ابثجحخدرزشعفغكلم]'),
               (match){return ' _ ';}) : word, style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl,),
            ),
            Container(
            child: Center(
            child: Text( win == false ?letterPressed : "You win" , textDirection: TextDirection.rtl,style: TextStyle(fontSize: 30) )),
            margin: const EdgeInsets.only( right :70.0 , left:  70),
            decoration: BoxDecoration(
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),]),
                            height: 90, width: 160,),
              Padding(
              padding: EdgeInsets.only(top:40),
                child: Container(height: 219,color: Colors.transparent,
                  child: GridView.count(crossAxisCount: 5,
    mainAxisSpacing: 9.0,crossAxisSpacing: 9.0,
    children: List.generate(15 , (index){
    List too = lettersList(index).map((m)=> m).toList();

    bool maybe(){
    if(index ==  too[index]){
      animationController.forward();
    return true;
    }}
    return lettCard(value , too[index] ,too[index] );
    }
    )),
                )),
            ],
          ),
        ),
        Positioned(
      top:height - slideAnimation.value *4.17  ,
        left: 30,
        right: 30,
        height: height - 178.0 ,
        child: Container(color: Colors.white.withOpacity(0.6),

      padding: EdgeInsets.only(top: 18, left: 16, right: 16,bottom: 16 ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(iconSize: 100,icon: Icon(Icons.refresh),color: Colors.black,
              onPressed: (){refresh();},),
              Text("اعادة", style: TextStyle(fontSize: 30, color: Colors.black),),

            ],
          ),
      )),
     ], ));

}

Widget imagee( ){
return Container(
child: Image.asset("assets/heart.png"),);
}

Widget lettCard(text ,String child , index){

int i ;

return GestureDetector(
  onTap: (){

  if (i != index){
  animationController.forward();
  }

//اضافة الحروف بعد الضغط
  setState(() {
    letterPressed += text ;
    print(letterPressed);
  });
  winning();
     triedCounter();
  },
    child:Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container( height: 50, width: 50,
      decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                  color: i == index ?Colors.grey[500]: Colors.grey[700],
                                  offset:i == index ? Offset(4.0, 4.0):Offset(animation.value, animation.value)   ,
                                  blurRadius: i == index ? 15.0 : animation.value,
                                  spreadRadius: i == index ? 1.0: animation.value),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),]),
                                  child: Center(
                                    child: Text(child , textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold ),),
                                  ),
 ),
    ),
  );
}
}
//متغيرات تجارب
//List<int> scrambled = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
//List <String> nocopy = List<String> ();
//List <String> letter = ["ا", "ب" , "ت" , "ث","ج", "ح" , "خ" , "د","ذ", "ر" , "ز" , "س","ش",
//"ص", "ض" , "ط" , "ظ","ع", "غ" , "ف" , "ق","ك", "ل" , "م" , "ن","ه", "و","ي","ة"];


//محاولة للحروف العشوائية
//String displayWordScreen(){
//var hashSet = HashSet();
//for (var i = 0; i < 15; i++) {
//    Random _random = new Random();
//    String wordToAdd = letter[_random.nextInt(letter.length -1)];
//    for (var j = 0; j < letter.length; j++) {
//    wordToAdd = letter[_random.nextInt(letter.length -1)];
//   nocopy.add(wordToAdd);
//   vaal = wordToAdd;
//   return vaal;
//    print(wordToAdd);}
//  }
//}



//محاولة ثانية
// String Rnd(){
//   var value = List<String>.generate(1, (i)=> letter[random.nextInt(letter.length)]);
// for(int i=0 ; i <= value.length  ; i++){
//vaal = value.toList()[i] ;
//print(vaal);
//return vaal;
//}}

//محاولة ثالثة
//String shuffle(){
//for (int i = letter.length -1; i > 0 ; i--){
//int index = random.nextInt(i);
//String lit = letter[index];
//letter[index] = letter[i];
//letter[i] = lit;
//vaal = letter[i] ;
//return lit;
//}}

//محاولة جعل اللوب يمر على الكلمة المختارة ويحول الحروف الى فراغ (-)
//for (int k =1 ; k < value.length - 1 ;k++){ //this for loop mean the(-) being in second char and before the end char
// setState(() {
//word.replaceAllMapped(
//  RegExp(r'ابتثجحخدذرزشعفغكلم\w++', caseSensitive: false), (match){return '_';});
//
//});
// }