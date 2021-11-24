import 'package:farmapp/models/income_category_model.dart';
import 'package:farmapp/provider/transactions_provider.dart';

import 'package:farmapp/services/income_category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeCategorySearchPage extends StatefulWidget {
  @override
  _IncomeCategorySearchPageState createState() => _IncomeCategorySearchPageState();
}

class _IncomeCategorySearchPageState extends State<IncomeCategorySearchPage> {
  IncomeCategoryService _service = IncomeCategoryService();
  TextEditingController _incomeCategoryName = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _getAllIncomeCategory();
    Provider.of<TransactionsProvider>(context, listen: false)
        .getAllIncomeCategory();

        _getAllIncomeCategories();
  }




 

List<IncomeCategoryModel> duplicateItems  = [];

  List<IncomeCategoryModel> items   = [];

  bool? noDataFound;
  
    void filterSearchResults(String query) {
    List<IncomeCategoryModel> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<IncomeCategoryModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.incomeCategory.toString().toLowerCase().contains(query) ) {
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



  _getAllIncomeCategories() async{
    var response = await _service.getAllIncomeCategories();

    response.forEach((data){
     
     setState(() {
        var model = IncomeCategoryModel();
         model.id = data['id'];
      model.incomeCategory = data['incomeCategory'];

        duplicateItems.add(model);

     });

    });
     items.addAll(duplicateItems);
  }



  _editCategoryDialog(BuildContext context, {int? id}) {
    var incomeProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                ),
                onPressed: () async {
                  IncomeCategoryService incomeCategoryService =
                      IncomeCategoryService();
                  var model = IncomeCategoryModel();
                  model.incomeCategory = _incomeCategoryName.text;
                  var response;
                  if (id != null) {
                    model.id = id;
                    response =
                        await incomeCategoryService.updateIncomeCategory(model);
                        await incomeProvider.updateIncomeSingleField("incomeCategoryId", "selectedValueIncomeCategory", _incomeCategoryName.text, id);
                  } else {
                    response =
                        await incomeCategoryService.saveIncomeCategory(model);
                  }

                  if (response > 0) {
    
                    await incomeProvider.getAllIncomeCategory();

                    incomeProvider.selectedValueIncomeCategory = incomeProvider
                            .incomeCategoryNameList.isNotEmpty
                        ? incomeProvider.incomeCategoryNameList.first.toString()
                        : "";
                  } else {
                    print("failed");
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text("New Income Category"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _incomeCategoryName,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        //hintText: "Cattle name. *",
                        labelText: "Enter income category ...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ],
              ),
            ),
          );
        });
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
      body:  noDataFound == true ? Center(
          child: Text("No Data matches your search!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : 
          ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${items[index].incomeCategory}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              popupMenuWidget(
                                  items[index].id,
                                  items[index].incomeCategory)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              ),
             
      floatingActionButton: GestureDetector(
        onTap: () {
          _incomeCategoryName.clear();
          _editCategoryDialog(context);
        },
        child: Container(
          width: 110,
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
                "ADD",
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

  Widget popupMenuWidget(id, incomeName) {
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
              _incomeCategoryName.text = incomeName;

              _editCategoryDialog(context, id: id);
            } else if (selectedValue == "Delete") {
              _deleteEventDialog(id);
            }
          });
        },
        itemBuilder: (_) => [
              PopupMenuItem(value: "Edit Event", child: Text("Edit Event")),
              PopupMenuItem(value: "Delete", child: Text("Delete")),
            ]);
  }

  _deleteEventDialog(id) {
    var incomeProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
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
                    
                    await incomeProvider.deleteIncomeCategoryById(id);

                    
                      await incomeProvider.getAllIncomeCategory();
                      incomeProvider.selectedValueIncomeCategory =
                          incomeProvider.incomeCategoryNameList.isNotEmpty
                              ? incomeProvider.incomeCategoryNameList.first
                                  .toString()
                              : "";
                    

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
