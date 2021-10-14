import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/event_individual_model.dart';
import 'package:farmapp/pages/cattle_details_page.dart';
import 'package:farmapp/services/event_individual_service.dart';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndividualEventForm extends StatefulWidget {
  final List<CattleModel> _list;
  final int index;

  IndividualEventForm(this._list, this.index);

  @override
  _IndividualEventFormState createState() => _IndividualEventFormState();
}

class _IndividualEventFormState extends State<IndividualEventForm> {
  @override
  void initState() {
    super.initState();
     print(" this is the id  ${this.widget._list[this.widget.index].cattleTagNo.toString()}");
    
  }



  

  TextEditingController eventDateController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TextEditingController nameOfMedicineController = TextEditingController();
  String selectedValue = "Select event type. *";

  EventIndividualService _eventService = EventIndividualService();
  
  //List<String> mylist = [];

  String otherLabel = "Name of medicine given.*";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Select event type. *"), value: "Select event type. *"),
      DropdownMenuItem(
          child: Text("Vacination/Injection"), value: "Vacination/Injection"),
      DropdownMenuItem(child: Text("Herd spraying"), value: "Herd Spraying"),
      DropdownMenuItem(child: Text("Deworming"), value: "Deworming"),
      DropdownMenuItem(
          child: Text("Treatment/Medication"), value: "Treatment/Medication"),
      DropdownMenuItem(child: Text("Hoof Trimming"), value: "Hoof Trimming"),
      DropdownMenuItem(child: Text("Tagging"), value: "Tagging"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
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
          eventDateController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
        }
      });
    }
  }

  _saveEvent() async {

   
    var eventModel = EventIndividualModel();

    eventModel.eventDate = eventDateController.text;
    eventModel.eventNotes = noteController.text;
    eventModel.eventType = selectedValue.toString();
    eventModel.nameOfMedicine = nameOfMedicineController.text;
    eventModel.cattleId = this.widget._list[this.widget.index].id.toString();
    eventModel.cattleTagNo = this.widget._list[this.widget.index].cattleTagNo.toString();

    var response = await _eventService.saveEvent(eventModel);

    if (response > 0) {
      print("added successfully $response");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => CattleDetailsPage(this.widget._list, this.widget.index)));
    } else {
      print("no value added");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Event"),
        actions: [
          IconButton(
              onPressed: () {
                _saveEvent();
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
              controller: eventDateController,
              onTap: () {
                _selectTodoDate(context, 1);
              },
              readOnly: true,
              autofocus: false,
              // enabled: false,
              decoration: InputDecoration(
                  //hintText: 'YY-MM-DD',

                  labelText: 'Event date.*',
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
                    //labelText: "-Select milk type-*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    if (selectedValue == "Other") {
                      otherLabel = "Name of event. *";
                    } else {
                      otherLabel = "Name of medicine given.*";
                    }
                    print("checking seleced value $selectedValue");
                  });
                },
                items: dropdownItems),
            SizedBox(
              height: 20,
            ),
            selectedValue == "Vacination/Injection" ||
                    selectedValue == "Deworming" ||
                    selectedValue == "Treatment/Medication" ||
                    selectedValue == "Other"
                ? TextField(
                    controller: nameOfMedicineController,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        //hintText: "Cattle name. *",
                        labelText: otherLabel,
                        //hintText: "2",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )
                : Container(),
            selectedValue == "Vacination/Injection" ||
                    selectedValue == "Deworming" ||
                    selectedValue == "Treatment/Medication" ||
                    selectedValue == "Other"
                ? SizedBox(
                    height: 20,
                  )
                : Container(),
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
