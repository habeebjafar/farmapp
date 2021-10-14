import 'package:farmapp/models/cattle_breed_model.dart';
import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/pages/cattle_form_page.dart';
import 'package:farmapp/services/cattle_breed_service.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:flutter/material.dart';

class CattleBreedPage extends StatefulWidget {
  @override
  _CattleBreedPageState createState() => _CattleBreedPageState();
}

class _CattleBreedPageState extends State<CattleBreedPage> {
  CattleService _cattleService = CattleService();
  List<CattleModel> _list = [];

  TextEditingController  _cattleBreedName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllCattles();
  }

  _getAllCattles() async {
    var response = await _cattleService.getAllTCattles();
     print(response);

    response.forEach((data) {
      setState(() {
        var model = CattleModel();
        model.cattleName = data['cattleName'];
        model.cattleTagNo = data['cattleTagNo'];
        model.cattleGender = data['cattleGender'];
        model.cattleBreed = data['cattleBreed'];
        model.cattleWeight = data['cattleWeight'];
        model.cattleDOB = data['cattleDOB'];
        model.cattleDOE = data['cattleDOE'];
        model.cattleObtainMethod = data['cattleObtainMethod'];
        model.cattleMotherTagNo = data['cattleMotherTagNo'];
        model.cattleFatherTagNo = data['cattleFatherTagNo'];
        model.cattleNote = data['cattleNotes'];
        
        _list.add(model);
      });
    });
  }


   _editCategoryDialog(BuildContext context) {
   return showDialog(context: context, barrierDismissible: true, builder: (param){
     return AlertDialog(
       actions: <Widget>[
         TextButton(
           style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange
                        ),
                  ),
           onPressed:(){
             Navigator.pop(context);
           } ,
           child: Text("CANCEL",
           style: TextStyle(color: Colors.white),),
         ),
         TextButton(
           style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
           onPressed:() async {
             CattleBreedService breedService = CattleBreedService();
             var model = CattleBreedModel();
             model.cattleBreed =  _cattleBreedName.text;
             var response = await breedService.saveCattle(model);
             if(response >0){
               print("added successfully $response");
             }else{
               print("failed");
             }
              Navigator.pop(context);
           } ,
           child: Text("ADD",
           style: TextStyle(color: Colors.white),),
         ),
       ],
       title: Text("New Breed"), content: SingleChildScrollView(
       child: Column(
         children: <Widget>[
           TextField(
             controller: _cattleBreedName,
               style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  //hintText: "Cattle name. *",
                  labelText: "Enter breed name ...",
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
      appBar: AppBar(
        title: Text("Cattle Breeds"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 0, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_list[index].cattleBreed}",
                              style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("(2) Cattle")
                            ],
                          ),
                   
                           
                  Icon(Icons.more_vert)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      // Center(
      //   child: Text(
      //     "No cattle have been registered yet!",
      //     style: TextStyle(
      //       color: Colors.orange,
      //       fontSize: 18
      //     ),
      //     ),
      // ),
      floatingActionButton: GestureDetector(
        onTap: () {
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
}
