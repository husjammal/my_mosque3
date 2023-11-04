import 'package:mymosque/constant/colorConfig.dart';
import 'package:mymosque/model/markmodel.dart';
import 'package:flutter/material.dart';

class CardMarks extends StatelessWidget {
  final void Function()? ontap;
  final MarkModel? markmodel;
  final int? rank_index;
  final String? sortColumn;

  const CardMarks(
      {Key? key, this.ontap, this.markmodel, this.rank_index, this.sortColumn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        color: backgroundColor,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                        width: 50.0,
                        child: Container(
                          // width: 30,
                          alignment: Alignment.center,
                          child: Text(
                            (rank_index! + 1).toString(),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        )),
                    // SizedBox(
                    //   width: 5,
                    // ),

                    Text(
                      "${markmodel!.subuh}",
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        "${markmodel!.zhur}",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "مسجد ${markmodel!.myGroup},حلقة ${markmodel!.subGroup}",
                    style: TextStyle(fontSize: 10.0),
                  ),
                  isThreeLine: true,
                  trailing: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: buttonColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "مجموع",
                          style: TextStyle(color: Colors.white, fontSize: 8.0),
                        ),
                        // Text(""),
                        Text("",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
