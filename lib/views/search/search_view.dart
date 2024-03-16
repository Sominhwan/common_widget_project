import 'package:common_project/views/search/model/menu_auth_info_model.dart';
import 'package:common_project/views/search/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static String get className => 'SearchView';
  static String get path => '/search';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final _viewController = context.read<SearchProvider>();
  final _searchController = TextEditingController();
  // 검색 포커스 노드
  final _focusNode = FocusNode();
  final Color _textFieldColor = const Color.fromRGBO(230, 230, 230, 0.8);
  late bool searchCompIdFlag = false;
  // 자동 저장 flag
  int autoSaveFlag = 1; // 비활성
  List<String> autoSaveTrue = ['ON'];
  List<String> autoSaveFalse = ['OFF'];
  int autoSaveSeq = 1;
  // 앱 실행시 자동 저장 list 저장
  List<String> textValueList = [];
  List<String> textKeyList = [];
  List<Map<String, String>> textKeyValueMap = [];
  // 메뉴 검색 필터
  List<MenuAuthInfoModel> _menuAuthList = [];
  List<MenuAuthInfoModel> _searchMenuAuthList = [];

  void _filterMenuList(query) {
    if (query.isNotEmpty) {
      List<MenuAuthInfoModel> tmpList = [];
      for (MenuAuthInfoModel menu in _menuAuthList) {
        if (menu.title!.toLowerCase().contains(query.toLowerCase()) ||
            menu.title!.toLowerCase().contains(query.toLowerCase())) {
          tmpList.add(menu);
        }
      }
      setState(() {
        _searchMenuAuthList = tmpList;
      });
    } else {
      setState(() {
        _searchMenuAuthList = _menuAuthList;
      });
    }
  }
  // 메뉴 검색시 text 효과
  List<TextSpan> _highlightSearchQuery(String text, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300))];
    }
    final queryLower = query.toLowerCase();
    final textLower = text.toLowerCase();

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    while ((indexOfHighlight = textLower.indexOf(queryLower, start)) != -1) {
      // 검색어 이전의 텍스트 부분
      if (indexOfHighlight > start) {
        spans.add(
            TextSpan(
                text: text.substring(start, indexOfHighlight),
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
            )
        );
      }
      // 검색어 부분
      spans.add(
          TextSpan(
            text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
          )
      );
      // 시작 위치 업데이트
      start = indexOfHighlight + query.length;
    }
    // 마지막 검색어 이후의 텍스트 부분
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return spans;
  }
  // 검색 이벤트
  void _onSearchTextChanged() {
    _filterMenuList(_searchController.text);
    searchCompIdFlag = _searchController.text.isNotEmpty;
  }
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    // _viewController.onInit();
    _menuAuthList = _viewController.menuAuthInfoList;
    _searchMenuAuthList = _menuAuthList;
    // 자동저장 플래그
    String? autoSave = _viewController.getAutoSaveText('User_autoSave/AutoSaveSet');
    if(autoSave == 'true') {
      autoSaveFlag = 0;
    } else if(autoSave == 'false'){
      autoSaveFlag = 1;
    } else {
      autoSaveFlag = 0;
    }

    for(int i = 0; i<50; i++) {
      String? text = _viewController.getAutoSaveText('User_search_$i/AutoSaveSet');
      if(text != null) {
        textKeyValueMap.insert(0, {'key': '$i', 'value': text.toString()});
      }
    }
    if (textKeyValueMap.isNotEmpty && textKeyValueMap[0]['key'] != null) {
      autoSaveSeq = int.parse(textKeyValueMap[0]['key']!) + 1;
    } else {
      // 'key' 값이 null인 경우 또는 리스트가 비어 있는 경우, autoSaveSeq를 기본값으로 설정합니다.
      autoSaveSeq = 1; // 여기서 1은 예시 기본값입니다. 실제 상황에 맞는 적절한 기본값을 사용하세요.
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 텍스트 필드에 포커스를 주고 키보드를 엽니다.
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right:10, top: 10, bottom: 0),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.black,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '검색 내용을 입력하세요.',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  fillColor: _textFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  prefixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Colors.grey : Colors.grey),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0), // 아이콘들 사이의 간격 조절
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Row의 크기를 자식들의 크기에 맞춤
                            children: [
                              if(searchCompIdFlag) ...[
                                const SizedBox(width: 5),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: const Icon(Icons.cancel),
                                  onTap: () {
                                    _searchController.clear();
                                    setState(() {
                                      searchCompIdFlag = false;
                                    });
                                  },
                                ),
                              ],
                              const SizedBox(width: 10),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: const Icon(Icons.search),
                                onTap: () {
                                  // 자동저장 기능 켜질시에만 텍스트 저장
                                  if(autoSaveFlag == 0) {
                                    // 기존 자동 저장 텍스트를 검색하여 제거
                                    final existingKey = textKeyValueMap.firstWhere(
                                          (map) => map['value'] == _searchController.text,
                                      orElse: () => {},
                                    )['key'];
                                    if (existingKey != null) {
                                      _viewController.removeAutoSaveText('User_search_$existingKey/AutoSaveSet');
                                    }
                                    // 새로운 자동 저장 텍스트를 확인하고 추가
                                    final newText = _viewController.getAutoSaveText('User_search_$autoSaveSeq/AutoSaveSet');
                                    if (newText == null || newText == _searchController.text) {
                                      _viewController.onRead('User_search_$autoSaveSeq/AutoSaveSet', _searchController.text);
                                      // 자동 저장 텍스트 리스트를 초기화하고 재구성
                                      textKeyValueMap.clear();
                                      setState(() {
                                        for (int i = 0; i < 50; i++) {
                                          final text = _viewController.getAutoSaveText('User_search_$i/AutoSaveSet');
                                          if (text != null) {
                                            textKeyValueMap.insert(0, {'key': '$i', 'value': text});
                                          }
                                        }
                                      });
                                    }
                                    autoSaveSeq++; // 자동 저장 순서 번호 증가
                                  }
                                  // 입력받은 값과 메뉴 리스트의 title 비교
                                  for (var menu in _menuAuthList) {
                                    if (menu.title?.toLowerCase() == _searchController.text.toLowerCase()) {
                                      Navigator.of(context).pushReplacementNamed(
                                        menu.path!,
                                        // arguments: RouterParameters(
                                        //   menu.path!,
                                        // ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Colors.grey : Colors.grey),
                ),
                onSubmitted: (value) async {
                  // 자동저장 기능 켜질시에만 텍스트 저장
                  if(autoSaveFlag == 0) {
                    // 기존 자동 저장 텍스트를 검색하여 제거
                    final existingKey = textKeyValueMap.firstWhere(
                          (map) => map['value'] == value,
                      orElse: () => {},
                    )['key'];
                    if (existingKey != null) {
                      _viewController.removeAutoSaveText('User_search_$existingKey/AutoSaveSet');
                    }
                    // 새로운 자동 저장 텍스트를 확인하고 추가
                    final newText = _viewController.getAutoSaveText('User_search_$autoSaveSeq/AutoSaveSet');
                    if (newText == null || newText == value) {
                      _viewController.onRead('User_search_$autoSaveSeq/AutoSaveSet', value);
                      // 자동 저장 텍스트 리스트를 초기화하고 재구성
                      textKeyValueMap.clear();
                      setState(() {
                        for (int i = 0; i < 50; i++) {
                          final text = _viewController.getAutoSaveText('User_search_$i/AutoSaveSet');
                          if (text != null) {
                            textKeyValueMap.insert(0, {'key': '$i', 'value': text});
                          }
                        }
                      });
                    }
                    autoSaveSeq++; // 자동 저장 순서 번호 증가
                  }
                  // 입력받은 값과 메뉴 리스트의 title 비교
                  for (var menu in _menuAuthList) {
                    if (menu.title?.toLowerCase() == _searchController.text.toLowerCase()) {
                      Navigator.of(context).pushReplacementNamed(
                        menu.path!,
                        // arguments: RouterParameters(
                        //   menu.path!,
                        // ),
                      );
                    }
                  }
                },
                onChanged: (value) {

                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: _searchController.text.isEmpty
                  ?
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, // 배경색
                    border: Border.all(
                      color: const Color.fromRGBO(248, 248, 248, 1), // 테두리 색상 설정
                      width: 1, // 테두리 두께
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text('최근 검색어', style: TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          if(autoSaveFlag == 0) ... [
                            InkWell(
                                child: const Text('전체삭제', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                onTap: () {
                                  _viewController.removeKeysStarting('User_search');
                                  textKeyValueMap = [];
                                  setState(() {
                                    textKeyValueMap = [];
                                  });
                                }
                            ),
                          ],
                          if(autoSaveFlag == 0) ... [
                            const Text(' | ', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                          InkWell(
                              child: Text(autoSaveFlag == 0 ? '자동저장 끄기' : '자동저장 켜기', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                              onTap: () {
                                setState(() {
                                  if(autoSaveFlag == 1) {
                                    _viewController.removeAutoSaveText('User_autoSave/AutoSaveSet');
                                    _viewController.onRead('User_autoSave/AutoSaveSet', 'true');
                                    autoSaveFlag = 0;
                                  } else if(autoSaveFlag == 0) {
                                    _viewController.removeAutoSaveText('User_autoSave/AutoSaveSet');
                                    _viewController.onRead('User_autoSave/AutoSaveSet', 'false');
                                    autoSaveFlag = 1;
                                  }
                                });
                              }
                          ),
                          const SizedBox(width: 5),
                          ToggleSwitch(
                            minWidth: 46.0,
                            minHeight: 19.0,
                            cornerRadius: 20.0,
                            activeBgColors: const [[Colors.blueAccent]],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: autoSaveFlag,
                            totalSwitches: 1,
                            labels: autoSaveFlag == 1 ? autoSaveFalse : autoSaveTrue,
                            radiusStyle: false,
                            onToggle: (index) {
                              setState(() {
                                if(autoSaveFlag == 1) {
                                  _viewController.removeAutoSaveText('User_autoSave/AutoSaveSet');
                                  _viewController.onRead('User_autoSave/AutoSaveSet', 'true');
                                  autoSaveFlag = 0;
                                } else if(autoSaveFlag == 0) {
                                  _viewController.removeAutoSaveText('User_autoSave/AutoSaveSet');
                                  _viewController.onRead('User_autoSave/AutoSaveSet', 'false');
                                  autoSaveFlag = 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    autoSaveFlag == 1 ? const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 50),
                      child: Center(
                          child: Text('검색어 저장 기능이 꺼져 있습니다.', style: TextStyle(fontSize: 14, color: Colors.grey))
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 20, left: 10, right: 10),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: true),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if(textKeyValueMap.isNotEmpty) ... [
                                    for(int i = 0; i < textKeyValueMap.length; i++) ... [
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        child: InkWell(
                                            onTap: () {
                                              _searchController.text = textKeyValueMap[i]['value']!;
                                            },
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                Chip(
                                                  label: Padding(
                                                    padding: const EdgeInsets.only(right: 15), // 라벨과 삭제 아이콘 사이의 간격 조절
                                                    child: Text(textKeyValueMap[i]['value']!, style: const TextStyle(fontSize: 14)),
                                                  ),
                                                  // deleteIcon을 여기서 사용하지 않음
                                                  onDeleted: null, // 필요 없으면 null 처리
                                                ),
                                                Positioned(
                                                  right: 6, // 오른쪽 간격 조절
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _viewController.removeAutoSaveText('User_search_${textKeyValueMap[i]['key']}/AutoSaveSet');
                                                      textKeyValueMap = [];
                                                      setState(() {
                                                        for(int i = 0; i<50; i++) {
                                                          String? text = _viewController.getAutoSaveText('User_search_$i/AutoSaveSet');
                                                          if(text != null) {
                                                            textKeyValueMap.insert(0, {'key': '$i', 'value': text});
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: const Icon(Icons.clear, size: 16, color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ]
                                  ],
                                  if(textKeyValueMap.isEmpty) ... [
                                    const SizedBox(
                                      height: 30,
                                      child: Center(
                                          child: Text('최근 검색 내역이 없습니다.', style: TextStyle(fontSize: 14, color: Colors.grey))
                                      ),
                                    ),
                                  ]

                                ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  :
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // 배경색
                  border: Border.all(
                    color: const Color.fromRGBO(248, 248, 248, 1), // 테두리 색상 설정
                    width: 1, // 테두리 두께
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: _searchMenuAuthList.isEmpty
                    ?
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ),
                )
                    :
                ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int index = 0; index < _searchMenuAuthList.length; index++)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                _searchMenuAuthList[index].path!,
                                // arguments: RouterParameters(
                                //   _searchMenuAuthList[index].path!,
                                // ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: _highlightSearchQuery(_searchMenuAuthList[index].title ?? '', _searchController.text),
                                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _searchController.text = _searchMenuAuthList[index].title!;
                                        },
                                        child: SvgPicture.asset(
                                          'Assets/icons/arrow_insert.svg',
                                          width: 22,
                                          colorFilter: const ColorFilter.mode(
                                            Color.fromRGBO(215, 215, 215, 1),
                                            BlendMode.srcIn, // 이 모드는 SVG의 색상 대체
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
