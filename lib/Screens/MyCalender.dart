
import 'package:calenderselection/CustomTabBar/customtabbar.dart';
import 'package:calenderselection/Screens/DayScreen.dart';
import 'package:calenderselection/Screens/WeekScreen.dart';
import 'package:calenderselection/utilities/GlobalUtilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calenderselection/utilities/constantColors.dart';
import 'package:intl/intl.dart';


class MyCalender extends StatefulWidget {
  const MyCalender({Key? key}) : super(key: key);

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  // variable declaration

  CalendarFormat _calendarFormat = CalendarFormat.week;
  late RangeSelectionMode
      _rangeSelectionMode; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  String appBarWeekHeader = "My Calender";
  String appBarDayHeader = "In App Calender";
  List tabBarList = [];
  String _getTimeCriteria = "";
  String _Day = "Day";
  String _week = "Week";
  bool isDaySelected = false;
  bool isWeekSelected = false;

  int totalDays = 0;

  //colums of list
  String hdr = "HDR";
  String tech = "Tech";
  String followup = "Follow up";
  String total = "Total";
// initialize column data
  int hdrValue = 3;
  int techValue = 5;
  int followupValue = 2;

  // tab bar menu items count
  int tabBarhdr = 0;
  int tabBartech = 0;
  int tabBarfollowup = 0;
  int tabBartotal = 0;

  List DaysDataList = [];


  @override
  void initState() {
    // TODO: implement initState
    //set initial value for toogle button
    _getTimeCriteria = _week;
    // initial set week selection is true
    isWeekSelected = true;
    //set calender range mode toogle on
    _rangeSelectionMode = RangeSelectionMode.toggledOn;

    print(userDetails);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.white,
      appBar: appBar(),
      body: Column(
        children: [

        /*  Container(
            decoration: BoxDecoration(
              color: ConstantColor.grey400
            ),
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createText(label: '${DateFormat('LLLL').format(DateTime.now())} ${DateFormat('d').format(DateTime.now())}'),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),*/


          isDaySelected
              ? Container(
                  height: 2,
                  decoration: BoxDecoration(color: ConstantColor.red),
                )
              : Container(),
          tableCalender(),
          // getCenterLine(),
          totalDays != 0 && isWeekSelected
              ? _tabBarMenuList()
              :  _selectedDay != null && isDaySelected
          ? _tabBarMenuList()
              :Expanded(
                  child: Container(
                    child: Center(
                      child: createText(
                          label: 'No data Found...Kindly select Dates!!',
                          fontweight: FontWeight.normal,
                          fontsize: 14),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: ConstantColor.white,
      centerTitle: false,
      elevation: isDaySelected ? 0 : 6,
      title: Row(
        children: [
          Icon(
            Icons.arrow_back,
            size: 30,
            color: ConstantColor.black,
          ),
          SizedBox(
            width: 15,
          ),
          isWeekSelected
              ? createText(label: appBarWeekHeader, fontsize: 18)
              : createText(label: appBarDayHeader, fontsize: 18)
        ],
      ),
      actions: [
        customDayWeekSwitch(),
      ],
    );
  }

  Widget getCenterLine() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        width: 50,
        height: 3,
        color: ConstantColor.grey,
      ),
    );
  }
  
  customDayWeekSwitch() {
    double circularRadius = 6.0;

    return Container(
      margin: EdgeInsets.only(right: 15, top: 5, bottom: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circularRadius),
          border: Border.all(color: ConstantColor.blueBorder, width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          switchContainer(_Day),
          switchContainer(_week),
        ],
      ),
    );
  }

