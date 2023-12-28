import 'dart:convert';
import 'dart:ui';
import 'package:calenderselection/Model/ModelUserEntry.dart';
import 'package:calenderselection/utilities/constantColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


List<dynamic> userDetails = [];

Widget createText(
    {required String label, int maxLines = 50,double fontsize = 16.0,Color fontcolor = ConstantColor.black,FontWeight fontweight = FontWeight.normal}) {
  return Text(label, style: TextStyle(
        color: fontcolor,
        fontSize: fontsize,
       fontWeight: fontweight
  ), maxLines: maxLines);
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round() + 1;
}


getDay(DateTime selectedDay,int index){
  DateTime dayMothVal = selectedDay.add(Duration(days: index , hours: 23));
  return DateFormat('dd').format(dayMothVal);
}
getMonth(DateTime selectedDay,int index){
  DateTime dayMothVal = selectedDay.add(Duration(days: index , hours: 23));
  return DateFormat('MMM').format(dayMothVal);
}

getCircularDesign(String value, String label, {bool isTotal = false}) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isTotal ? ConstantColor.black : ConstantColor.white,
            border: Border.all(
                color: isTotal ? ConstantColor.transparant : ConstantColor.grey)),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 16,
                color: isTotal ? ConstantColor.white : ConstantColor.black),
          ),
        ),
      ),
      SizedBox(
        height: 6,
      ),
      createText(label: label,fontsize: 14,)
    ],
  );
}

commonTextWidget(String text, String value, {bool isTotal=false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      createText(label: text,fontcolor: isTotal?ConstantColor.white:ConstantColor.black),
      SizedBox(height: 6),
      createText(label: value,fontcolor: isTotal?ConstantColor.white:ConstantColor.black,fontsize: 14),
    ],
  );
}

getJsonResponse(){
  List<Userentries> mapuser = [];
  try{
    Userentries user1 = Userentries( name:"Balaram Naidu",id: "LOREM123456354",Offered: "₹X,XX,XXX", Priority:"Medium Priority", Current:"₹X,XX,XXX",DueDate: "05 Jun 23", level:"10",DaysLeft: "23", Contact:"9897657895");
    mapuser.add(user1);
    Userentries user2 = Userentries(name:"Rakesh Nair",id: "LOREM123456354",Offered: "₹X,XX,XXX",Priority: "High Priority",Current: "₹X,XX,XXX",DueDate: "05 Jun 23",level: "10",DaysLeft: "92",Contact: "8137743105");
    mapuser.add(user2);
    print(mapuser);
    String jsonStr = jsonEncode(mapuser);
    print(jsonStr);
    var data = (json.decode(jsonStr)).map((i) => Userentries.fromJson(i)).toList();
    print(data.toString());
    userDetails = data;
    print(userDetails);
  }catch(ex){
    print(ex.toString());
  }
}

