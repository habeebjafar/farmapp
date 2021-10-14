import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/pages/cattle_page.dart';
import 'package:farmapp/services/cattle_breed_service.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CattleFormPage extends StatefulWidget {
  @override
  _CattleFormPageState createState() => _CattleFormPageState();
}

class _CattleFormPageState extends State<CattleFormPage> {
  var _categories = <DropdownMenuItem>[];

  @override
  void initState() {
    super.initState();
    _getAllCattleBreed();
    _loadCategories();
  }

  var response;

  _getAllCattleBreed() async {
    CattleBreedService service = CattleBreedService();
    response = await service.getAllTCattleBreeds();
  }

  TextEditingController cattleNameController = TextEditingController();
  TextEditingController cattleTagNoController = TextEditingController();
  TextEditingController cattleWeightController = TextEditingController();
  TextEditingController cattleDOBController = TextEditingController();
  TextEditingController cattleDOEController = TextEditingController();
  TextEditingController cattleMotherTagNoController = TextEditingController();
  TextEditingController cattleFatherTagNoController = TextEditingController();
  TextEditingController cattleNotesController = TextEditingController();
  TextEditingController sourceOfCattleController = TextEditingController();

  CattleService _cattleService = CattleService();
  List<String> mylist = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    // CattleBreedService service = CattleBreedService();
    //  var response =  service.getAllTCattleBreeds();

    //   response.forEach((category){

    //   setState(() {
    //     response.add(DropdownMenuItem(child: Text(category['cattleBreed']), value: Text(category['cattleBreed']),));

    //   });

