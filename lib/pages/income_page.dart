import 'package:farmapp/pages/income_form.dart';
import 'package:farmapp/provider/transactions_provider.dart';
import 'package:farmapp/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {


  @override
  void initState() {
    super.initState();
    Provider.of<TransactionsProvider>(context, listen: false).getAllIncomeRecord();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionsProvider> (
        builder: (_, provider, __) =>  provider.incomeList.length == 0 ? Center(
          child: Text("No income recorded yet!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.incomeList.length,
                    itemBuilder: (BuildContext context, int index) {
        
                      String incomeType = provider.incomeList[index].incomeType.toString();
                      var formatAmountEarned = NumberFormat('#,###.00').format(num.parse("${provider.incomeList[index].amountEarned.toString()}"));
                       var date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(
                    "${provider.incomeList[index].incomeDate.toString()}"));
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
                                              Text("${incomeType == 'Milk Sale' ? incomeType + ' (${provider.incomeList[index].milkQty})' :
                                                incomeType == 'Category Income' ?  provider.incomeList[index].selectedValueIncomeCategory : 
                                                incomeType == 'Other (specify)' ?  provider.incomeList[index].otherSource : '' }",
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
                                              popupMenuWidget(index, provider.incomeList[index].id)
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
              context, MaterialPageRoute(builder: (context) => IncomeForm()));
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
                "INCOME",
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
                      builder: (context) => IncomeForm(index: index,)));
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
                    
                    IncomeService service = IncomeService();
                    var response = await service.deleteSaveById(id);

                    if (response > 0) {
                      print("successfully deleted");
                      await Provider.of<TransactionsProvider>(context, listen: false)
                          .getAllIncomeRecord();
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
              title: Text("Deleting Cattle!"),
              content: Text(
                  "This cattle will be deleted completely from the app. This will also permanently delete all records such milk, events, expenses and revenue attached to this cattle!"));
        });
  }
}
