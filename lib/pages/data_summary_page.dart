import 'package:farmapp/models/expense_model.dart';
import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/services/expense_service.dart';
import 'package:farmapp/services/income_service.dart';
import 'package:flutter/material.dart';

class DataSummaryPage extends StatefulWidget {
  @override
  _DataSummaryPageState createState() => _DataSummaryPageState();
}

class _DataSummaryPageState extends State<DataSummaryPage> {
  List<IncomeModel> _incomeList = [];
  List<ExpenseModel> _expenseList = [];
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
        model.incomeType = data['incomeType'];
        model.selectedValueIncomeCategory = data['selectedValueIncomeCategory'];
        model.otherSource = data['otherSource'];
        model.incomeDate = data['incomeDate'];
        _incomeList.add(model);

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
        model.expenseType = data['expenseType'];
        model.selectedValueExpenseCategory = data['selectedValueExpenseCategory'];
        model.otherExpense = data['otherExpense'];
        _expenseList.add(model);

        _totalExpense =
            _totalExpense + double.parse(model.amountSpent.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Month",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Income",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.orange)),
              Divider(
                thickness: 1,
              ),
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _incomeList.length,
                  itemBuilder: (BuildContext context, index) {
                    var incomeType = _incomeList[index].incomeType == "Category Income" ?
                    _incomeList[index].selectedValueIncomeCategory : _incomeList[index].incomeType == 
                    "Other (specify)" ? _incomeList[index].otherSource : _incomeList[index].incomeType;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  Text("${_incomeList[index].incomeDate!.substring(5)}",
                          //     style: TextStyle(
                          //       //fontWeight: FontWeight.w500,
                          //       fontSize: 15,
                          //       //color: Colors.orange
                          //     )),
                          Text("$incomeType",
                              style: TextStyle(
                                //fontWeight: FontWeight.w500,
                                fontSize: 15, 
                                //color: Colors.orange
                              ),
                              textAlign: TextAlign.left,
                              ),
                             
                          Text("${_incomeList[index].amountEarned}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green))
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54)),
                    Text("$_totalncome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange))
                  ],
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 12,
              ),
              Text("Expenses",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.orange)),
              Divider(
                thickness: 1,
              ),
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _expenseList.length,
                  itemBuilder: (BuildContext context, index) {
                    var expenseType = _expenseList[index].expenseType == "Category Expense" ?
                    _expenseList[index].selectedValueExpenseCategory : _expenseList[index].expenseType == 
                    "Other (specify)" ? _expenseList[index].otherExpense : _expenseList[index].expenseType;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$expenseType",
                              style: TextStyle(
                                //fontWeight: FontWeight.w500,
                                fontSize: 15,
                                //color: Colors.orange
                              )),
                          Text("${_expenseList[index].amountSpent}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green))
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54)),
                    Text("$_totalExpense",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 3,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Net:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54)),
                    Text("${_totalncome - _totalExpense}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange))
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
