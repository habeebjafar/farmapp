import 'package:farmapp/pages/cattle_breed_page.dart';
import 'package:farmapp/pages/income_category_page.dart';
import 'package:flutter/material.dart';

import 'expense_category_page.dart';

class FarmSetupPage extends StatefulWidget {
  
  @override
  _FarmSetupPageState createState() => _FarmSetupPageState();
}

class _FarmSetupPageState extends State<FarmSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm setup"),
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
                                builder: (context) => IncomeCategoryPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
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
                                    "Income \n Categories",
                                    style: TextStyle(
                                      fontSize: 18,
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
                                builder: (context) => ExpenseCategoryPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/profits.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Expense \n Categories",
                                    style: TextStyle(
                                      fontSize: 18,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CattleBreedPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 140,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/cattle.jpg",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Cattle Breeds",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      
                                    ),
                                    textAlign: TextAlign.center
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    Container( width: 160,
                            height: 140,)
                   
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