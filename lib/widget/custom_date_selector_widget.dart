import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CustomDateSelectorWidget extends StatefulWidget {
  final DateTime selectedDt; // 선택한 날짜
  final DateTime minDt; // 최소 날짜
  final DateTime maxDt; // 최대 날짜
  final ValueChanged<DateTime> onChanged; // 날짜 변경 감지
  final Map<DateTime, List<Event>>? event; // DateSelectorDialog 특정 날짜에 데이터가 존재하는 경우 표시
  const CustomDateSelectorWidget({
    super.key,
    required this.selectedDt,
    required this.onChanged,
    required this.minDt,
    required this.maxDt,
    this.event
  });
  @override
  State<CustomDateSelectorWidget> createState() => _CustomDateSelectorWidgetState();
}

class _CustomDateSelectorWidgetState extends State<CustomDateSelectorWidget> {
  late DateTime selectDay;
  late DateTime headerDay;
  bool _isDatePickerShown = false;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectDay = day;
    });
  }

  DateTime findLastDayOfMonth(int year, int month) {
    DateTime nextMonthFirstDay = (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    DateTime lastDayOfMonth = nextMonthFirstDay.subtract(const Duration(days: 1));
    return lastDayOfMonth;
  }

  Map<DateTime, List<Event>>? events = {};
  List<Event> _getEventsForDay(DateTime day) {
    return events?[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    selectDay = widget.selectedDt;
    events = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // 모서리 반경 설정
      ),
      child: SizedBox(
        height: 460,
        child: Container(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400), // 전환 애니메이션 지속시간
                  child: _buildTableCalendar(),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(30),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          foregroundColor: Colors.transparent,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('취소', style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(30),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          foregroundColor: Colors.transparent,
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onChanged.call(selectDay);
                        },
                        child: const Text('확인', style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// 날짜 선택 위젯
  Widget _buildTableCalendar() {
    return TableCalendar(
      focusedDay: selectDay,
      firstDay: widget.minDt,
      lastDay: widget.maxDt,
      locale: 'ko_KR',
      selectedDayPredicate: (day) => isSameDay(day, selectDay),
      onDaySelected: _onDaySelected,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        headerPadding: EdgeInsets.all(0),
        headerMargin: EdgeInsets.only(bottom: 15),
      ),
      calendarStyle: const CalendarStyle(
        cellMargin: EdgeInsets.all(0),
        markerMargin: EdgeInsets.zero,
        markerSize: 6,
        markerDecoration: BoxDecoration(
            color: Colors.grey, shape: BoxShape.circle
        ),
      ),
      eventLoader: _getEventsForDay,
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isDatePickerShown = !_isDatePickerShown;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Row의 크기를 자식 요소 크기에 맞춤
                  children: [
                    Text(
                      "${day.year}년 ${day.month}월",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.edit, size: 18),
                  ],
                ),
              ),
            ),
          );
        },
        dowBuilder: (context, day) {
          TextStyle dayHeaderStyle;
          String dayName;

          switch (day.weekday) {
            case DateTime.saturday:
              dayHeaderStyle = const TextStyle(color: Colors.blue, fontSize: 13);
              dayName = '토';
              break;
            case DateTime.sunday:
              dayHeaderStyle = const TextStyle(color: Colors.red, fontSize: 13);
              dayName = '일';
              break;
            case DateTime.monday:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '월';
              break;
            case DateTime.tuesday:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '화';
              break;
            case DateTime.wednesday:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '수';
              break;
            case DateTime.thursday:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '목';
              break;
            case DateTime.friday:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '금';
              break;
            default:
              dayHeaderStyle = const TextStyle(color: Colors.black, fontSize: 13);
              dayName = '';
          }
          return Center(
            child: Text(
              dayName,
              style: dayHeaderStyle,
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          TextStyle dayStyle;

          switch (day.weekday) {
            case DateTime.saturday:
              dayStyle = const TextStyle(color: Colors.blue); // 토요일은 파란색
              break;
            case DateTime.sunday:
              dayStyle = const TextStyle(color: Colors.red); // 일요일은 빨간색
              break;
            default:
              dayStyle = const TextStyle(color: Colors.black); // 기타 일자는 검정색
          }
          return Center(
            child: Text(
              '${day.day}',
              style: dayStyle,
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Container(
              width: 30, // 원의 너비
              height: 30, // 원의 높이
              alignment: Alignment.center, // 컨테이너 내용물을 중앙에 배치
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '${day.day}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) => Center(
          child: Container(
            width: 30, // 원의 너비
            height: 30, // 원의 높이
            alignment: Alignment.center, // 컨테이너 내용물을 중앙에 배치
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // 원의 반경
              color: Colors.blueAccent, // 배경 색상
            ),
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // 텍스트를 중앙에 정렬
            ),
          ),
        ),
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            // Here's where you customize your marker
            // This is just an example to create a simple dot,
            // you should replace it with the desired marker style.
            return Positioned(
              right: 0,
              bottom: 1,
              width: 50,
              child: _buildEventsMarker(date: day, events: events),
            );
          }
          return null;
        },
      ),
    );
  }
  Widget _buildEventsMarker({required DateTime date, required List<dynamic> events}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue[400], // Example color
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}', // Number of events
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}

class Event {
  String title;
  Event(this.title);
}

