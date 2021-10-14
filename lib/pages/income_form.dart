import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/pages/mass_event.dart';
import 'package:farmapp/services/event_service.dart';
import 'package:farmapp/services/income_service.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  @override
  void initState() {
    super.initState();
  
  }

  

  TextEditingController incomeDateController = TextEditingController();
  TextEditingController amountEarnedController = TextEditingController();
  TextEditingController receiptNoController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TextEditingController subOptionController = TextEditingController();

  String selectedValue = "-Select income type-";
  String selectedValueCategory = "Fish farm";

  IncomeService _incomeService = IncomeService();
  //List<String> mylist = [];

  String otherLabel = "Name of medicine given.*";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("-Select income type-"), value: "-Select income type-"),
      DropdownMenuItem(
          child: Text("Milk Sale"), value: "Milk Sale"),
      DropdownMenuItem(child: Text("Catgory Income"), value: "Category Income"),
      DropdownMenuItem(child: Text("Other (specify)"), value: "Other (specify)"),
     
    ];

    return menuItems;
  }

    List<DropdownMenuItem<String>> get dropdownItemsCategory {
    List<DropdownMenuItem<String>> menuItems = [
      // DropdownMenuItem(
      //     child: Text("-Select income type"), value: "-Select income type-"),
      DropdownMenuItem(
          child: Text("Fish farm"), value: "Fish farm"),
      DropdownMenuItem(child: Text("Goat Sale"), value: "Goat Sale"),
      DropdownMenuItem(child: Text("Ram Sale"), value: "Ram Sale"),
     
    ];

    return menuItems;
  }


  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context, int? i) async {
    //mylist.last = "hello";

    var _pickDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (_pickDate != null) {
      setState(() {
        _date = _pickDate;
        if (i == 1) {
          incomeDateController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
        }
      });
    }
  }

  _saveIncome() async {

    var incomeModel = IncomeModel();

    incomeModel.incomeDate = incomeDateController.text;
    incomeModel.incomeNotes = noteController.text;
    incomeModel.incomeType = selectedValue == "Other (specify)" ? subOptionController.text : selectedValue == "Category Income" ? selectedValueCategory : selectedValue.toString();
    incomeModel.milkQty = selectedValue == "Milk Sale" ? subOptionController.text : "";
    incomeModel.receiptNo = receiptNoController.text;
    incomeModel.amountEarned = amountEarnedController.text;
    

    var response = await _incomeService.saveIncome(incomeModel);

    if (response > 0) {
      print("added successfully $response");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => MassEvent()));
    } else {
      print("no value added");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Income"),
        actions: [
          IconButton(
              onPressed: () {
                _saveIncome();
              },
              icon: Icon(
                Icons.gpp_good,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: incomeDateController,
              onTap: () {
                _selectTodoDate(context, 1);
              },
              readOnly: true,
              autofocus: false,
              // enabled: false,
              decoration: InputDecoration(
                  //hintText: 'YY-MM-DD',

                  labelText: 'Date of Income.*',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  prefixIcon: InkWell(
                      onTap: () {
                        //  _selectTodoDate(context);
                      },
                      child: Icon(Icons.calendar_today))),
            ),
            SizedBox(
              height: 20,
            ),

              DropdownButtonFormField(
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //hintText: "Cattle name. *",
                   // labelText: "-Select milk type-*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    if(selectedValue == "Milk Sale"){
                      otherLabel = "Milk quantity sold. *";
                    }else if(selectedValue == "Other (specify)"){
                      otherLabel = "Please specify the source of income.";
                    }
                    // print("checking seleced value $selectedValue");
                  });
                },
                items: dropdownItems),
            SizedBox(
              height: 20,
            ),



           selectedValue == "Category Income" ? DropdownButtonFormField(
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //hintText: "Cattle name. *",
                   // labelText: "-Select milk type-*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValueCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueCategory = newValue!;
                   
                    // print("checking seleced value $selectedValue");
                  });
                },
                items: dropdownItemsCategory) : Container(),

           selectedValue == "Category Income" ? SizedBox(
              height: 20,
            ) : Container(),

             selectedValue == "Milk Sale" || selectedValue == "Other (specify)" 
               ? TextField(
                    controller: subOptionController,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        //hintText: "Cattle name. *",
                        labelText: otherLabel,
                        //hintText: "2",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ) : Container(),
                
            selectedValue == "Milk Sale" || selectedValue == "Other (specify)"  

            ? SizedBox(
              height: 20,
            ) : Container(),

             TextField(
              controller: amountEarnedController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "How much did you earn?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),


             TextField(
              controller: receiptNoController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Receipt No. (Option)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),

            TextField(
              controller: noteController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Write some notes ...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