    // });

    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("--Select the cattle's breed--"),
          value: "--Select the cattle's breed--"),
      DropdownMenuItem(child: Text("Friesian"), value: "Friesian"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("Zoto"), value: "Zoto"),
      DropdownMenuItem(
          child: Text("Other (specify)"), value: "Other (specify)"),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsTwo {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Select Gender. *"), value: "Select Gender. *"),
      DropdownMenuItem(child: Text("Male"), value: "Male"),
      DropdownMenuItem(child: Text("Female"), value: "Female"),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsObtainMethod {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Select how cattle was obtained. *"),
          value: "Select how cattle was obtained. *"),
      DropdownMenuItem(child: Text("Born of farm"), value: "Born of farm"),
      DropdownMenuItem(child: Text("Purchased"), value: "Purchased"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];

    return menuItems;
  }

  //String cattleStageThree = "";
  //String cattleStageFour = "";

  String selectedValue = "--Select the cattle's breed--";
  String selectedValueTwo = "Select Gender. *";
  String selectedValueObtainMethod = "Select how cattle was obtained. *";
  String selectedValueCattleStage  = "-Select cattle stage";
  String selectedValueCattleStageThree  = "-Select cattle stage.-";
  String selectedValueCattleStageFour  = "-Select cattle stage-";

  List<DropdownMenuItem<String>> menuItemsStage3 = [
    DropdownMenuItem(
        child: Text("-Select cattle stage-"), value: "-Select cattle stage.-"),
    DropdownMenuItem(child: Text("Calf"), value: "Calf"),
    DropdownMenuItem(child: Text("Weaner"), value: "Weaner"),
    DropdownMenuItem(child: Text("Steer"), value: "Steer"),
    DropdownMenuItem(child: Text("Bull"), value: "Bull"),
  ];

  List<DropdownMenuItem<String>> menuItemsStage4 = [
    DropdownMenuItem(
        child: Text("-Select cattle stage-"), value: "-Select cattle stage-"),
    DropdownMenuItem(child: Text("Calf"), value: "Calf"),
    DropdownMenuItem(child: Text("Weaner"), value: "Weaner"),
    DropdownMenuItem(child: Text("Heifer"), value: "Heifer"),
    DropdownMenuItem(child: Text("Cow"), value: "Cow"),
  ];

  List<DropdownMenuItem<String>> get dropdownItemsCattleStage {
    // if (selectedValueTwo == "Male") {
    //                 cattleStageThree = "Steer";
    //                 cattleStageFour = "Bull";
    //               } else if (selectedValueTwo == "Female") {
    //                 cattleStageThree = "Heifer";
    //                 cattleStageFour = "Cow";
    //               }
    var menuItems;

    setState(() {
      if (selectedValueTwo == "Male") {
        menuItems = menuItemsStage3;
      } else if (selectedValueTwo == "Female") {
        menuItems = menuItemsStage4;
      }
    });

    return menuItems;
  }



 // var _cattleBreedList = <DropdownMenuItem>[];

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
          cattleDOBController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
        } else {
          cattleDOEController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
        }
      });
    }
  }

  _saveCattle() async {
    var model = CattleModel();
    model.cattleBreed = selectedValue.toString();
    model.cattleName = cattleNameController.text;
    model.cattleTagNo = cattleTagNoController.text;
    model.cattleGender = selectedValueTwo.toString();
    model.cattleStage = selectedValueCattleStage.toString();
    model.cattleWeight = cattleWeightController.text;
    model.cattleDOB = cattleDOBController.text;
    model.cattleDOE = cattleDOEController.text;
    model.cattleObtainMethod = selectedValueObtainMethod == "Other"
        ? sourceOfCattleController.text
        : selectedValueObtainMethod.toString();
    model.cattleMotherTagNo = cattleMotherTagNoController.text;
    model.cattleFatherTagNo = cattleFatherTagNoController.text;
    model.cattleNote = cattleNotesController.text;

    var response = await _cattleService.saveCattle(model);

    if (response > 0) {
      print("added successfully $response");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => CattlePage()));
    } else {
      print("no value added");
    }
  }

  _loadCategories() async {
    CattleBreedService service = CattleBreedService();

    var response = await service.getAllTCattleBreeds();

    response.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['cattleBreed']),
          value: Text(category['cattleBreed']),
        ));
      });
    });
  }

  String dropdownvalue = 'Apple';
  List<String> items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Cattle"),
        actions: [
          IconButton(
              onPressed: () {
                _saveCattle();
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

            // DropdownButton(
            //   style: TextStyle(),
            //   value: dropdownvalue,
            //   icon: Icon(Icons.keyboard_arrow_down),
            //   items: items.map((String items) {
            //     return DropdownMenuItem(value: items, child: Text(items));
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       dropdownvalue = newValue!;
            //     });
            //   },
            // ),

            //  DropdownButtonFormField(
            //     value: _selectedValue,
            //     items: _categories,
            //     hint:Text("Select one category") ,
            //     onChanged: (value){
            //       setState(() {
            //         _selectedValue = value;
            //       });

            //     },

            //   ),

            DropdownButtonFormField(
                // decoration: InputDecoration(
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blue, width: 2),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blue, width: 2),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   //filled: true,
                //   //fillColor: Colors.blueAccent,
                // ),

                style: TextStyle(fontSize: 16.0, color: Colors.black),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //hintText: "Cattle name. *",
                    //labelText: "--Select the cattle's breed--",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems),

            SizedBox(
              height: 20,
            ),

            // DropdownButtonFormField(
            //   value: _selectedValue,
            //   items: _cattleBreedList,
            //   hint: Text("Select one category"),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedValue = value;
            //     });
            //   },
            //   decoration: InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //       //hintText: "Cattle name. *",
            //       labelText: "Select the cattle's breed. *",
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5.0))),
            // ),

            // TextField(
            //   controller: cattleBreedController,
            //   style: TextStyle(fontSize: 20.0),
            //   decoration: InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //       //hintText: "Cattle name. *",
            //       labelText: "Select the cattle's breed. *",
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5.0))),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            TextField(
              controller: cattleNameController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Cattle name. *",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: cattleTagNoController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Tag No. *",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
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
                    //labelText: "Select Gender. *",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValueTwo,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueTwo = newValue!;
                    if(selectedValueTwo == "Male"){
                       selectedValueCattleStage = selectedValueCattleStageThree;

                    }else if(selectedValueTwo == "Female"){
                       selectedValueCattleStage = selectedValueCattleStageFour;

                    }
                   
                  });
                },
                items: dropdownItemsTwo),

            selectedValueTwo == "Select Gender. *"
                ? Container()
                : SizedBox(
                    height: 20,
                  ),

            selectedValueTwo == "Select Gender. *"
                ? Container()
                : DropdownButtonFormField(
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        //hintText: "Cattle name. *",
                        //labelText: "Select Gender. *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //dropdownColor: Colors.blueAccent,
                    value: selectedValueCattleStage,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValueCattleStage = newValue!;
                      });
                    },
                    items: dropdownItemsCattleStage),

            SizedBox(
              height: 20,
            ),

            TextField(
              controller: cattleWeightController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Weight",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: cattleDOBController,
              onTap: () {
                _selectTodoDate(context, 1);
              },
              readOnly: true,
              autofocus: false,
              // enabled: false,
              decoration: InputDecoration(
                  //hintText: 'YY-MM-DD',

                  labelText: 'Date of birth',
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
            TextField(
              controller: cattleDOEController,
              onTap: () {
                _selectTodoDate(context, 0);
              },
              readOnly: true,
              autofocus: false,
              // enabled: false,
              decoration: InputDecoration(
                  //hintText: 'YY-MM-DD',

                  labelText: 'Date of entry on the farm',
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
                    //labelText: "Select Gender. *",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                //dropdownColor: Colors.blueAccent,
                value: selectedValueObtainMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueObtainMethod = newValue!;
                  });
                },
                items: dropdownItemsObtainMethod),

            SizedBox(
              height: 20,
            ),

            selectedValueObtainMethod == "Other"
                ? TextField(
                    controller: sourceOfCattleController,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        //hintText: "Cattle name. *",
                        labelText: "Specify the source of cattle. *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )
                : Container(),
            selectedValueObtainMethod == "Other"
                ? SizedBox(
                    height: 20,
                  )
                : Container(),

            TextField(
              controller: cattleMotherTagNoController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Mother's Tag No.",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: cattleFatherTagNoController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Father's Tag No.",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: cattleNotesController,
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
