import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:better_learn_programming/models/country-covid-model.dart';
import 'package:better_learn_programming/widgets/covid19/world-covid-info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as Http;

import 'covid-details.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  @override
  void didChangeDependencies() {
    getCountryData();
    super.didChangeDependencies();
  }

  List<CountryData> countryData = [];
  bool isLoading = true;

  Future<void> getCountryData() async {
    final url = "https://disease.sh/v3/covid-19/countries";
    try {
      final response = await Http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final responseMap = jsonDecode(response.body);
        setState(
          () {
            for (Map map in responseMap) {
              countryData.add(
                CountryData.fromJson(map),
              );
            }

            isLoading = false;
          },
        );
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<Map<String, dynamic>> fetchWorldData() async {
    final url = 'https://disease.sh/v3/covid-19/all';
    try {
      final response = await Http.get(
        Uri.parse(url),
      );
      final responseMap = json.decode(response.body);
      return responseMap;
    } catch (error) {
      throw error;
    }
  }

  String converter(int data) {
    String B = 'B';
    String M = 'M';
    String K = 'K';
    if (data >= 1000000000) {
      final convertData = data / 1000000000;
      return convertData.toStringAsFixed(2) + B;
    } else if (data >= 1000000) {
      final convertData = data / 1000000;
      return convertData.toStringAsFixed(2) + M;
    } else if (data >= 1000) {
      final convertData = data / 1000;
      return convertData.toStringAsFixed(2) + K;
    } else {
      final convertData = data;
      return convertData.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          backgroundColor: Colors.amber[50],
          elevation: 0,
          title: Text(
            'Covid\'19 Tracker',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.blueGrey,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          centerTitle: false,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     size: 30.0,
          //     color: Colors.blueGrey,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        height: MediaQuery.of(context).size.height * .22,
                        color: Colors.amber[50],
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    'Novel Corona\nVirus',
                                    maxLines: 2,
                                    minFontSize: 26,
                                    style: TextStyle(
                                      color: Colors.teal[800],
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AutoSizeText(
                                    'Stay Home Stay Safe',
                                    minFontSize: 18,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.brown[800],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .30,
                              width: MediaQuery.of(context).size.width * .35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/bacteria.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                             margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.pink[50],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Worldwide Covid Info',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.brown[800],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .40,
                                                child: FutureBuilder<
                                                    Map<String, dynamic>>(
                                                  future: fetchWorldData(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          WorldCovidInfo(
                                                            title:
                                                                'Total\nCases',
                                                            color:
                                                                Colors.purple,
                                                            imagePath:
                                                                'images/img3.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'cases'],
                                                            ),
                                                          ),
                                                          WorldCovidInfo(
                                                            title:
                                                                'New\nConfirmed',
                                                            color: Colors
                                                                .orange[900],
                                                            imagePath:
                                                                'images/img1.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'todayCases'],
                                                            ),
                                                          ),
                                                          WorldCovidInfo(
                                                            title:
                                                                'Total\nRecovered',
                                                            color: Colors
                                                                .green[900],
                                                            imagePath:
                                                                'images/img6.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'recovered'],
                                                            ),
                                                          ),
                                                          WorldCovidInfo(
                                                            title:
                                                                'New\nRecovered',
                                                            color: Colors
                                                                .green[700],
                                                            imagePath:
                                                                'images/img4.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'todayRecovered'],
                                                            ),
                                                          ),
                                                          WorldCovidInfo(
                                                            title:
                                                                'Total\nDeaths',
                                                            color:
                                                                Colors.red[900],
                                                            imagePath:
                                                                'images/img5.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'deaths'],
                                                            ),
                                                          ),
                                                          WorldCovidInfo(
                                                            title:
                                                                'New\nDeaths',
                                                            color:
                                                                Colors.red[700],
                                                            imagePath:
                                                                'images/img2.png',
                                                            data: converter(
                                                              snapshot.data[
                                                                  'todayDeaths'],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber[50],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          itemCount: countryData.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = countryData[index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        CovidDetails(
                                                      updated: data.updated,
                                                      countryName: data.country
                                                          .toString(),
                                                      flag: data
                                                          .countryInfo.flag
                                                          .toString(),
                                                      cases:
                                                          data.cases.toString(),
                                                      recovered: data.recovered
                                                          .toString(),
                                                      deaths: data.deaths
                                                          .toString(),
                                                      active: data.active
                                                          .toString(),
                                                      recoveredToday: data
                                                          .todayRecovered
                                                          .toString(),
                                                      todayDeaths: data
                                                          .todayDeaths
                                                          .toString(),
                                                      casesToday: data
                                                          .todayCases
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 8.0,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.red[100],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(1, 2),
                                                        spreadRadius: -7,
                                                        blurRadius: 10)
                                                  ],
                                                ),
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            data.country
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .ubuntu(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                        .blueGrey[
                                                                    600],
                                                                fontSize: 22.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Image.network(
                                                            data.countryInfo
                                                                .flag
                                                                .toString(),
                                                            height: 60,
                                                            width: 60,
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .1,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Cases :  ${data.cases}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .brown[
                                                                        600],
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // maxLines: 2,
                                                                softWrap: true,
                                                              ),
                                                              Text(
                                                                'Recovered :  ${data.recovered}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .green[
                                                                        800],
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                softWrap: true,
                                                              ),
                                                              Text(
                                                                'Deaths :   ${data.deaths}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        800],
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: _isBannerAdReady
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: _bannerAd.size.width.toDouble(),
                            height: _bannerAd.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd),
                          ),
                        )
                      : SizedBox(
                          height: 1,
                        ),
                ),*/
                ],
              ));
  }
}
