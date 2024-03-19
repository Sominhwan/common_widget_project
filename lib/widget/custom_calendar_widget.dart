
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
  DateTime _viewDate = DateTime.now();
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

  void _onPrevious() {
    final DateTime currentMonth = _controller.displayDate!;
    final DateTime previousMonth = DateTime(currentMonth.year, currentMonth.month, 1).subtract(const Duration(days: 1));
    _viewDate = DateTime(previousMonth.year, previousMonth.month);
    _controller.displayDate = _viewDate;
  }

  void _onNext() {
    final DateTime currentMonth = _controller.displayDate!;
    final DateTime nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    _viewDate = DateTime(nextMonth.year, nextMonth.month);
    _controller.displayDate = _viewDate;
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
    final deviceSize = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: deviceSize.width * 0.9,
        height: deviceSize.height * 1,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _onPrevious();
                      });
                    },
                  ),
                  Text(
                    '${_viewDate.year}년 ${_viewDate.month}월',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _onNext();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCalendar(
                key: ObjectKey(_viewDate),
                controller: _controller,
                view: CalendarView.month,
                dataSource: MeetingDataSource(getAppointments()),
                headerHeight: 0,
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
                  print(calendarTapDetails.date);
                },
                onViewChanged: (viewChangedDetails) {
                  // setState(() {
                    if (viewChangedDetails.visibleDates.isNotEmpty) {
                      // visibleDates는 현재 뷰에 표시된 날짜들의 리스트입니다.
                      _viewDate = DateTime(viewChangedDetails.visibleDates[0].year, viewChangedDetails.visibleDates[0].month);
                    }
                  // });
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
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
