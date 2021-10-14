import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/pages/income_form.dart';
import 'package:farmapp/pages/mass_event_form.dart';
import 'package:farmapp/services/event_service.dart';
import 'package:farmapp/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  IncomeService _incomeService = IncomeService();
  List<IncomeModel> _list = [];

  @override
  void initState() {
    super.initState();
    _getAllIncomeRecord();
  }

  _getAllIncomeRecord() async {
    var response = await _incomeService.getAllIncomeRecord();
    print(response);

    response.forEach((data) {
      setState(() {
        var model = IncomeModel();

        model.incomeDate = data['incomeDate'];
        model.incomeType = data['incomeType'];
        model.milkQty = data['milkQty'];
        model.amountEarned = data['amountEarned'];
        model.receiptNo = data['receiptNo'];

        _list.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list.isNotEmpty
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {

                String incomeType = _list[index].incomeType.toString();
                var formatAmountEarned = NumberFormat('#,###.##').format(double.parse("${_list[index].amountEarned.toString()}"));
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
                                        Text("${incomeType == 'Milk Sale' ? incomeType + ' (${_list[index].milkQty})' : incomeType}"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("${_list[index].incomeDate}")
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
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_vert))
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
              })
          : Center(
              child: Text(
                "No income to display.",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
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
}
