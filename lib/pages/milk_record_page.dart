import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/pages/milk_record_form_page.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/material.dart';

class MilkRecordPage extends StatefulWidget {
  @override
  _MilkRecordPageState createState() => _MilkRecordPageState();
}

class _MilkRecordPageState extends State<MilkRecordPage> {
  MilkService _milkService = MilkService();
  List<MilkModel> _list = [];

  @override
  void initState() {
    super.initState();
    _getAllMilkRecord();
  }

  _getAllMilkRecord() async {
    var response = await _milkService.getAllMilkRecord();
    print(response);

    response.forEach((data) {
      setState(() {
        var model = MilkModel();

        model.milkDate = data['milkDate'];
        model.milkType = data['milkType'];
        model.milkTotalUsed = data['milkTotalUsed'];
        model.milkTotalProduced = data['milkTotalProduced'];
        model.cowMilked = data['cowMilked'];
        model.noOfCattleMilked = data['noOfCattleMilked'];

        _list.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milk Records"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: _list.isNotEmpty
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                double result = double.parse(_list[index].milkTotalProduced.toString()) - double.parse(_list[index].milkTotalUsed.toString());
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 3, 0, 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_list[index].milkType == 'Individual Milk' ? _list[index].cowMilked : _list[index].milkType}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        //color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "${_list[index].milkDate}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_list[index].milkTotalProduced}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("Total")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_list[index].milkTotalUsed}",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("Used")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(""),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("")
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "$result",
                                style: TextStyle(
                                    color: result > 0 ? Theme.of(context).primaryColor : Colors.red, 
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                    ),
                                ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.more_vert)
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No milk records entered yet!",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MilkFormPage()));
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
                "ADD MILK",
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
