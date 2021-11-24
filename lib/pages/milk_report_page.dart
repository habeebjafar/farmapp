import 'package:farmapp/provider/milk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MilkReportPage extends StatefulWidget {
  @override
  _MilReportPageState createState() => _MilReportPageState();
}

class _MilReportPageState extends State<MilkReportPage> {
  var provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MilkProvider>(context, listen: false);
    provider.getAllMilkRecord();

    // print(" checking tottal ${provider.totalMilkedProduced}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Milk Report"),
        ),
        body: SingleChildScrollView(
            child: Consumer<MilkProvider>(
          builder: (_, milkProvider, __) => Column(children: [
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Milk Summary:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daily mllk average",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${milkProvider.averageDailyMilk}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total milk produced",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${provider.totalMilkedProduced}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total milk for calves/used",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${milkProvider.totalMilkedUsed}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most productive cow",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${milkProvider.highestProductive}(${milkProvider.highestProductiveCow})",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Least productive cow",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${milkProvider.leastProductive}(${milkProvider.leastProductiveCow})",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Records:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 
                  children: [
                    Text("Day",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                    ),
                     Text("Produced",
                      style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                     ), 
                     Text("Used",
                      style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                     )
                     ],
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: milkProvider.milkRecordList.length,
              itemBuilder: (BuildContext context, index){
                return      Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 
                  children: [
                    Text("${milkProvider.milkRecordList[index].milkDate!.substring(5)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                    ),
                     Text("${milkProvider.milkRecordList[index].milkTotalProduced}",
                      style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                     ), 
                     Text("${milkProvider.milkRecordList[index].milkTotalUsed}",
                      style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                    ),
                     )
                     ],
                ),
              ),
            );
              }
              )

         
          ]),
        )));
  }
}
