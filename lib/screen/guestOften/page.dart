import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../src/constant.dart';
import '../../src/utils.dart';
import '../../widgets/chart_indicator.dart';

// ignore: must_be_immutable
class GuesOftenPage extends StatefulWidget {
  final totalGuest0,
      totalGuest1,
      totalGuest2;
      String
      namaGuest0,
      namaGuest1,
      namaGuest2,
      percentGuest0,
      percentGuest1,
      percentGuest2;

  GuesOftenPage({
    super.key,
    required this.totalGuest0,
    required this.totalGuest1,
    required this.totalGuest2,
    required this.namaGuest0,
    required this.namaGuest1,
    required this.namaGuest2,
    required this.percentGuest0,
    required this.percentGuest1,
    required this.percentGuest2,
  });

  @override
  State<GuesOftenPage> createState() => _GuesOftenPageState();
}

class _GuesOftenPageState extends State<GuesOftenPage> {
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
          "Data Jumlah Tamu Yang Sering Mengunjungi",
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
                                          'Total Tamu Yang Sering Mengunjungi',
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
                                            text: "${widget.namaGuest0}: ${widget.totalGuest0}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrPrimary,
                                            text: "${widget.namaGuest1}: ${widget.totalGuest1}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrDone,
                                            text:
                                                "${widget.namaGuest2}: ${widget.totalGuest2}",
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
                        widget.namaGuest0,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                         widget.totalGuest0.toString(),
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
                        widget.namaGuest1,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalGuest1.toString(),
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
                        widget.namaGuest2,
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalGuest2.toString(),
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
            value: widget.totalGuest0.toDouble(),
            title: widget.percentGuest0.toString() + "%",
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
            value: widget.totalGuest1.toDouble(),
            title: widget.percentGuest1.toString() + "%",
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
            value: widget.totalGuest2.toDouble(),
            title: widget.percentGuest2.toString() + "%",
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
