import 'package:farmapp/pages/events_report_page.dart';
import 'package:farmapp/pages/milk_report_page.dart';
import 'package:farmapp/pages/pie_chart_page.dart';
import 'package:farmapp/pages/transactions_report_page.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body: SingleChildScrollView(
        child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionReportPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                             color: Colors.orange,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/salary.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Transactions",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                       fontWeight: FontWeight.w800,
                                    ),
                                     textAlign: TextAlign.center
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(

                         onTap: () {
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MilkReportPage()));
                      },

                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                            color: Theme.of(context).primaryColor,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/milk.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Milk Report",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      
                                    ),
                                     textAlign: TextAlign.center
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),

                 SizedBox(height: 10,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PieChartSample2()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                            color: Theme.of(context).primaryColor,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/cow3.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Cattle Report",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      
                                    ),
                                    textAlign: TextAlign.center
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),

                     GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventsReportPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                            color: Colors.orange,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/notes.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Events Report",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      
                                    ),
                                    textAlign: TextAlign.center
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                   
                  ],
                ),

               
                SizedBox(
                  height: 20,
                )
              ],
            ),
      ),

      
    );
  }
}