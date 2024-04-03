import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'Services/countriesGetApi.dart';
import 'detailsScreen.dart';

class Countries_list extends StatefulWidget {
  const Countries_list({super.key});

  @override
  State<Countries_list> createState() => _Countries_listState();
}

class _Countries_listState extends State<Countries_list> {
  TextEditingController searchData = TextEditingController();

  CountriesGetApi countriesData = CountriesGetApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: const EdgeInsets.only(left: 20),
                height: MediaQuery.of(context).size.height * 0.065,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchData,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Search with country name",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      border: InputBorder.none),
                )),
            Expanded(
                child: FutureBuilder(
                    future: countriesData.fatchCountriesData(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]["country"];
                              if (searchData.text.isEmpty) {
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DetailsScreen(
                                                      flag: snapshot.data![index]
                                                              ["countryInfo"]
                                                          ["flag"],
                                                      country: snapshot.data![index]
                                                          ["country"],
                                                      cases: snapshot.data![index]
                                                          ["cases"],
                                                      todayCases: snapshot.data![index]
                                                          ["todayCases"],
                                                      deaths: snapshot.data![index]
                                                          ["deaths"],
                                                      todayDeaths:
                                                          snapshot.data![index]
                                                              ["todayDeaths"],
                                                      recovered: snapshot.data![index]
                                                          ["recovered"],
                                                      todayRecovered: snapshot.data![index]["todayRecovered"],
                                                      critical: snapshot.data![index]["critical"])));
                                        },
                                        child: ListTile(
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ["countryInfo"]["flag"]),
                                          ),
                                          title: Text(
                                            snapshot.data![index]["country"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            snapshot.data![index]["cases"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else if (name
                                  .toLowerCase()
                                  .contains(searchData.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DetailsScreen(
                                                      flag: snapshot.data![index]
                                                      ["countryInfo"]
                                                      ["flag"],
                                                      country: snapshot.data![index]
                                                      ["country"],
                                                      cases: snapshot.data![index]
                                                      ["cases"],
                                                      todayCases: snapshot.data![index]
                                                      ["todayCases"],
                                                      deaths: snapshot.data![index]
                                                      ["deaths"],
                                                      todayDeaths:
                                                      snapshot.data![index]
                                                      ["todayDeaths"],
                                                      recovered: snapshot.data![index]
                                                      ["recovered"],
                                                      todayRecovered: snapshot.data![index]["todayRecovered"],
                                                      critical: snapshot.data![index]["critical"])));
                                        },
                                        child: ListTile(
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                ["countryInfo"]["flag"]),
                                          ),
                                          title: Text(
                                            snapshot.data![index]["country"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            snapshot.data![index]["cases"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: LoadingAnimationWidget.halfTriangleDot(
                                      color: Colors.white, size: 100),
                                );
                              }
                            });
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 1,
                          child: LoadingAnimationWidget.halfTriangleDot(
                              color: Colors.white, size: 100),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
