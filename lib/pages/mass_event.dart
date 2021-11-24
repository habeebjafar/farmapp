import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/pages/mass_event_form.dart';
import 'package:farmapp/pages/milk_record_form_page.dart';
import 'package:farmapp/provider/events_provider.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:farmapp/services/event_service.dart';
import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MassEvent extends StatefulWidget {
  @override
  _MassEventState createState() => _MassEventState();
}

class _MassEventState extends State<MassEvent> {
 // EventService _eventService = EventService();
 // List<EventModel> _list = [];
  var eventProvider;

  @override
  void initState() {
    super.initState();

    eventProvider = Provider.of<EventsProvider>(context, listen: false);

    eventProvider.getAllMassEventRecord(getAll: "All");
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: eventProvider.getAllMassEventRecord(getAll: "All"),
          builder: (BuildContext context, snapShot) {
            // var dob = DateFormat('yyyy MMM, dd').format(
            //     DateTime.parse("${provider.singleCattle[0]['cattleDOB']}"));
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // if (eventProvider.massEventsList.length == 0) {
              //   return Container(
              //     child: Text("No data"),
              //   );
              // }

              return Consumer<EventsProvider>(
                builder: (_, eventProvider, __) =>  eventProvider.massEventsList.length == 0 ? Center(
          child: Text("No event recorded yet!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : ListView.builder(
                    padding: EdgeInsets.only(bottom: 70),
                    itemCount: eventProvider.massEventsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String med = eventProvider.massEventsList[index].eventType.toString();
                      var date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(
                    "${eventProvider.massEventsList[index].eventDate.toString()}"));
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(2, 7, 0, 7),
                                  width: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.multitrack_audio_outlined,
                                            color: Colors.white70,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${med == 'Other' ? eventProvider.massEventsList[index].nameOfMedicine : eventProvider.massEventsList[index].eventType}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                       popupMenuWidget(index, eventProvider.massEventsList[index].id),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Date:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      "$date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                med == "Vacination/Injection" ||
                                        med == "Deworming" ||
                                        med == "Treatment/Medication"
                                    ? SizedBox(
                                        height: 15,
                                      )
                                    : Container(),
                                med == "Vacination/Injection" ||
                                        med == "Deworming" ||
                                        med == "Treatment/Medication"
                                    ? Row(
                                        children: [
                                          Text(
                                            "Medicine:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Text(
                                            "${eventProvider.massEventsList[index].nameOfMedicine}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16),
                                          )
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Notes:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        "${eventProvider.massEventsList[index].eventNotes}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MassEventForm()));
        },
        child: Container(
          width: 130,
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
                "ADD EVENT",
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

   Widget popupMenuWidget(index, id) {
    var selectedValue;
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: (value) {
          setState(() {
            selectedValue = value as String;

            if (selectedValue == "Edit Event") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MassEventForm(index: index,)));
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
                    print("checking this now $id");
                    
                    EventService service = EventService();
                    var response = await service.deleteEventById(id);

                    if (response > 0) {
                      print("successfully deleted");
                      await Provider.of<EventsProvider>(context, listen: false)
                          .getAllMassEventRecord(getAll: "All");
                    } else {
                      print("successfully failed");
                    }

                    Navigator.pop(context);
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
