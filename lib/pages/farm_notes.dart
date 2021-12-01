import 'package:farmapp/pages/farm_notes_form.dart';
import 'package:farmapp/pages/farm_notes_search.dart';
import 'package:farmapp/provider/farm_note_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FarmNote extends StatefulWidget {
  const FarmNote({Key? key}) : super(key: key);

  @override
  _FarmNoteState createState() => _FarmNoteState();
}

class _FarmNoteState extends State<FarmNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Notes"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
              context, MaterialPageRoute(builder: (context) => FarmNoteSearch()));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<FarmNoteProvider>(context, listen: false)
              .getAllFarmNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Consumer<FarmNoteProvider>(
                  builder: (_, provider, __) =>  provider.farmNoteList.length == 0 ? Center(
          child: Text("No note added yet!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : ListView.builder(
                      itemCount: provider.farmNoteList.length,
                      itemBuilder: (BuildContext context, index) {
                        var date = DateFormat('dd MMM, yyyy (hh:mm)').format(
                            DateTime.parse(
                                "${provider.farmNoteList[index].date}"));
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
                                        "${provider.farmNoteList[index].title!.substring(0, 1).toUpperCase()}",
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
                                                  "${provider.farmNoteList[index].title}",
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
                                                 popupMenuWidget(provider.farmNoteList[index].id, index)
                                               
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
                                          "${provider.farmNoteList[index].message}",
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
                      }));
            }
          }),
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
