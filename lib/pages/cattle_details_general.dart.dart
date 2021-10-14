import 'package:farmapp/models/cattle_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CattleDetailsGeneral extends StatefulWidget {

  final List<CattleModel> _list;
  final int index;

  CattleDetailsGeneral(this._list, this.index);
  

  @override
  _CattleDetailsGeneralState createState() => _CattleDetailsGeneralState();
}

class _CattleDetailsGeneralState extends State<CattleDetailsGeneral> {
  @override
  Widget build(BuildContext context) {
    var dob = DateFormat('yyyy MMM, dd').format(DateTime.parse("${this.widget._list[this.widget.index].cattleDOB}"));
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 7, 0, 7),
                            width: double.infinity,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "General details",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                     ),
                                  ),
                               
                              ],
                            ),
                          ),

                          SizedBox(height: 10,),

                          Row(
                            
                            children: [
                              Text("Tag No:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleTagNo}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Name:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleName}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("D.O.B:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "$dob",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Age:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Gender:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleGender}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),


                            Row(
                            
                            children: [
                              Text("Weight:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleWeight}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Stage:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleStage}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "non lactating",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Breed:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleBreed}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Joined On:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleDOE}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Source:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleObtainMethod}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Mother:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleMotherTagNo}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Father:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleFatherTagNo}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),

                            Row(
                            
                            children: [
                              Text("Notes:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${this.widget._list[this.widget.index].cattleNote}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                           SizedBox(height: 15,),


                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
      
    );
  }
}