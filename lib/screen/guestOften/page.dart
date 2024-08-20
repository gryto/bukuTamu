import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../src/constant.dart';
import '../../src/utils.dart';
import '../../widgets/chart_indicator.dart';

// ignore: must_be_immutable
class GuesOftenPage extends StatefulWidget {
  final totalGuest0, totalGuest1, totalGuest2, totalGuest;

  String namaGuest0,
      namaGuest1,
      namaGuest2,
      percentGuest0,
      percentGuest1,
      percentGuest2;

  GuesOftenPage({
    super.key,
    required this.totalGuest,
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
                                                "${widget.namaGuest0}: ${widget.totalGuest0}",
                                            isSquare: true,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Indicator(
                                            color: clrPrimary,
                                            text:
                                                "${widget.namaGuest1}: ${widget.totalGuest1}",
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
                child: ListView.separated(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var row = widget.totalGuest[index];

                    print("totalguest");
                    print(row);

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Detail",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: const Text('Nama'),
                                          subtitle: Text(row['nama']),
                                        ),
                                        ListTile(
                                          title: const Text('Alamat'),
                                          subtitle: Text(row['alamat']),
                                        ),
                                        ListTile(
                                          title: const Text('Email'),
                                          subtitle: Text(row['email']),
                                        ),
                                        ListTile(
                                          title: const Text('NoHP'),
                                          subtitle: Text(row['no_hp']),
                                        ),
                                        ListTile(
                                          title: const Text('TempatLahir'),
                                          subtitle: Text(row['tempat_lahir']),
                                        ),
                                        ListTile(
                                          title: const Text('TanggalLahir'),
                                          subtitle: Text(row['tgl_lahir']),
                                        ),
                                        ListTile(
                                          title: const Text('JenisKelamin'),
                                          subtitle: Text(row['jenis_kelamin']),
                                        ),
                                        ListTile(
                                          title: const Text('JenisKunjungan'),
                                          subtitle:
                                              Text(row['jenis_kunjungan']),
                                        ),
                                        ListTile(
                                          title: const Text('Keperluan'),
                                          subtitle: Text(row['keperluan']),
                                        ),
                                        ListTile(
                                          title: const Text('TujuanSatker'),
                                          subtitle: Text(row['tujuan_satker']),
                                        ),
                                        ListTile(
                                          title: const Text('TujuanPIC'),
                                          subtitle: Text(row['tujuan_pic']),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tutup'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text(
                              row['nama'],
                              style: SafeGoogleFont('SF Pro Text',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2575,
                                  letterSpacing: 1,
                                  color: Colors.black87),
                            ),
                            trailing: Text(
                              row['total'].toString(),
                              style: SafeGoogleFont('SF Pro Text',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2575,
                                  letterSpacing: 1,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount:
                      widget.totalGuest.isEmpty ? 0 : widget.totalGuest.length,
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 5,
                  ),
                ),
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
