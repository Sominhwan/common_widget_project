
import 'package:flutter/material.dart';
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
                Tab(
                  child: Center(
                    child: Text(
                      '일일점검\n2024.03.20',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      '순회점검\n김철수(현장 안전관리자)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
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
                EmergencyResponseResultWidget(),
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

class _EmergencyResponseScenarioWidgetState extends State<EmergencyResponseScenarioWidget> with AutomaticKeepAliveClientMixin {
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
  // 탭시 데이터 유지
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize all checkbox values to false
    checkBoxValues = List.generate(surveyQuestions.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                height: 30, // 텍스트의 높이를 지정
                child: const Text('근무시간 ', style: TextStyle(fontSize: 18)),
              ),
              Container(
                color: Colors.black,
                height: 20,
                width: 1,
              ),
              Container(
                alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                height: 30, // 텍스트의 높이를 지정
                child: const Text(' 2:30분', style: TextStyle(fontSize: 18)),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  for (int i = 0; i < checkBoxValues.length; i++) {
                    print('항목 ${i + 1}: ${checkBoxValues[i] ? "점검 완료" : "점검 안됨"}');
                  }
                },
                child: const Text('점검 버튼'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          surveyQuestions.isNotEmpty ?
          Table(
            border: TableBorder.all(color: Colors.transparent),
            columnWidths: const {
              0: FixedColumnWidth(45), // For '번호' column
              1: FlexColumnWidth(12), // For '안전점검 항목' column
              2: FlexColumnWidth(2), // For '점검' column
            },
            children: [
              // 헤더 행
              const TableRow(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 150, 255, 1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
                        child: Text(
                          '번호',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
                        child: Text(
                          '안전점검 항목',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
                        child: Text(
                          '점검',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Data Rows
              ... List<TableRow>.generate(
                surveyQuestions.length,
                    (index) => TableRow(
                  decoration: BoxDecoration(
                      color: checkBoxValues[index]
                          ? const Color.fromRGBO(203, 203, 203, 0.4) // 체크된 행의 색상 변경
                          : const Color.fromRGBO(203, 203, 203, 0.2), // 기본 배경색
                        border: const Border(bottom: BorderSide(color: Color.fromRGBO(203, 203, 203, 0.0), width: 1)),
                        borderRadius: 
                        index == surveyQuestions.length - 1 ?
                        const BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))
                        : null
                      ),
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
                              activeColor: Colors.grey,
                              visualDensity: VisualDensity.compact,
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              side: const BorderSide(color: Colors.grey),
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
          ) : const SizedBox.shrink(),
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

class _EmergencyResponseResultWidgetState extends State<EmergencyResponseResultWidget> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  final List<String> _initialData = [
    "첫 번째 섹션 설명입니다.",
    "두 번째 섹션 설명입니다.",
    "세 번째 섹션 설명입니다.",
  ];

  final List<Widget> _sections = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _populateInitialSections();
  }

  void _populateInitialSections() {
    setState(() {
      _sections.addAll(_initialData.map((description) => _createSectionWidget(description)).toList());
    });
  }

  Widget _createSectionWidget(String description) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.maxFinite,
          color: Colors.grey.shade200,
          child: Text(description),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용시 필요
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_sections.isNotEmpty) // 리스트가 비어있지 않으면 _sections 표시
                ..._sections,
              if (_sections.isEmpty)
                const Text('데이터가 없습니다.'),
                ElevatedButton(
                  onPressed: _addNewSection,
                  child: const Text('Add Section'),
                ),
            ],
        ),
      ),
    );
  }

  void _addNewSection() {
    // Add a new section widget to the list.
    setState(() {
      _sections.add(_createSectionWidget("새로 추가된 섹션 설명입니다. ${_sections.length + 1}"));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }
}