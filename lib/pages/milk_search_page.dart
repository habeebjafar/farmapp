import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/pages/milk_record_form_page.dart';
import 'package:farmapp/provider/milk_provider.dart';
import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MilkSearchPage extends StatefulWidget {
  @override
  _MilkSearchPageState createState() => _MilkSearchPageState();
}

class _MilkSearchPageState extends State<MilkSearchPage> {
  MilkService _service = MilkService();
  double leastProductive = 0.0;
  double highestProductive = 0.0;


   List<MilkModel> duplicateItems  = [];

  List<MilkModel> items   = [];

  bool? noDataFound;

   @override
  void initState() {
    super.initState();
      _getAllMilkRecords();
    // _getAllMilkRecord();
  }


  
    void filterSearchResults(String query) {
    List<MilkModel> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<MilkModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.cowMilked.toString().toLowerCase().contains(query) ) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        if(items.length == 0 ){
          noDataFound = true;
        }else{
          noDataFound = false;
        }
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
        if(items.length == 0 ){
          noDataFound = true;
        }else{
          noDataFound = false;
        }
      });
    }

  }



  _getAllMilkRecords() async{
    var response = await _service.getAllMilkRecord();

    response.forEach((data){
     
     setState(() {
        var model = MilkModel();
        model.id = data['id'];
         model.milkDate = data['milkDate'];
        model.milkType = data['milkType'];
        model.milkTotalUsed = data['milkTotalUsed'];
        model.milkTotalProduced = data['milkTotalProduced'];
        model.cowMilked = data['cowMilked'];
        model.noOfCattleMilked = data['noOfCattleMilked'];

        duplicateItems.add(model);

     });


    });
     items.addAll(duplicateItems);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  TextField(
        onChanged: (value) {
          filterSearchResults(value);
        },
        cursorColor: Colors.orange,
        //mcursorHeight: 30,
        autofocus: true,
        
        style: TextStyle(
          color: Colors.white
        ),
        
        
        
        decoration: InputDecoration(
            //labelText: "Search",
          
            hintText: "Search...",
            border: InputBorder.none,

            hintStyle: TextStyle(
              color: Colors.white60
            ),
             

                ),
      ),
            ),
      body: noDataFound == true ? Center(
          child: Text("No Data matches your search!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      double result = double.parse(items[index].milkTotalProduced
                              .toString()) -
                          double.parse(items[index].milkTotalUsed
                              .toString());

                              var date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(
                    "${items[index].milkDate.toString()}"));
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(6, 3, 0, 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${items[index].milkType == 'Individual Milk' ? items[index].cowMilked : items[index].milkType}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "$date",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${items[index].milkTotalProduced}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${items[index].milkTotalUsed}",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        color: result > 0
                                            ? Theme.of(context).primaryColor
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  popupMenuWidget(index,
                                      items[index].id)
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
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

  Widget popupMenuWidget(index, id) {
    var selectedValue;
    return PopupMenuButton(
        onSelected: (value) {
          setState(() {
            selectedValue = value as String;

            if (selectedValue == "Edit Record") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MilkFormPage(
                            index: index,
                          )));
            } else if (selectedValue == "Delete") {
              deleteCattleDialog(id);
            }
          });
        },
        itemBuilder: (_) => [
              PopupMenuItem(value: "Edit Record", child: Text("Edit Record")),
              PopupMenuItem(value: "Delete", child: Text("Delete")),
            ]);
  }


  deleteCattleDialog(id) {
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
                    MilkService milkService = MilkService();
                    var response = await milkService.deleteTodoById(id);

                    if (response > 0) {
                      print("successfully deleted");
                      await Provider.of<MilkProvider>(context, listen: false)
                          .getAllMilkRecord();
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
