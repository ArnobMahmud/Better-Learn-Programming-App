import 'package:better_learn_programming/config/customs.dart';
import 'package:better_learn_programming/widgets/covid19/covid-info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CovidDetails extends StatefulWidget {
  final int updated;
  final String countryName;
  final String flag;
  final String cases;
  final String casesToday;
  final String recovered;
  final String deaths;
  final String tests;
  final String active;
  final String recoveredToday;
  final String todayDeaths;
  const CovidDetails(
      {Key key,
      this.countryName,
      this.cases,
      this.recovered,
      this.deaths,
      this.tests,
      this.active,
      this.recoveredToday,
      this.todayDeaths,
      this.flag,
      this.casesToday,
      this.updated})
      : super(key: key);

  @override
  _CovidDetailsState createState() => _CovidDetailsState();
}

class _CovidDetailsState extends State<CovidDetails> {
  /* BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }*/
  // InterstitialAd myInterstitial;

  // @override
  // void initState() {
  //   super.initState();
  //   _createInterstitialAd(); // create ad
  // }

  // _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: Platform.isAndroid
  //          ? 'ca-app-pub-4066984467805494/1921276828'
  //         : 'ca-app-pub-4066984467805494/1921276828', // test ad ids for different platforms

  //     request: AdRequest(),

  //     adLoadCallback: InterstitialAdLoadCallback(
  //       // if ad fails to load
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('Ad exited with error: $error'); // print error
  //       },

  //       // else
  //       onAdLoaded: (InterstitialAd ad) {
  //         setState(() {
  //           this.myInterstitial = ad; // set the ad equal to the current ad
  //         });
  //       },
  //     ),
  //   );
  // }

  // _showInterstitialAd() {
  //   // create callbacks for ad
  //   myInterstitial.fullScreenContentCallback = FullScreenContentCallback(
  //     // when dismsissed
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       ad.dispose(); // dispose ad
  //     },

  //     // if ad fails to show
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error'); // print error
  //       ad.dispose(); // dispose ad
  //     },
  //   );

  //   myInterstitial.show(); // show ad
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        centerTitle: false,
        elevation: 4,
        backgroundColor: Colors.purple[100],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            // _showInterstitialAd();
            Navigator.pop(context); // pops page
          },
        ),
        title: AutoSizeText(
          '${widget.countryName} Covid Updates',
          //textAlign: TextAlign.left,
          maxLines: 2,
          minFontSize: 20.0,
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.blueGrey[600],
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400],
                offset: Offset(0, 2),
                spreadRadius: -1,
                blurRadius: 9)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  widget.flag,
                  height: 100,
                  width: 100,
                ),
                Flexible(
                  child: Text(
                    '${widget.countryName}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: Colors.blueGrey[600],
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Last Updated on\n${getFormattedDate(widget.updated, 'hh:mm a')}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: Colors.teal[300],
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CovidInfoCard(
                  title: 'Total Cases',
                  data: widget.cases,
                  color: Colors.brown[600],
                ),
                CovidInfoCard(
                  title: 'Total Recovered',
                  data: widget.recovered,
                  color: Colors.blue[900],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CovidInfoCard(
                  title: 'Cases Today',
                  data: widget.casesToday,
                  color: Colors.black,
                ),
                CovidInfoCard(
                  title: 'Recovered Today',
                  data: widget.recoveredToday,
                  color: Colors.green[900],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CovidInfoCard(
                  title: 'Total Deaths',
                  data: widget.deaths,
                  color: Colors.red[500],
                ),
                CovidInfoCard(
                  title: 'Deaths Today',
                  data: widget.todayDeaths,
                  color: Colors.red[900],
                ),
              ],
            ),
            Spacer(),
            /* _isBannerAdReady
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  )
                : Spacer(),*/
          ],
        ),
      ),
    );
  }
}
