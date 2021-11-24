import 'package:farmapp/models/expense_model.dart';
import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/pages/data_summary_page.dart';
import 'package:farmapp/services/expense_service.dart';
import 'package:farmapp/services/income_service.dart';
import 'package:farmapp/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransactionReportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransactionReportPageState();
}

class TransactionReportPageState extends State {
  int touchedIndex = -1;


  var _totalncome = 0.0;
  var _totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _getTotalIncome();
    _getTotalExpenses();
  }

  _getTotalIncome() async {
    IncomeService incomeService = IncomeService();
    var response = await incomeService.getAllIncomeRecord();
    response.forEach((data) {
      setState(() {
        var model = IncomeModel();
        model.amountEarned = data['amountEarned'];
        _totalncome = _totalncome + double.parse(model.amountEarned.toString());
      });
    });
  }

  _getTotalExpenses() async {
    ExpenseService expenseService = ExpenseService();
    var response = await expenseService.getAllExpenseRecord();
    response.forEach((data) {
      setState(() {
        var model = ExpenseModel();
        model.amountSpent = data['amountSpent'];
        _totalExpense =
            _totalExpense + double.parse(model.amountSpent.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions Report"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DataSummaryPage()) 
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.orange,
                    child: Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white,),
                        Text(
                          "Data Summary",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
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
                      child: Text(
                        "Current Month",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
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
                              sections: showingSectionsCattleGender()),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Indicator(
                          color: Colors.green,
                          text: 'Income',
                          isSquare: false,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Indicator(
                          color: Colors.orange,
                          text: 'Expense',
                          isSquare: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Total Income:"), Text("$_totalncome")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Total Expenses:"), Text("$_totalExpense")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Net:"),
                      Text("${_totalncome - _totalExpense}")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsCattleGender() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: _totalncome,
            title: '$_totalncome',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: _totalExpense,
            title: '$_totalExpense',
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
