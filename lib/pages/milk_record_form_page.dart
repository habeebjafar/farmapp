import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/milk_model.dart';

import 'package:farmapp/pages/milk_record_page.dart';
import 'package:farmapp/services/cattle_breed_service.dart';

import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MilkFormPage extends StatefulWidget {
  @override
  _MilkFormPageState createState() => _MilkFormPageState();
}

class _MilkFormPageState extends State<MilkFormPage> {
 

  @override
  void initState() {
    super.initState();
    _getAllCattleBreed();
    noOfCattleMilkedController.text = "1";
  }

  var response;

  _getAllCattleBreed() async {
    CattleBreedService service = CattleBreedService();
    response = await service.getAllTCattleBreeds();
  }

  TextEditingController milkingDateController = TextEditingController();
  TextEditingController totalMilkProducedController = TextEditingController();
  TextEditingController totalMilkUsedController = TextEditingController();
  TextEditingController noOfCattleMilkedController = TextEditingController();
  String selectedValue = "-Select milk type-";
  String selectedCowValue = "-Select cow milked-";
 
  

  

  

    MilkService _milkService = MilkService();
  //List<String> mylist = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("-Select milk type-"),
          value: "-Select milk type-"),
      DropdownMenuItem(child: Text("Bulk Milk"), value: "Bulk Milk"),
      DropdownMenuItem(child: Text("Individual Milk"), value: "Individual Milk"),
     
     
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("-Select cow milked-*"),
          value: "-Select cow milked-"),
      DropdownMenuItem(child: Text("Bully"), value: "Bully"),
      DropdownMenuItem(child: Text("Brandy"), value: "Brandy"),
     
     
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
          milkingDateController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
        } 
      });
    }
  }

  _saveMilk() async {
    var milkModel = MilkModel();
    milkModel.milkDate = milkingDateController.text;
    milkModel.milkTotalUsed = totalMilkUsedController.text;
    milkModel.milkTotalProduced = totalMilkProducedController.text;
    milkModel.milkType = selectedValue.toString();
    milkModel.cowMilked = selectedValue == "Individual Milk" ? selectedCowValue.toString() : "";
    milkModel.noOfCattleMilked = selectedValue == "Bulk Milk" ? noOfCattleMilkedController.text : "";
  

    var response = await _milkService.saveMilk(milkModel);

    if (response > 0) {
      print("added successfully $response");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MilkRecordPage()));
    } else {
      print("no value added");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Milk Record"),
        actions: [
          IconButton(
              onPressed: () {
                _saveMilk();
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
              controller: milkingDateController,
              onTap: () {
                _selectTodoDate(context, 1);
              },
              readOnly: true,
              autofocus: false,
              // enabled: false,
              decoration: InputDecoration(
                  //hintText: 'YY-MM-DD',

                  labelText: 'Milking date.*',
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
                    labelText: "-Select milk type-*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    print("checking seleced value $selectedValue");
                  });
                },
                items: dropdownItems),

            SizedBox(
              height: 20,
            ),

             selectedValue == "Individual Milk" ? DropdownButtonFormField(
               
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //hintText: "Cattle name. *",
                    labelText: "-Select cow milked-*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedCowValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCowValue = newValue!;
                  });
                },
                items: dropdownItems2) : Container(),

            selectedValue == "Individual Milk" ? SizedBox(
              height: 20,
            ) : Container(),
           

            TextField(
              controller: totalMilkProducedController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Total milk produced.*",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),

            TextField(
              controller: totalMilkUsedController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Total used (Calves/consumption).*",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),

             selectedValue == "Bulk Milk" ? TextField(
              controller: noOfCattleMilkedController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Number of cattle milked.*",
                 //hintText: "2",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ) : Container(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
