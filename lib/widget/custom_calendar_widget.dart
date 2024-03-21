
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomCalendarWidget extends StatefulWidget {
  final ValueChanged<DateTime> onChanged; // 날짜 변경 감지
  final DateTime selectedDt; // 선택한 날짜

  const CustomCalendarWidget({
    super.key,
    required this.onChanged,
    required this.selectedDt
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  final CalendarController _controller = CalendarController();
  final DateTime _viewDate = DateTime.now();
  // Generate some sample appointments
  List<Appointment> getAppointments() {
    final List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: '테스트',
      color: Colors.blue,
      isAllDay: true,
    ));
    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: '테스트2',
      color: Colors.grey,
      isAllDay: true,
    ));
    // Add more appointments as needed

    return meetings;
  }

  @override
  void initState() {
    super.initState();
    // 현재 날짜를 선택된 날짜로 설정
    _controller.selectedDate = widget.selectedDt;
    _controller.displayDate = _controller.selectedDate;
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          Expanded(
            child: SfCalendar(
              key: ObjectKey(_viewDate),
              controller: _controller,
              view: CalendarView.month,
              showDatePickerButton: true,
              showNavigationArrow: true,
              dataSource: MeetingDataSource(getAppointments()),
              viewHeaderStyle: const ViewHeaderStyle(
                  backgroundColor: Colors.grey,
                  dayTextStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xffff5eaea),
                      fontWeight: FontWeight.w500),
                  dateTextStyle: TextStyle(
                      fontSize: 22,
                      color: Color(0xffff5eaea),
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500)),
              headerHeight: 50,
              headerDateFormat: 'yyyy년 MMM',
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: true,
              ),
              onTap: (calendarTapDetails) {
                log(calendarTapDetails.date.toString());
              },
              onViewChanged: (ViewChangedDetails details) {

              },
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(10),
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
                      widget.onChanged.call(_controller.selectedDate!);
                    },
                    child: const Text('확인', style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
