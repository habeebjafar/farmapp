import 'package:farmapp/pages/expenses_form.dart';
import 'package:farmapp/provider/transactions_provider.dart';
import 'package:farmapp/services/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {


  @override
  void initState() {
    super.initState();
    Provider.of<TransactionsProvider>(context, listen: false).getAllExpensesRecord();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionsProvider>(
        builder: (_, provider, __) => provider.expenseList.length == 0 ? Center(
          child: Text("No expense recorded yet!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) :
         SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.expenseList.length,
                    itemBuilder: (BuildContext context, int index) {
        
                      String expenseType = provider.expenseList[index].expenseType.toString();
                      var formatAmountEarned = NumberFormat('#,###.00').format(num.parse("${provider.expenseList[index].amountSpent.toString()}"));
                       var date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(
                    "${provider.expenseList[index].expenseDate.toString()}"));
                     // var form2 = double.parse(formatAmountEarned);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CattleDetailsPage(_list, index)));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 4,),
                                          
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${
                                                expenseType == 'Category Expense' ?  provider.expenseList[index].selectedValueExpenseCategory : 
                                                expenseType == 'Other (specify)' ?  provider.expenseList[index].otherExpense : '' }",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                                ),),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("$date")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(""),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                "$formatAmountEarned",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0),
                                                child: Icon(Icons.star_border),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              popupMenuWidget(index, provider.expenseList[index].id)
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 60,)
            ],
          ),
        )
        ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ExpensesForm()));
        },
        child: Container(
          width: 130,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow( spreadRadius: 1, color: Colors.grey, )
              // ],
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.add, color: Colors.white),
              Text(
                "EXPENSE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget popupMenuWidget(index, id) {
    var selectedValue;
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        onSelected: (value) {
          setState(() {
            selectedValue = value as String;

            if (selectedValue == "Edit Event") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExpensesForm(index: index,)));
            } else if (selectedValue == "Delete") {
              _deleteEventDialog(id);
            }
          });
        },
        itemBuilder: (_) => [
              PopupMenuItem(value: "Edit Event", child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text("Edit Event"),
              )),
              PopupMenuItem(value: "Delete", child: Padding(
                 padding: const EdgeInsets.only(right: 60),
                child: Text("Delete"),
              )),
            ]);
  }

  _deleteEventDialog(id) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return AlertDialog(
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () async {
                    print("checking this now $id");
                    
                    ExpenseService service = ExpenseService();
                    var response = await service.deleteExpenseById(id);

                    if (response > 0) {
                      print("successfully deleted");
                      await Provider.of<TransactionsProvider>(context, listen: false)
                          .getAllExpensesRecord();
                    } else {
                      print("successfully failed");
                    }

                    Navigator.pop(context);
                  },
                  child: Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              title: Text("Deleting expense!"),
              content: Text(
                  "Are you sure you want to delete this expense?"));
        });
  }
}