  Widget switchContainer(String timeCriteria) {
    double circularRadius = 4.0;
    double vertical = 10.0;
    double horizontal = 15.0;
    return InkWell(
      onTap: () {
        print(timeCriteria);
        setState(() {
          _getTimeCriteria = timeCriteria;
           _selectedDay = null;
          _rangeStart = null;
           _rangeEnd = null;
          if (timeCriteria == _Day) {
            isDaySelected = !isDaySelected;
            isWeekSelected = false;
            totalDays = 0;
             hdrValue = 1;
             techValue = 1;
             followupValue = 0;
          } else {
            isWeekSelected = !isWeekSelected;
            isDaySelected = false;
             hdrValue = 3;
             techValue = 5;
             followupValue = 2;
          }
        });
      },
      child: Container(
          decoration: (isWeekSelected && _getTimeCriteria == timeCriteria)
              ? BoxDecoration(
                  color: ConstantColor.blueBorder,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(circularRadius),
                      topLeft: Radius.circular(circularRadius)),
                )
              : (isDaySelected && _getTimeCriteria == timeCriteria)
                  ? BoxDecoration(
                      color: ConstantColor.blueBorder,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(circularRadius),
                          topRight: Radius.circular(circularRadius)),
                    )
                  : BoxDecoration(
                      color: ConstantColor.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0)),
                    ),
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: Text(
            timeCriteria,
            style: (isWeekSelected && _getTimeCriteria == timeCriteria) ||
                    (isDaySelected && _getTimeCriteria == timeCriteria)
                ? TextStyle(color: ConstantColor.white)
                : TextStyle(color: ConstantColor.blueBorder),
          )),
    );
  }

  bool isSwipeDown = false;
  tableCalender() {
    return Container(
      decoration: BoxDecoration(
        color: ConstantColor.grey400
      ),
      child: Listener(
        onPointerMove: (moveEvent){
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          int sensitivity = 8;
          if (moveEvent.delta.dy > sensitivity) {
            // Down Swipe
            setState(() {
              _calendarFormat = CalendarFormat.month;
              isSwipeDown = true;
            });
          } else if(moveEvent.delta.dy < -sensitivity){
            // Up Swipe
            setState(() {
              _calendarFormat = CalendarFormat.week;
              isSwipeDown = false;
            });
          }
        },
        child: Column(
          children: [
            TableCalendar(
              headerVisible: true,
              daysOfWeekVisible: true,
              weekendDays: const [DateTime.sunday],
              startingDayOfWeek: StartingDayOfWeek.monday,

              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
                weekendStyle: TextStyle(
                  color: ConstantColor.orange
                )
              ),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                2030,
                12,
              ),
              headerStyle: HeaderStyle(
                leftChevronVisible: false,
                rightChevronVisible: false,
                formatButtonVisible: false,
                titleCentered: true
              ),
              focusedDay: _focusedDay,
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(color: ConstantColor.orange),
                todayTextStyle: TextStyle(
                  color: ConstantColor.black
                ),
                rangeHighlightColor: ConstantColor.lightskyblue,
                selectedDecoration: BoxDecoration(
                  color: ConstantColor.blueBorder,
                  shape: BoxShape.circle
                ),
                todayDecoration: BoxDecoration(
                  // color: ConstantColor.lightskyblue,
                      shape: BoxShape.circle,
                  border: Border.all(color: ConstantColor.blueBorder,width: 2)
                ),
                rangeStartDecoration: BoxDecoration(
                  color: ConstantColor.blueBorder,
                    shape: BoxShape.circle
                ),
                rangeEndDecoration: BoxDecoration(
                  color: ConstantColor.blueBorder,
                    shape: BoxShape.circle
                ),
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDay , day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode:
                  isWeekSelected ? RangeSelectionMode.toggledOn : RangeSelectionMode.toggledOff,
              shouldFillViewport: false,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _rangeStart = null; // Important to clean those
                    _rangeEnd = null;
                    _rangeSelectionMode = RangeSelectionMode.toggledOff;
                  });
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                  _rangeStart = start;
                  _rangeEnd = end;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  totalDays = daysBetween(_rangeStart ?? DateTime.now(),
                      _rangeEnd != null ? (_rangeEnd ?? _focusedDay) : _focusedDay);
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              weekNumbersVisible: false,

              calendarBuilders: CalendarBuilders(

                headerTitleBuilder: (context, day) => isWeekSelected
                  ? WeekHeaderBuilder( _rangeStart ?? DateTime.now())
                  : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DayHeaderBuilder('${DateFormat("MMM").format(_rangeStart ?? DateTime.now())}'),
                    DayHeaderBuilder('${DateFormat("y").format(_rangeStart ?? DateTime.now())}')
                  ],
                ),
              ),

            ),
            getCenterLine(),
          ],
        ),
      ),
    );
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
                  color: isTotal
                      ? ConstantColor.transparant
                      : ConstantColor.grey)),
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
        createText(
          label: label,
          fontsize: 14,
        )
      ],
    );
  }

  _getTabBarMenu() {
    tabBarhdr = 0;
    tabBartech = 0;
    tabBarfollowup = 0;
    tabBartotal = 0;
    if (isWeekSelected) {
      for (int i = 0; i < totalDays; i++) {
        tabBarhdr += hdrValue;
        tabBartech += techValue;
        tabBarfollowup += followupValue;
      }
    }else{
      tabBarhdr += hdrValue;
      tabBartech += techValue;
      tabBarfollowup += followupValue;
    }
    tabBartotal = tabBarhdr + tabBartech + tabBarfollowup;
  }

  _tabBarMenuList() {
    _getTabBarMenu();
    tabBarList = [
      "All (${(tabBartotal).toString()})",
      "HDR (${tabBarhdr.toString()})",
      "Tech 1 (${tabBartech.toString()})",
      "Follow up (${tabBarfollowup.toString()})"
    ];
    return Expanded(
      child: CustomTabView(
        initPosition: 0,
        isScroll: true,
        itemCount: tabBarList.length,
        stub: SizedBox(),
        tabBuilder: (BuildContext, index) => Tab(
          text: tabBarList[index],
        ),
        pageBuilder: (BuildContext, index) {
          return ListView.builder(
            itemCount: isWeekSelected ? totalDays : userDetails.length,
            itemBuilder: (BuildContext, index) => isWeekSelected
              ? WeekScreen(
                rangeStart: _rangeStart!,
                index: index) /*_getWeekRowsList(index)*/
              : DayScreen(userEntry: userDetails[index]),
          );
        },
        onPositionChange: (int value) {},
        onScroll: (double value) {},
      ),
    );
  }



  DayHeaderBuilder(String label){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.chevron_left),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createText(label: label),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_drop_down_outlined),
                ],
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  WeekHeaderBuilder(DateTime dateTime){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createText(label: "${DateFormat("MMMM").format(_rangeStart ?? dateTime)} ${_rangeStart?.day ?? dateTime.day}",fontweight: FontWeight.w400),
          const Icon(Icons.arrow_drop_down_outlined),
        ],
      ),
    );
  }
}
