import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:flutter/material.dart';

import 'cattle_details_page.dart';
import 'cattle_form_page.dart';

class SearchImplementation extends StatefulWidget {
  const SearchImplementation({ Key? key }) : super(key: key);

  @override
  _SearchImplementationState createState() => _SearchImplementationState();
}

class _SearchImplementationState extends State<SearchImplementation> {

  CattleService _service = CattleService();
  List<CattleModel> duplicateItems  = [];

  List<CattleModel> items   = [];

  bool? noDataFound;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("View Record"), value: "View Record"),
      DropdownMenuItem(child: Text("Edit Record"), value: "Edit Record"),
    ];
    return menuItems;
  }

  String selectedValue = "View Record";



    @override
  void initState() {
    super.initState();
    _getAllCattles(); 
  }

    void filterSearchResults(String query) {
    List<CattleModel> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<CattleModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.cattleName.toString().toLowerCase().contains(query) ||
         item.cattleTagNo.toString().toLowerCase().contains(query) ) {
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



  _getAllCattles() async{
    var response = await _service.getAllTCattles();

    response.forEach((data){
     
     setState(() {
        var model = CattleModel();
        model.id = data['id'];
        model.cattleName = data['cattleName'];
        model.cattleTagNo = data['cattleTagNo'];
        model.cattleGender = data['cattleGender'];

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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CattleDetailsPage(items[index].id!)));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/cowlist.png",
                                            width: 70,
                                            height: 70,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${items[index].cattleTagNo}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${items[index].cattleName}")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Icon(Icons.star_border),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
              
                                              Stack(
                                                children: [
                                                  Container(
                                                    //color: Colors.red,
                                                    // width: 50,
                                                    child: DropdownButton(
                                                        icon:
                                                            Icon(Icons.more_vert),
                                                        //value: selectedValue,
                                                        //itemHeight: 50,
                                                        underline: Container(),
                                                        isExpanded: false,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedValue =
                                                                newValue!;
                                                            if (selectedValue ==
                                                                "View Record") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          CattleDetailsPage(items[index].id!)));
                                                            }
              
                                                            if (selectedValue ==
                                                                "Edit Record") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          CattleFormPage(items[index].id!)));
                                                            }
                                                          });
                                                        },
                                                        items: dropdownItems),
                                                  ),
                                                  Positioned(
                                                    //left: 20,
                                                    top: 13,
                                                    bottom: 10,
                                                    child: Text(
                                                      "${items[index].cattleGender}",
                                                      style:
                                                          TextStyle(fontSize: 18),
                                                    ),
                                                  )
                                                ],
                                              )
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: Icon(Icons.more_vert)
                                              //     )
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
                     floatingActionButton: GestureDetector(
        onTap: () {
         
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CattleFormPage(-1)));
                   
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


}