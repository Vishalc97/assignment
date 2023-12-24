import 'dart:ui';
import 'package:calenderselection/Model/ModelUserEntry.dart';
import 'package:calenderselection/utilities/GlobalUtilities.dart';
import 'package:calenderselection/utilities/constantColors.dart';
import 'package:calenderselection/utilities/jsonresponse.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DayScreen extends StatefulWidget {
  final Userentries userEntry;

  const DayScreen({Key? key,required this.userEntry}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {

   late Userentries _UserDetail;
   String name = "NA";
   String id = "NA";
   String offfered = "NA";
   String priority = "NA";
   String current = "NA";
   String duedate = "NA";
   String level = "NA";
   String contact = "NA";
   String daysleft = "NA";
  @override
  void initState() {
    // TODO: implement initState
    if(widget.userEntry != null) {
      _UserDetail = widget.userEntry;
      name = _UserDetail.name;
      id = _UserDetail.id;
      offfered = _UserDetail.Offered;
      current = _UserDetail.Current;
      contact = _UserDetail.Contact;
      duedate = _UserDetail.DueDate;
      level = _UserDetail.level;
      daysleft = _UserDetail.DaysLeft;
      priority = _UserDetail.Priority;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getDayRowList();
  }

  _getDayRowList(){
    double vhsize = 15.0;
    return Container(
      margin: EdgeInsets.only(top: 18, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: vhsize, horizontal: vhsize),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: ConstantColor.grey,
            offset: Offset(2, 0),
            blurRadius: 4,
          )

        ],
        borderRadius: BorderRadius.circular(8),
        color: ConstantColor.white,
      ),
      child: Column(
        children: [
          _userDetails(),
          Divider(color: ConstantColor.grey,),
          _levelDetails(),
        ],
      ),
    );
  }
  _userDetails(){
    double fontSize = 13.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createText(label: name,fontsize: fontSize,fontweight: FontWeight.bold),
            SizedBox(height: 4,),
            createText(label: "ID: LOREM123456354",fontsize: fontSize),
            SizedBox(height: 4,),
            RichText(
              text: TextSpan(
                text: "Offered : ",
                style: TextStyle(fontSize: fontSize, color: ConstantColor.black),
                children: [
                  TextSpan(
                    text: offfered,
                    style: TextStyle(
                      fontSize: 14,
                      color: ConstantColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),),
            SizedBox(height: 4,),
            RichText(
              text: TextSpan(
                text: "Current : ",
                style: TextStyle(fontSize: fontSize, color: ConstantColor.black),
                children: [
                  TextSpan(
                    text: current,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: ConstantColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle, size: 8, color: ConstantColor.orange,),
                SizedBox(width: 8,),
                createText(label: priority,fontsize: fontSize,
                    fontcolor: priority.toString().toLowerCase().trim().contains('medium')
                        ? ConstantColor.orange
                        : priority.toString().toLowerCase().trim().contains('high')
                        ? ConstantColor.red
                    : ConstantColor.black,fontweight: FontWeight.bold )
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
        InkWell(
          onTap: () async{
            final call = Uri.parse('tel:+91 $contact');
            if (await canLaunchUrl(call)) {
              launchUrl(call);
            } else {
              throw 'Could not launch $call';
            }
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: ConstantColor.grey,
                  offset: Offset(2, 0),
                  blurRadius: 4,
                )
              ],
              //borderRadius: BorderRadius.circular(8),
              color: ConstantColor.white,
            ),
            child: Icon(Icons.local_phone_outlined, color: ConstantColor.blueshade,),
          ),
        )
      ],
    );
  }

  _levelDetails(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonTextWidget("Due Date", duedate),
        commonTextWidget("Level", level),
        commonTextWidget("Days Left", daysleft),
      ],
    );
  }



}
