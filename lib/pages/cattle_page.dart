import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/pages/cattle_details_page.dart';
import 'package:farmapp/pages/cattle_form_page.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:flutter/material.dart';

class CattlePage extends StatefulWidget {
  @override
  _CattlePageState createState() => _CattlePageState();
}

class _CattlePageState extends State<CattlePage> {
  CattleService _cattleService = CattleService();
  List<CattleModel> _list = [];

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
        model.cattleStage = data['cattleStage'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cattle"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: _list.isNotEmpty ? ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => CattleDetailsPage(_list, index))
                    );
                },
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${_list[index].cattleTagNo}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${_list[index].cattleName}")
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text(""),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "${_list[index].cattleGender}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Icon(Icons.star_border),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert))
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
          }) :
      Center(
        child: Text(
          "No cattle have been registered yet!",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18
          ),
          ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CattleFormPage()));
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
