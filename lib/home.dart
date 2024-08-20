import 'dart:convert';
import 'package:buku_tamu/gen/assets.gen.dart';
import 'package:buku_tamu/screen/guestEmployee/page.dart';
import 'package:buku_tamu/screen/guestOften/page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../src/preference.dart';
import 'screen/gender/page.dart';
import 'screen/profile/page.dart';
import 'screen/totalGuest/page.dart';
import 'src/api.dart';
import 'src/constant.dart';
import 'src/dialog_info.dart';
import 'src/toast.dart';
import 'src/utils.dart';
import 'package:http/http.dart' as http;

import 'widgets/chart_indicator.dart';

class MainTabBar extends StatefulWidget {
  final id;
  // final token;
  const MainTabBar({
    Key? key,
    required this.id,
    // required this.token
  }) : super(key: key);

  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = false;
  int pageIndex = 0;
  String fullName = "";
  String division = "";
  String typeUser = "";
  String path = "";
  String accessToken = "";
  String dateString = "";
  late final Function(int) callback;
  String message = "";
  List<Map<String, dynamic>> listData = [];
  List listDataHistoryMonth = [];
  List listDataHistoryWeek = [];
  List listDataHistoryDay = [];
  String messagess = "";
  List<Widget> pages = <Widget>[]; // Declare pages here
  String? id = '';

  int totalMale = 0;
  int totalFemale = 0;
  int totalTamu = 0;
  int percentMale = 0;
  int totalUnknown = 0;
  int percentFemale = 0;
  int percentUnknown = 0;

  List totalGuest = [];
  int totalGuest0 = 0;
  int totalGuest1 = 0;
  int totalGuest2 = 0;

  String namaGuest0 = '';
  String namaGuest1 = '';
  String namaGuest2 = '';

  String percentGuest0 = '';
  String percentGuest1 = '';
  String percentGuest2 = '';

  List totalEmployee = [];
  int totalEmployee0 = 0;
  int totalEmployee1 = 0;
  int totalEmployee2 = 0;

  String namaEmployee0 = '';
  String namaEmployee1 = '';
  String namaEmployee2 = '';

  String percentEmployee0 = '';
  String percentEmployee1 = '';
  String percentEmployee2 = '';

  List totalVisit = [];
  int totalVisit0 = 0;
  int totalVisit1 = 0;
  int totalVisit2 = 0;
  int totalVisit3 = 0;
  int totalVisit4 = 0;

  String namaVisit0 = '';
  String namaVisit1 = '';
  String namaVisit2 = '';
  String namaVisit3 = '';
  String namaVisit4 = '';

  String percentVisit0 = '';
  String percentVisit1 = '';
  String percentVisit2 = '';
  String percentVisit3 = '';
  String percentVisit4 = '';

  List ListDataAsing = [];
  List foreignTotal = [];
  List foreignPrecentage = [];

  String fullname = "";
  late int userId = 0;

  var offset = 0;
  var limit = 10;

  @override
  void initState() {
    initializeData();
    getDataPie();
    getDataPieEmployee();
    getDataPieStranger();
    getDataPieKunjungan();
    super.initState();
  }

  void initializeData() async {
    id = await sharedPref.getPref('id_usr');
    print("idsblm $id");
    var userId = id.toString; // Adjust based on your shared preferences service
    print("idsesudah $userId");

    getData(id);
  }

  getData(id) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");

      print("accestoke");
      print(accessToken);
      var url = ApiService.detailUser;
      var uri = "$url/$id";
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      print(url);
      print(bearerToken);
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          var content = json.decode(response.body);
          print("getdatauser");
          print(content);

