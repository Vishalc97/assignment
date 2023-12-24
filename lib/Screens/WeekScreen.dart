import 'dart:ui';
import 'package:calenderselection/utilities/GlobalUtilities.dart';
import 'package:calenderselection/utilities/constantColors.dart';
import 'package:flutter/material.dart';


class WeekScreen extends StatefulWidget {
  final DateTime rangeStart;
  final int index;

  const WeekScreen({Key? key,required this.rangeStart,required this.index}) : super(key: key);

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
   DateTime? _rangeStart;
   int _index = 0;

   //initialize colums name
   String hdr = "HDR";
   String tech = "Tech";
   String followup = "Follow up";
   String total = "Total";

   // initialize column data
   int hdrValue = 3;
   int techValue = 5;
   int followupValue = 2;

  @override
  void initState() {
    // TODO: implement initState
    _rangeStart = widget.rangeStart;
    _index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getWeekRowsList(_index);
  }
  _getWeekRowsList(int index) {
    String _getDay = getDay(_rangeStart ?? DateTime.now(), index);
    String _getMonth = getMonth(_rangeStart ?? DateTime.now(), index);
    int totalValue = hdrValue + techValue + followupValue;


    return Container(
      margin: EdgeInsets.only(top: 20, left: 12, right: 12),
      padding: EdgeInsets.symmetric(vertical: 8),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 4,
            padding: EdgeInsets.symmetric(vertical: 35),
            decoration: BoxDecoration(
                color: ConstantColor.red, borderRadius: BorderRadius.circular(12)),
          ),
          SizedBox(width: 18,),
          Column(
            children: [
              createText(label: _getDay,fontweight: FontWeight.bold),
              SizedBox(height: 5,),
              createText(label: _getMonth,fontweight: FontWeight.bold),

            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getCircularDesign(hdrValue.toString().padLeft(2, '0'), hdr,),
                getCircularDesign(techValue.toString().padLeft(2, '0'), tech,),
                getCircularDesign(followupValue.toString().padLeft(2, '0'), followup,),
                getCircularDesign(totalValue.toString().padLeft(2, '0'), total, isTotal: true),
              ],
            ),
          )
        ],
      ),
    );
  }


}
