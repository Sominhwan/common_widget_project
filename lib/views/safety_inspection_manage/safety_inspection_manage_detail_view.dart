
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SafetyInspectionManageDetailView extends StatefulWidget {
  const SafetyInspectionManageDetailView({super.key});

  @override
  State<SafetyInspectionManageDetailView> createState() => _SafetyInspectionManageDetailViewState();
}

class _SafetyInspectionManageDetailViewState extends State<SafetyInspectionManageDetailView> with SingleTickerProviderStateMixin{
  // TabController 추가
  late TabController _tabController;

  // 스켈레톤 로딩 위젯
  Widget skeletonLoader() {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: const Color.fromRGBO(240, 240, 240, 1),
        highlightColor: const Color.fromRGBO(245, 245, 245, 1),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
            children: List.generate(10, (index) => Container(
              width: double.maxFinite,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(240, 240, 240, 1),
              ),
            )),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 탭 컨트롤러 초기화
    _tabController = TabController(length: 2, vsync: this, animationDuration: Duration.zero, initialIndex: 0);
  }

  @override
  void dispose() {
    // 탭 컨트롤러 정리
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [BackButton()],
        title: const Text('일일/순회안전점검 관리'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 탭바 배치
          Padding(
            padding: const EdgeInsets.all(0),
            child: TabBar(
              controller: _tabController,
              dividerColor: const Color.fromRGBO(220, 220, 220, 0.3),
              splashFactory: NoSplash.splashFactory,
              // indicatorColor: Colors.transparent, // 하단 밑줄 색상
              indicatorColor: Colors.blueAccent,
              splashBorderRadius: BorderRadius.circular(40),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(fontSize: 20),
              labelStyle: const TextStyle(fontSize: 20),
              labelColor: Colors.black,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              tabs: const [
                Tab(child: Text('비상대응 시나리오', style: TextStyle(fontSize: 14))),
                Tab(child: Text('비상훈련 실시 보고서', style: TextStyle(fontSize: 14))),
              ],
            ),
          ),
          // 탭뷰를 확장하여 나머지 공간을 차지하도록 함
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // physics: const NeverScrollableScrollPhysics(), // 스와이프로 탭 내용 변경을 방지
              children: const [
                SingleChildScrollView(
                  // key: PageStorageKey<String>('emergencyResponseScenarioWidget'),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: EmergencyResponseScenarioWidget()),
                  ),
                ),
                SingleChildScrollView(
                  // key: PageStorageKey<String>('emergencyResponseResultWidget'),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: EmergencyResponseResultWidget()),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// 비상대응 시나리오 레이아웃
class EmergencyResponseScenarioWidget extends StatefulWidget {
  const EmergencyResponseScenarioWidget({super.key});

  @override
  State<EmergencyResponseScenarioWidget> createState() => _EmergencyResponseScenarioWidgetState();
}

class _EmergencyResponseScenarioWidgetState extends State<EmergencyResponseScenarioWidget> {
  final List<String> surveyQuestions = [
    '보호구는 규격에 맞는 것을 사용하고 교육에 재질 사용하고 있는가?',
    '유해물들에 노출되지 않게 작업계획이 수립되고 작업전 안전교육이 되고 있는가?',
    '자재의 적재는 안전한 방법으로 적치되어 있는가?',
    '인화성 물질 또는 폭발성 물질은 소정의 장소에 보관 및 관리하고 있는가?',
    '차량에 굴름막이를 하고 있는가?',
    '통로로 사용되는 지면이 요철등 파손되거나 물이 고여 있지 않는가?',
    '배수구는 물이 잘 흐를 수 있도록 조치되어 있는가?',
  ];

  // To track the state of checkboxes
  List<bool> checkBoxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize all checkbox values to false
    checkBoxValues = List.generate(surveyQuestions.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              for (int i = 0; i < checkBoxValues.length; i++) {
                print('항목 ${i + 1}: ${checkBoxValues[i] ? "점검 완료" : "점검 안됨"}');
              }
            },
            child: const Text('점검 버튼'),
          ),
          Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: const {
              0: FixedColumnWidth(30), // For '번호' column
              1: FlexColumnWidth(10), // For '안전점검 항목' column
              2: FlexColumnWidth(1), // For '점검' column
            },
            children: [
              // 헤더 행
              const TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '번호',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '안전점검 항목',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '점검',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Data Rows
              ...List<TableRow>.generate(
                surveyQuestions.length,
                    (index) =>
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              surveyQuestions[index],
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Checkbox(
                              value: checkBoxValues[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValues[index] = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 비상훈련 실시 보고서 레이아웃
class EmergencyResponseResultWidget extends StatefulWidget {
  const EmergencyResponseResultWidget({super.key});

  @override
  State<EmergencyResponseResultWidget> createState() => _EmergencyResponseResultWidgetState();
}

class _EmergencyResponseResultWidgetState extends State<EmergencyResponseResultWidget> {


  @override
  Widget build(BuildContext context) {

    return Consumer(
        builder: (context, provider, child) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          );
        }
    );
  }
}