          fullname = content['data']['fullname'];
          division = content['data']['getrole']['name'];
          listData.add(content['data']);
          userId = content['data']['id'];
          path = content['data']['image'];
          print("linkpath");
          print(path);
        });
      } else {
        toastShort(context, message);
      }
    } catch (e) {
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  getDataPie() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.getPieKelamin;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      print(url);
      print(bearerToken);
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          var content = json.decode(response.body);
          print("getdatauser");
          print(content);
          print("total jenis kelamin");
          print(content['status']);
          print(content['totalMale']);

          totalMale = content['totalMale'];
          print(totalMale);
          totalFemale = content['totalFemale'];
          totalTamu = content['totalTamu'];
          totalUnknown = content['totalTamu'];
          percentMale = content['percentMale'];
          percentFemale = content['percentFemale'];
          percentUnknown = content['percentUnknown'];
          print("percentcowok");
          print(percentMale);

          print(totalFemale);
          print(totalTamu);
        });
      } else {
        toastShort(context, message);
      }
    } catch (e) {
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  getDataPieEmployee() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.getPieTamuKaryawan;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      print(url);
      print(bearerToken);
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          var content = json.decode(response.body);
          print("getdataemployee");
          print(content);
          totalEmployee = content['data'];

          totalEmployee0 = totalEmployee[0]['total'];
          totalEmployee1 = totalEmployee[1]['total'];
          totalEmployee2 = totalEmployee[2]['total'];

          namaEmployee0 = totalEmployee[0]['nama'];
          namaEmployee1 = totalEmployee[1]['nama'];
          namaEmployee2 = totalEmployee[2]['nama'];

          percentEmployee0 = totalEmployee[0]['percentage'];
          percentEmployee1 = totalEmployee[1]['percentage'];
          percentEmployee2 = totalEmployee[2]['percentage'];

          print("total");
        });
      } else {
        toastShort(context, message);
      }
    } catch (e) {
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  getDataPieStranger() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.getPieTamuAsing;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      print(url);
      print(bearerToken);
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          var content = json.decode(response.body);
          print("getdatastarnger");
          print(content);
          print("dataaing");


          totalGuest = content['data'];

          totalGuest0 = totalGuest[0]['total'];
          totalGuest1 = totalGuest[1]['total'];
          totalGuest2 = totalGuest[2]['total'];

          namaGuest0 = totalGuest[0]['nama'];
          namaGuest1 = totalGuest[1]['nama'];
          namaGuest2 = totalGuest[2]['nama'];

          percentGuest0 = totalGuest[0]['percentage'];
          percentGuest1 = totalGuest[1]['percentage'];
          percentGuest2 = totalGuest[2]['percentage'];

          print("total");
        });
      } else {
        toastShort(context, message);
      }
    } catch (e) {
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  getDataPieKunjungan() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.getPieKunjungan;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      print(url);
      print(bearerToken);
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          var content = json.decode(response.body);
          print("getdatakunjungan");
          print(content);

          totalVisit = content['data'];

          totalVisit0 = totalVisit[0]['total'];
          totalVisit1 = totalVisit[1]['total'];
          totalVisit2 = totalVisit[2]['total'];
          totalVisit3 = totalVisit[3]['total'];
          totalVisit4 = totalVisit[4]['total'];

          namaVisit0 = totalVisit[0]['nama'];
          namaVisit1 = totalVisit[1]['nama'];
          namaVisit2 = totalVisit[2]['nama'];
          namaVisit3 = totalVisit[3]['nama'];
          namaVisit4 = totalVisit[4]['nama'];

          percentVisit0 = totalVisit[0]['percentage'];
          percentVisit1 = totalVisit[1]['percentage'];
          percentVisit2 = totalVisit[2]['percentage'];
          percentVisit3 = totalVisit[3]['percentage'];
          percentVisit4 = totalVisit[4]['percentage'];
        });
      } else {
        toastShort(context, message);
      }
    } catch (e) {
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: clrPrimary,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingLogic(id: widget.id),
                    ),
                  );
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          // ignore: unnecessary_null_comparison
                          path != null ?
                          '${ApiService.folder}/$path' : '${ApiService.imgDefault} ',
                          scale: 8,
                        ),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullname,
                    style: SafeGoogleFont(
                      'SF Pro Text',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.2575,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    division,
                    style: SafeGoogleFont(
                      'SF Pro Text',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2575,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 10, left: 5, right: 5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 8, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 227, 227, 227),
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Top Tamu Yang Sering Mengunjungi',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndexBpk = -1;
                                                      return;
                                                    }
                                                    touchedIndexBpk =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 30,
                                              sections: showingSectionsGuest()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: Colors.amber,
                                              text:
                                                  "$namaGuest0: $totalGuest0",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPrimary,
                                              text:
                                                  "$namaGuest1: $totalGuest1",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDone,
                                              text:
                                                  "$namaGuest2: $totalGuest2",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 10, left: 5, right: 5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 8, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 227, 227, 227),
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Top Pegawai Yang Sering Dikuunjungi',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndexBpk = -1;
                                                      return;
                                                    }
                                                    touchedIndexBpk =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 30,
                                              sections: showingSectionsEmployee()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: Colors.amber,
                                              text:
                                                  "$namaEmployee0: $totalEmployee0",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPrimary,
                                              text:
                                                  "$namaEmployee1: $totalEmployee1",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDone,
                                              text:
                                                  "$namaEmployee2: $totalEmployee2",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 10, left: 5, right: 5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 8, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 227, 227, 227),
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Tamu Berdasarkan Jenis Kelamin',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                            pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (FlTouchEvent event,
                                                      pieTouchResponse) {
                                                setState(() {
                                                  if (!event
                                                          .isInterestedForInteractions ||
                                                      pieTouchResponse ==
                                                          null ||
                                                      pieTouchResponse
                                                              .touchedSection ==
                                                          null) {
                                                    touchedIndexBpk = -1;
                                                    return;
                                                  }
                                                  touchedIndexBpk =
                                                      pieTouchResponse
                                                          .touchedSection!
                                                          .touchedSectionIndex;
                                                });
                                              },
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            sectionsSpace: 2,
                                            centerSpaceRadius: 30,
                                            sections: showingSectionsBpk(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: Colors.amber,
                                              text: "Total Pria: $totalMale",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPrimary,
                                              text:
                                                  "Total Wanita: $totalFemale",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDone,
                                              text:
                                                  "Total Tidak Diketahui: $totalUnknown",
                                              isSquare: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 10, left: 5, right: 5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 8, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 227, 227, 227),
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Data Jumlah Jenis Kunjungan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndexBpk = -1;
                                                      return;
                                                    }
                                                    touchedIndexBpk =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 30,
                                              sections: showingSectionsVisit()),
                                        ),
                                      ),
                                      Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Indicator(
                                            color: Colors.amber,
                                            text:
                                                "$namaVisit0: $totalVisit0",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrPrimary,
                                            text:
                                                "$namaVisit1: $totalVisit1",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrDone,
                                            text:
                                                "$namaVisit2: $totalVisit2",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrSecondary,
                                            text:
                                                "$namaVisit2: $totalVisit3",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrBackground,
                                            text:
                                                "$namaVisit2: $totalVisit4",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Menu Buku Tamu',
                style: SafeGoogleFont('SF Pro Text',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.2575,
                    letterSpacing: 1,
                    color: Colors.black87),
              ),
            ),
            perencanaan(totalMale, totalFemale, totalTamu, totalUnknown,
                percentMale, percentFemale, percentUnknown),
          ],
        ),
      )),
      drawer: Drawer(
        backgroundColor: clrBackgroundLight,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: clrPrimary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingLogic(id: widget.id),
                        ),
                      );
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              '${ApiService.folder}/$path',
                              scale: 10,
                            ),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: SafeGoogleFont(
                          'SF Pro Text',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2575,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        division,
                        style: SafeGoogleFont(
                          'SF Pro Text',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2575,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: Text(
                'Hari ini',
                style: SafeGoogleFont('SF Pro Text',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.2575,
                    letterSpacing: 1,
                    color: Colors.black87),
              ),
              onTap: () {
                pageIndex = 0;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsGuest() {
              // Convert and format percentVisit variables
  double number0 = double.parse(percentGuest0);
  String formattedNumber0 = number0.toStringAsFixed(2);

  double number1 = double.parse(percentGuest1);
  String formattedNumber1 = number1.toStringAsFixed(2);

  double number2 = double.parse(percentGuest2);
  String formattedNumber2 = number2.toStringAsFixed(2);

    return List.generate(3, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.amber,
            // value: totalBudha.toDouble(),
            // title: totalBudha.toString(),
            value: totalGuest0.toDouble(),
            title: "$formattedNumber0%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: totalGuest1.toDouble(),
            title: "$formattedNumber1%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrDone,
            value: totalGuest2.toDouble(),
            title: "$formattedNumber2%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSectionsEmployee() {
          // Convert and format percentVisit variables
  double number0 = double.parse(percentEmployee0);
  String formattedNumber0 = number0.toStringAsFixed(2);

  double number1 = double.parse(percentEmployee1);
  String formattedNumber1 = number1.toStringAsFixed(2);

  double number2 = double.parse(percentEmployee2);
  String formattedNumber2 = number2.toStringAsFixed(2);

    return List.generate(3, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.amber,
            // value: totalBudha.toDouble(),
            // title: totalBudha.toString(),
            value: totalEmployee0.toDouble(),
            title: "$formattedNumber0%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: totalEmployee1.toDouble(),
            title: "$formattedNumber1%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrDone,
            value: totalEmployee2.toDouble(),
            title: "$formattedNumber2%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSectionsBpk() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.amber,
            // value: totalBudha.toDouble(),
            // title: totalBudha.toString(),
            value: totalMale.toDouble(),
            title: "$totalMale%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: totalFemale.toDouble(),
            title: "$totalFemale%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrDone,
            value: totalUnknown.toDouble(),
            title: "$totalUnknown%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSectionsVisit() {
      // Convert and format percentVisit variables
  double number0 = double.parse(percentVisit0);
  String formattedNumber0 = number0.toStringAsFixed(2);

  double number1 = double.parse(percentVisit1);
  String formattedNumber1 = number1.toStringAsFixed(2);

  double number2 = double.parse(percentVisit2);
  String formattedNumber2 = number2.toStringAsFixed(2);

  double number3 = double.parse(percentVisit3);
  String formattedNumber3 = number3.toStringAsFixed(2);

  double number4 = double.parse(percentVisit4);
  String formattedNumber4 = number4.toStringAsFixed(2);

   return List.generate(5, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.amber,
            // value: totalBudha.toDouble(),
            // title: totalBudha.toString(),
            value: totalVisit0.toDouble(),
            title: "$formattedNumber0%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: totalVisit1.toDouble(),
            title: "$formattedNumber1%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrDone,
            value: totalVisit2.toDouble(),
            title: "$formattedNumber2%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: clrSecondary,
            value: totalVisit3.toDouble(),
            title: "$formattedNumber3%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: clrBackground,
            value: totalVisit4.toDouble(),
            title: "$formattedNumber4%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget perencanaan(var totalMale, totalFemale, totalTamu, totalUnknown,
      percentMale, percentFemale, percentUnknown) {
    List<Location> locations = [
      Location(
        address: "Top Tamu Yang Sering Mengunjungi",
        color: Colors.black,
        imagePath: Assets.icons.icSerach.path,
        colorText: Colors.white,
      ),
      Location(
        address: "Top Pegawai Yang Sering Dikunjungi",
        color: Colors.green,
        imagePath: Assets.icons.icSerach.path,
        colorText: Colors.white,
      ),
      Location(
        address: "Data Jumlah Jenis Kelamin Tamu",
        color: Colors.white,
        imagePath: Assets.icons.icSerach.path,
        colorText: Colors.black,
      ),
      Location(
        address: "Data Jumlah Jenis Kunjungan Tamu",
        color: Colors.blue,
        imagePath: Assets.icons.icSerach.path,
        colorText: Colors.white,
      ),
    ];

    return SizedBox(
      child: ListView.separated(
        padding: const EdgeInsets.all(10),
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GuesOftenPage(
                      totalGuest : totalGuest,
                      totalGuest0: totalGuest0,
                      totalGuest1: totalGuest1,
                      totalGuest2: totalGuest2,
                      namaGuest0: namaGuest0,
                      namaGuest1: namaGuest1,
                      namaGuest2: namaGuest2,
                      percentGuest0: percentGuest0,
                      percentGuest1: percentGuest1,
                      percentGuest2: percentGuest2,
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmployeePage(
                      totalEmployee: totalEmployee,
                      totalEmployee0: totalEmployee0,
                      totalEmployee1: totalEmployee1,
                      totalEmployee2: totalEmployee2,
                      namaEmployee0: namaEmployee0,
                      namaEmployee1: namaEmployee1,
                      namaEmployee2: namaEmployee2,
                      percentEmployee0: percentEmployee0,
                      percentEmployee1: percentEmployee1,
                      percentEmployee2: percentEmployee2,
                    ),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GenderPage(
                      totalMale: totalMale,
                      totalFemale: totalFemale,
                      totalTamu: totalTamu,
                      totalUnknown: totalUnknown,
                      percentMale: percentMale,
                      percentFemale: percentFemale,
                      percentUnknown: percentUnknown,
                    ),
                  ),
                );
              } else if (index == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TotalVisitPage(
                      totalVisit0: totalVisit0,
                      totalVisit1: totalVisit1,
                      totalVisit2: totalVisit2,
                      totalVisit3: totalVisit3,
                      totalVisit4: totalVisit4,
                      namaVisit0: namaVisit0,
                      namaVisit1: namaVisit1,
                      namaVisit2: namaVisit2,
                      namaVisit3: namaVisit3,
                      namaVisit4: namaVisit4,
                      percentVisit0: percentVisit0,
                      percentVisit1: percentVisit1,
                      percentVisit2: percentVisit2,
                      percentVisit3: percentVisit3,
                      percentVisit4: percentVisit4,
                    ),
                  ),
                );
              } else {
                onBasicAlertPressed(context, "500", "Menu belum dibuat");
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(
                  color: locations[index].color,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(46, 52, 61, 0.42),
                      spreadRadius: 0.5,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(locations[index].imagePath),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 15),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              "${locations[index].address} \n",
                              style: SafeGoogleFont(
                                'SF Pro Text',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                height: 1.2575,
                                letterSpacing: 1,
                                color: locations[index].colorText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}

class Location {
  final String address;
  // final String state;
  final Color color;
  final Color colorText;
  final String imagePath;

  Location({
    required this.address,
    required this.color,
    required this.colorText,
    required this.imagePath,
    // required this.state,
  });
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
