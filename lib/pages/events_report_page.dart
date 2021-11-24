import 'package:farmapp/provider/cattle_provider.dart';
import 'package:farmapp/provider/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsReportPage extends StatefulWidget {
  @override
  _EventsReportPageState createState() => _EventsReportPageState();
}

class _EventsReportPageState extends State<EventsReportPage> {
  var provider;
  var cattleProvider;
  @override
  void initState() {
    super.initState();

    provider = Provider.of<EventsProvider>(context, listen: false);
    provider.getAllIndividualEventRecord();
    provider.getAllMassEventRecord();

    cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    cattleProvider.getAllCattles("Unarchive Cattle");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events Report"),
        ),
        body: SingleChildScrollView(
            child: Consumer<EventsProvider>(
          builder: (_, eventProvider, __) => Column(children: [
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
                      "Individual Events:",
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
                      "Treated",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.treatededCattleEventsList.length}",
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
                      "Weaned",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.weanedCattleEventsList.length}",
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
                      "Gave Birth",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.birthedCattleEventsList.length}",
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
                      "Dry Offs",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.dryOffCattleEventsList.length}",
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
                      "Inseminated/Mated",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.matedCattleEventsList.length}",
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
                      "Abortions",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.abortedCattleEventsList.length}",
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
                      "Castrated",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.castratedCattleEventsList.length}",
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
                      "Vaccinated",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.vaccinatedCattleEventsList.length}",
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
                      "Weighed",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.weighedCattleEventsList.length}",
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
                      "Ohers",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.otherCattleEventsList.length}",
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
                      "Mass Events:",
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
                      "Vaccination",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.vaccinatedCattleMassEventsList.length}",
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
                      "Herd spraying",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.herdSprayCattleMassEventsList.length}",
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
                      "Treatment",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.treatededCattleMassEventsList.length}",
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
                      "Tagging",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.taggedCattleMassEventsList.length}",
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
                      "Others",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${eventProvider.otherCattleMassEventsList.length}",
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
                      "Archives:",
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
                      "Lost",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.lostCattleList.length}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            // ListView.builder(
            //   itemCount: cattleProvider.lostCattleList.length,
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilder: (BuildContext context, int index){
            //     return Text("${cattleProvider.lostCattleList[index].cattleMotherTagNo}");
            //   }
            //   ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dead",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.deadCattleList.length}",
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
                      "Sold",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.soldCattleList.length}",
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
                      "Loaned",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.loanedCattleList.length}",
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
                      "Gifted",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.giftedCattleList.length}",
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
                      "Others",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${cattleProvider.otherCattleList.length}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),

            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: EdgeInsets.all(8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Bulls"),
            //           Text("${_bulls.length}")
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: EdgeInsets.all(8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Steers"),
            //           Text("${_steers.length}")
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: EdgeInsets.all(8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Weaners"),
            //           Text("${_weaners.length}")
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: EdgeInsets.all(8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Calves"),
            //           Text("${_calves.length}")
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ]),
        )));
  }
}
