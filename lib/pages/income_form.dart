import 'package:farmapp/models/income_category_model.dart';
import 'package:farmapp/pages/income_category_page.dart';
import 'package:farmapp/provider/transactions_provider.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeForm extends StatefulWidget {
  final index;
  IncomeForm({this.index});
  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  var incomeProvider;
  @override
  void initState() {
    super.initState();

    incomeProvider = Provider.of<TransactionsProvider>(context, listen: false);
    incomeProvider.getAllIncomeCategory();
     incomeProvider.selectedValueIncomeCategory = incomeProvider
                            .incomeCategoryNameList.isNotEmpty
                        ? incomeProvider.incomeCategoryNameList.first.toString()
                        : "";
    if (this.widget.index != null) _editValues();
  }

  TextEditingController incomeDateController = TextEditingController();
  TextEditingController amountEarnedController = TextEditingController();
  TextEditingController receiptNoController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TextEditingController subOptionController = TextEditingController();

  String selectedValue = "-Select income type-*";

  String otherLabel = "Milk quatity sold.*";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("-Select income type-*"), value: "-Select income type-*"),
      DropdownMenuItem(child: Text("Milk Sale"), value: "Milk Sale"),
      DropdownMenuItem(child: Text("Catgory Income"), value: "Category Income"),
      DropdownMenuItem(
          child: Text("Other (specify)"), value: "Other (specify)"),
    ];

    return menuItems;
  }
  

   _editValues() {
    var provider = Provider.of<TransactionsProvider>(context, listen: false);
    incomeDateController.text =
        provider.incomeList[this.widget.index].incomeDate.toString();
    noteController.text =
        provider.incomeList[this.widget.index].incomeNotes.toString();
        selectedValue = provider.incomeList[this.widget.index].incomeType.toString();
         
    subOptionController.text = selectedValue == "Milk Sale" ? provider.incomeList[this.widget.index].milkQty.toString()
        : selectedValue == "Other (specify)"  ? provider.incomeList[this.widget.index].otherSource.toString() : "";
    receiptNoController.text =
        provider.incomeList[this.widget.index].receiptNo!;
    amountEarnedController.text = provider.incomeList[this.widget.index].amountEarned!;

    provider.selectedValueIncomeCategory = selectedValue == "Category Income" ? provider.incomeList[this.widget.index].selectedValueIncomeCategory.toString() : "";

    if(selectedValue == "Other (specify)") otherLabel = "Please specify the source of income.";
   
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
          incomeDateController.text =
              DateFormat('yyyy-MM-dd').format(_pickDate);
        }
      });
    }
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate() && !selectedValue.contains("-Select income type-*")) {
      form.save();
      return true;
    }

    final snackBar = SnackBar(
      content: const Text('Please fill all the fields marked with (*)'),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Income"),
        actions: [
          IconButton(
              onPressed: () async {
                if (validateAndSave()) {
                  incomeProvider.saveIncome(
                      incomeDateController.text,
                      noteController.text,
                      selectedValue,
                      selectedValue == "Milk Sale"
                          ? subOptionController.text
                          : "",
                      receiptNoController.text,
                      amountEarnedController.text,
                      selectedValue == "Category Income" ? incomeProvider.selectedValueIncomeCategory : "",
                      selectedValue == "Category Income" ? 
                      incomeProvider.incomeCategoryIdList[incomeProvider.incomeCategoryNameList.indexOf(incomeProvider.selectedValueIncomeCategory)] : "",
                      selectedValue == "Other (specify)" ? subOptionController.text : "",
                      updateId: this.widget.index != null ? incomeProvider.incomeList[this.widget.index].id : null

                      );

                  await incomeProvider.getAllIncomeRecord();
                  Navigator.pop(context);
                }

               // print(incomeProvider.incomeCategoryIdList[incomeProvider.incomeCategoryNameList.indexOf(incomeProvider.selectedValueIncomeCategory)]);
                
              },
              icon: Icon(
                Icons.gpp_good,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: incomeDateController,
                validator: (input) => input!.length < 1 ? "Required" : null,
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
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //hintText: "Cattle name. *",
                      // labelText: "-Select milk type-*",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  //dropdownColor: Colors.blueAccent,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      if (selectedValue == "Milk Sale") {
                        otherLabel = "Milk quantity sold. *";
                      } else if (selectedValue == "Other (specify)") {
                        otherLabel = "Please specify the source of income.";
                      } else if (selectedValue == "Category Income") {
                        incomeProvider.selectedValueIncomeCategory =
                            incomeProvider.incomeCategoryNameList.isNotEmpty
                                ? incomeProvider.incomeCategoryNameList.first
                                    .toString()
                                : "";
                      }
                      // print("checking seleced value $selectedValue");
                    });
                    //  print(provider.incomeCategoryNameList);
                  },
                  items: dropdownItems),
              SizedBox(
                height: 20,
              ),
              selectedValue == "Category Income"
                  ? Row(
                      children: [
                        Expanded(
                          child: FutureBuilder(
                              future: Provider.of<TransactionsProvider>(context,
                                      listen: false)
                                  .getAllIncomeCategory(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<IncomeCategoryModel>>
                                      snapShot) {
                                if (snapShot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    child: Center(
                                        //child: CircularProgressIndicator(),
                                        ),
                                  );
                                } else {
                                 
                                  return Consumer<TransactionsProvider>(
                                    builder: (_, provider, __) => provider.incomeCategoryNameList.length == 0 ?
                                    Container(
                                      child: TextFormField(
                                        enabled: false,
                                        style: TextStyle(fontSize: 20.0),
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              size: 35,
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            //hintText: "Cattle name. *",

                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0))),
                                      ),
                                    ):

                                        DropdownButtonFormField(
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 30,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          //hintText: "Cattle name. *",
                                          // labelText: "-Select milk type-*",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      //dropdownColor: Colors.blueAccent,
                                      value:
                                          provider.selectedValueIncomeCategory,
                                      items: provider.incomeCategoryNameList
                                          .map((String items) {
                                        return DropdownMenuItem(
                                            value: items, child: Text(items));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          provider.selectedValueIncomeCategory =
                                              newValue!;
                                             

                                          // print("checking seleced value $selectedValue");
                                        });
                                      },
                                    ),
                                  );
                                }
                              }),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => IncomeCategoryPage()));
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.add,
                              size: 30,
                            ),
                            radius: 26,
                          ),
                        )
                      ],
                    )
                  : Container(),
              selectedValue == "Category Income"
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
              selectedValue == "Milk Sale" || selectedValue == "Other (specify)"
                  ? TextFormField(
                      controller: subOptionController,
                      keyboardType: selectedValue == "Milk Sale"
                          ? TextInputType.number
                          : TextInputType.text,
                      validator: (input) =>
                          input!.length < 1 ? "Required" : null,
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
              selectedValue == "Milk Sale" || selectedValue == "Other (specify)"
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
              TextFormField(
                controller: amountEarnedController,
                keyboardType: TextInputType.number,
                validator: (input) => input!.length < 1 ? "Required" : null,
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
              TextFormField(
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
              SizedBox(
                child: TextFormField(
                  controller: noteController,
                  maxLines: null,
                  minLines: 4,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //hintText: "Cattle name. *",
                      labelText: "Write some notes ...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
