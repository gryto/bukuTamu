import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../src/constant.dart';
import '../../src/utils.dart';
import '../../widgets/chart_indicator.dart';

class GenderPage extends StatefulWidget {
  final totalMale,
      totalFemale,
      totalTamu,
      totalUnknown,
      percentMale,
      percentFemale,
      percentUnknown;

  const GenderPage({
    super.key,
    required this.totalMale,
    required this.totalFemale,
    required this.totalTamu,
    required this.totalUnknown,
    required this.percentMale,
    required this.percentFemale,
    required this.percentUnknown,
  });

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  String totalLaki = "";
  String totalWanita = "";
  String totalGktau = "";

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    totalLaki = widget.totalMale.toString();
    totalWanita = widget.totalFemale.toString();
    totalGktau = widget.totalUnknown.toString();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: clrPrimary,
        title: const Text(
          "Data Jumlah Jenis Kelamin Tamu",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
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
                                          'Total Tamu Berdasarkan Jenis Kelamin',
                                          style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '( Periode -  2023 )',
                                          style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
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
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Indicator(
                                            color: Colors.amber,
                                            text: "Total Pria: ${widget.totalMale}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrPrimary,
                                            text: "Total Wanita: ${widget.totalFemale}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrDone,
                                            text:
                                                "Total Tidak Diketahui: ${widget.totalUnknown}",
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
                        'Total Tamu Laki-Laki',
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalMale.toString(),
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
                        'Total Tamu Perempuan',
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalFemale.toString(),
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
                        'Total Tamu Tidak Diketahui',
                        style: SafeGoogleFont('SF Pro Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2575,
                            letterSpacing: 1,
                            color: Colors.black87),
                      ),
                      trailing: Text(
                        widget.totalUnknown.toString(),
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
            value: widget.totalMale.toDouble(),
            title: widget.totalMale.toString() + "%",
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
            value: widget.totalFemale.toDouble(),
            title: "${widget.totalFemale}%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        // case 2:
        //   return PieChartSectionData(
        //     color: clrSecondary,
        //     value: totalTamu.toDouble(),
        //     title: totalTamu.toString(),
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black87,
        //     ),
        //   );
        case 2:
          return PieChartSectionData(
            color: clrDone,
            value: widget.totalUnknown.toDouble(),
            title: widget.totalUnknown.toString() + "%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        // case 4:
        //   return PieChartSectionData(
        //     color: clrSecondary,
        //     value: 25,
        //     title: "25",
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black87,
        //     ),
        //   );

        default:
          throw Error();
      }
    });
  }
}
