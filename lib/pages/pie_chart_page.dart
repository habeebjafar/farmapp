import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:farmapp/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;


    CattleService _cattleService = CattleService();
  List<CattleModel> _list = [];
  List<CattleModel> _males = [];
  List<CattleModel> _females = [];
  List<CattleModel> _cows = [];
  List<CattleModel> _heifers = [];
  List<CattleModel> _bulls = [];
  List<CattleModel> _steers = [];
  List<CattleModel> _weaners = [];
  List<CattleModel> _calves = [];
  List<CattleModel> _pregnants = [];
  List<CattleModel> _lactating = [];
  List<CattleModel> _nonLactating = [];

  @override
  void initState() {
    super.initState();
    _getAllCattles();
  }

  _getAllCattles() async {
    var response = await _cattleService.getAllTCattles();
     print(response);

    response.forEach((data) {
      setState(() {
        var model = CattleModel();
        model.cattleName = data['cattleName'];
        model.cattleTagNo = data['cattleTagNo'];
        model.cattleGender = data['cattleGender'];
        model.cattleStage = data['cattleStage'];
        model.cattleBreed = data['cattleBreed'];
        model.cattleWeight = data['cattleWeight'];
        model.cattleDOB = data['cattleDOB'];
        model.cattleDOE = data['cattleDOE'];
        model.cattleObtainMethod = data['cattleObtainMethod'];
        model.cattleMotherTagNo = data['cattleMotherTagNo'];
        model.cattleFatherTagNo = data['cattleFatherTagNo'];
        model.cattleNote = data['cattleNotes'];
        
        _list.add(model);

        if(model.cattleGender.toString() == "Male"){
          _males.add(model);
        }

        if(model.cattleGender.toString() == "Female"){
          _females.add(model);
        }

        if(model.cattleStage.toString() == "Cow"){
          _cows.add(model);
        }

        if(model.cattleStage.toString() == "Heifer"){
          _heifers.add(model);
        }

        if(model.cattleStage.toString() == "Bull"){
          _bulls.add(model);
        }

        if(model.cattleStage.toString() == "Steer"){
          _steers.add(model);
        }

        if(model.cattleStage.toString() == "Weaner"){
          _weaners.add(model);
        }

        if(model.cattleStage.toString() == "calf"){
          _calves.add(model);
        }

        // if(model.cattleStage.toString() == "Female"){
        //   _females.add(model);
        // }


      });
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cattle Report"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 320,
              //color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
      
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Cattle by stage",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                        ),
                        ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: showingSectionsCattleSatge()),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[

                             Indicator(
                              color: Colors.orange,
                              text: 'Bulls',
                              isSquare: false,
                            ),

                             SizedBox(
                              width: 4,
                            ),
                            Indicator(
                              color: Color(0xff13d38e),
                              text: 'Cows',
                              isSquare: false,
                            ),

                              SizedBox(
                              width: 4,
                            ),
                            Indicator(
                              color: Color(0xff845bef),
                              text: 'Heifers',
                              isSquare: false,
                            ),

                            SizedBox(
                              width: 4,
                            ),
                            
                            Indicator(
                              color: Color(0xfff8b250),
                              text: 'Weaners',
                              isSquare: false,
                            ),
                           
                            SizedBox(
                              width: 4,
                            ),
                            Indicator(
                              color: Color(0xff0293ee),
                              text: 'Calves',
                              isSquare: false,
                            ),
                          
                             SizedBox(
                              width: 4,
                            ),
                           
                           
                           
                            
                          ],
                        ),
                         Indicator(
                          color: Colors.deepOrange,
                          text: 'Steers',
                          isSquare: false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
              ),
            ),

             Container(
              width: double.infinity,
              height: 310,
              //color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
      
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Cattle Stage",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                        ),
                        ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: showingSections()),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Indicator(
                          color: Color(0xff0293ee),
                          text: 'First',
                          isSquare: false,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Indicator(
                          color: Color(0xfff8b250),
                          text: 'Second',
                          isSquare: false,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Indicator(
                          color: Color(0xff845bef),
                          text: 'Third',
                          isSquare: false,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Indicator(
                          color: Color(0xff13d38e),
                          text: 'Fourth',
                          isSquare: false,
                        ),
                        
                      ],
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    List<PieChartSectionData> showingSectionsCattleSatge() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _bulls.length.toDouble(),
            title: '${_bulls.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _cows.length.toDouble(),
            title: '${_cows.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          case 2:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _heifers.length.toDouble(),
            title: '${_heifers.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          case 3:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _weaners.length.toDouble(),
            title: '${_weaners.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          case 4:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _calves.length.toDouble(),
            title: '${_calves.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          case 5:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _steers.length.toDouble(),
            title: '${_steers.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _males.length.toDouble(),
            title: '${_males.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _females.length.toDouble(),
            title: '${_females.length}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }
}
