import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mymosque/app/compare.dart';

import 'package:mymosque/components/cardrace.dart';
import 'package:mymosque/components/crud.dart';
import 'package:mymosque/constant/colorConfig.dart';
import 'package:mymosque/constant/linkapi.dart';
import 'package:mymosque/main.dart';
import 'package:lottie/lottie.dart';
import 'package:mymosque/model/racemodel.dart';

class UserRace extends StatefulWidget {
  const UserRace({Key? key}) : super(key: key);
  _UserRaceState createState() => _UserRaceState();
}

class _UserRaceState extends State<UserRace> {
  getUsers() async {
    var response = await postRequest(linkViewRaces, {
      "subGroup": "ALL",
      "myGroup": sharedPref.getString("myGroup"),
    });
    return response;
  }

  late List raceData;
  String sortColumn = "startDate";
  String rankName = "كلي";

  bool _isSwitchedOn = false;

  var dt = DateTime.now();
  var now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('rank initState');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 160.0,
          backgroundColor: buttonColor2,
          centerTitle: true,
          actions: const [],
          title: Column(
            children: [
              Text(
                "بطاقات المسابقات",
                style: TextStyle(
                    color: textColor2,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // leadingWidth: 1.0,
        ),
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              FutureBuilder(
                  future: getUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // sort the score
                      // List raceData = snapshot.data['data'];
                      // raceData.sort((a, b) => int.parse(b['finalScore'])
                      //     .compareTo(int.parse(a['finalScore'])));
                      // /////////////////////////////
                      if (_isSwitchedOn == true) {
                        raceData = snapshot.data['data']
                            .where((o) =>
                                o['subGroup'] ==
                                sharedPref.getString("subGroup"))
                            .toList();
                      } else {
                        raceData = snapshot.data['data'];
                      }

                      // raceData.sort((a, b) {
                      //   int cmp = int.parse(b[sortColumn])
                      //       .compareTo(int.parse(a[sortColumn]));
                      //   if (cmp != 0) return cmp;
                      //   return int.parse(b['myGroup'])
                      //       .compareTo(int.parse(a['myGroup']));
                      // });
                      if (snapshot.data['status'] == 'fail')
                        return Center(
                            child: Text(
                          "لايوجد مسابقات",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ));
                      return ListView.builder(
                          itemCount: raceData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return CardRace(
                              ontap: () {
                                print(raceData[i]['id']);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => CompareScreen(
                                //           userID2: raceData[i]['id'],
                                //         )));
                              },
                              racemodel: RaceModel.fromJson(raceData[i]),
                              rank_index: i,
                              sortColumn: sortColumn,
                            );
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            Text("جاري التحميل ..."),
                            Lottie.asset(
                              'assets/lottie/93603-loading-lottie-animation.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      child: Center(
                        child: Column(
                          children: [
                            Text("خطأ في التحميل ..."),
                            Lottie.asset(
                              'assets/lottie/52108-error.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        // floatingActionButton: FloatingActionButton(
        //   mini: true,
        //   child: Icon(Icons.filter),
        //   tooltip: "مسجد/حلقة",
        //   elevation: 12,
        //   splashColor: textColor2,
        //   hoverColor: buttonColor,
        //   highlightElevation: 50,
        //   hoverElevation: 50,
        //   onPressed: () {
        //     AwesomeDialog(
        //       context: context,
        //       animType: AnimType.SCALE,
        //       dialogType: DialogType.INFO,
        //       keyboardAware: true,
        //       body: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           children: <Widget>[
        //             Text(
        //               'اختار الحلقة!',
        //               style: Theme.of(context).textTheme.headline6,
        //             ),
        //             SizedBox(
        //               height: 10,
        //             ),
        //             /////

        //             ///
        //             SizedBox(
        //               height: 10,
        //             ),
        //             AnimatedButton(text: 'تم', pressEvent: () {})
        //           ],
        //         ),
        //       ),
        //     )..show();
        //   },
        // ),
      ),
    );
  }
}
