import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../src/constant.dart';
import '../../src/utils.dart';
import '../../widgets/chart_indicator.dart';

// ignore: must_be_immutable
class TotalVisitPage extends StatefulWidget {
  final totalVisit0, totalVisit1, totalVisit2, totalVisit3, totalVisit4;

  String namaVisit0,
      namaVisit1,
      namaVisit2,
      namaVisit3,
      namaVisit4,
      percentVisit0,
      percentVisit1,
      percentVisit2,
      percentVisit3,
      percentVisit4;

  TotalVisitPage({
    super.key,
    required this.totalVisit0,
    required this.totalVisit1,
    required this.totalVisit2,
    required this.totalVisit3,
    required this.totalVisit4,
    required this.namaVisit0,
    required this.namaVisit1,
    required this.namaVisit2,
    required this.namaVisit3,
    required this.namaVisit4,
    required this.percentVisit0,
    required this.percentVisit1,
    required this.percentVisit2,
    required this.percentVisit3,
    required this.percentVisit4,
  });

  @override
  State<TotalVisitPage> createState() => _TotalVisitPageState();
}

class _TotalVisitPageState extends State<TotalVisitPage> {
  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: clrPrimary,
        title: const Text(
          "Data Jumlah Jenis Kunjungan Tamu",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 0, right: 5),
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
                  height: 240,
                  // height: MediaQuery.of(context).size.width * 0.71,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 34,
                                width: 350,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Data Jumlah Jenis Kunjungan Tamu',
                                          style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
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
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                              setState(() {
                                                if (!event
                                                        .isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
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
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Indicator(
                                            color: Colors.amber,
                                            text:
                                                "${widget.namaVisit0}: ${widget.totalVisit0}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrPrimary,
                                            text:
                                                "${widget.namaVisit1}: ${widget.totalVisit1}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrDone,
                                            text:
                                                "${widget.namaVisit2}: ${widget.totalVisit2}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrSecondary,
                                            text:
                                                "${widget.namaVisit2}: ${widget.totalVisit3}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrBackground,
                                            text:
                                                "${widget.namaVisit2}: ${widget.totalVisit4}",
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        widget.namaVisit0,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalVisit0.toString(),
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.namaVisit1,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalVisit1.toString(),
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.namaVisit2,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalVisit2.toString(),
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.namaVisit3,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalVisit3.toString(),
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.namaVisit4,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalVisit4.toString(),
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),

                // Text(
                //   'Menu Buku Tamu',
                //   style: SafeGoogleFont('SF Pro Text',
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700,
                //       height: 1.2575,
                //       letterSpacing: 1,
                //       color: Colors.black87),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsBpk() {
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
            value: widget.totalVisit0.toDouble(),
            title: "${widget.percentVisit0}%",
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
            value: widget.totalVisit1.toDouble(),
            title: "${widget.percentVisit1}%",
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
            value: widget.totalVisit2.toDouble(),
            title: "${widget.percentVisit2}%",
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
            value: widget.totalVisit3.toDouble(),
            title: "${widget.percentVisit3}%",
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
            value: widget.totalVisit4.toDouble(),
            title: "${widget.percentVisit4}%",
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
}
