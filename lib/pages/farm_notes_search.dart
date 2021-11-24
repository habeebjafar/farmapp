import 'package:farmapp/models/farm_note_model.dart';
import 'package:farmapp/pages/farm_notes_form.dart';
import 'package:farmapp/provider/farm_note_provider.dart';
import 'package:farmapp/services/farm_note_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FarmNoteSearch extends StatefulWidget {
  const FarmNoteSearch({Key? key}) : super(key: key);

  @override
  _FarmNoteSearchState createState() => _FarmNoteSearchState();
}

class _FarmNoteSearchState extends State<FarmNoteSearch> {


  FarmNoteService _service = FarmNoteService();
  TextEditingController _farmNoteSearch = TextEditingController();

   @override
  void initState() {
    super.initState();
    // _getAllIncomeCategory();
   

        _getAllFarmNotes();
  }


List<FarmNoteModel> duplicateItems  = [];

  List<FarmNoteModel> items   = [];

  bool? noDataFound;
  
    void filterSearchResults(String query) {
    List<FarmNoteModel> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<FarmNoteModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.title.toString().toLowerCase().contains(query)  || item.message.toString().toLowerCase().contains(query)) {
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



  _getAllFarmNotes() async{
    var response = await _service.getAllFarmNotes();

    response.forEach((data){
     
     setState(() {
        var model = FarmNoteModel();
         model.id = data['id'];
      model.title = data['title'];
       model.message = data['message'];
        model.date = data['date'];

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
      body:  noDataFound == true ? Center(
          child: Text("No Data matches your search!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) :  ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, index) {
                        var date = DateFormat('dd MMM, yyyy (hh:mm)').format(
                            DateTime.parse(
                                "${items[index].date}"));
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FarmNoteForm(index: index)));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    top: 10,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        "${items[index].title!.substring(0, 1).toUpperCase()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 58, bottom: 15, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${items[index].title}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  date,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.orange),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FarmNoteForm(
                                                                      index:
                                                                          index)));
                                                    },
                                                    child: Icon(
                                                      Icons.message,
                                                      color: Colors.grey,
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                 popupMenuWidget(items[index].id, index)
                                               
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Container(
                                        //   width: 300,
                                        //   child: Divider(thickness: 0.5, height: 0.5, color: Colors.black,)) ,
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${items[index].message}",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FarmNoteForm()));
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.note_add_outlined),
      ),
    );
  }

  Widget popupMenuWidget(id, index) {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FarmNoteForm(index: index)));
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
    var farmNoteProvider =
        Provider.of<FarmNoteProvider>(context, listen: false);
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
                    var result = await farmNoteProvider.deleteFarmNoteById(id);
                    if (result) {
                      await farmNoteProvider.getAllFarmNotes();
                      Navigator.pop(context);
                    }
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
