import 'package:covid19/comons/card.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Services/totalData.dart';
import '../countries.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {

    GetApi getApi = GetApi();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getApi.fetchCovidData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: PieChart(
                              dataMap: {
                                "Total": ((snapshot.data as Map<String, dynamic>)["cases"] ?? 0).toDouble(),
                                "Recovered": ((snapshot.data as Map<String, dynamic>)["recovered"] ?? 0).toDouble(),
                                "Deaths": ((snapshot.data as Map<String, dynamic>)["deaths"] ?? 0).toDouble(),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true
                              ),
                              animationDuration:
                              const Duration(milliseconds: 1200),
                              colorList: colorList,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left,
                                  legendTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              chartRadius:
                              MediaQuery.of(context).size.width * 0.45,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          cards(context, "Total", (snapshot.data as Map<String, dynamic>)["cases"].toString()),
                          cards(context, "Deaths", (snapshot.data as Map<String, dynamic>)["deaths"].toString()),
                          cards(context, "Recovered", (snapshot.data as Map<String, dynamic>)["recovered"].toString()),
                          cards(context, "Active", (snapshot.data as Map<String, dynamic>)["active"].toString()),
                          cards(context, "Critical", (snapshot.data as Map<String, dynamic>)["critical"].toString()),
                          cards(context, "Today Deaths", (snapshot.data as Map<String, dynamic>)["todayDeaths"].toString()),
                          cards(context, "Today Recovered", (snapshot.data as Map<String, dynamic>)["todayRecovered"].toString()),

                          const SizedBox(
                            height: 40,
                          ),
                          //btn
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Countries_list()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height:
                              MediaQuery.of(context).size.height * 0.075,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                "Track Countries",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height*1,
                        width: MediaQuery.of(context).size.width*1,
                        child: LoadingAnimationWidget.halfTriangleDot(color: Colors.white, size: 100),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
