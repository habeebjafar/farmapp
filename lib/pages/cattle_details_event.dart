import 'package:farmapp/pages/individual_event_form.dart';
import 'package:farmapp/provider/cattle_provider.dart';
import 'package:farmapp/provider/events_provider.dart';
import 'package:farmapp/services/event_individual_service.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CattleDetailsEvent extends StatefulWidget {
  final int index;

  CattleDetailsEvent(this.index);
  @override
  _CattleDetailsEventState createState() => _CattleDetailsEventState();
}

class _CattleDetailsEventState extends State<CattleDetailsEvent> {
  var provider;
  var eventProvider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<CattleProvider>(context, listen: false);
    provider.getCattleById(this.widget.index);
    eventProvider = Provider.of<EventsProvider>(context, listen: false);
    eventProvider.getAllIndividualEventRecord(cattleId: this.widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: eventProvider.getAllIndividualEventRecord(
              cattleId: this.widget.index),
          builder: (BuildContext context, snapShot) {
            var dob = DateFormat('yyyy MMM, dd').format(
                DateTime.parse("${provider.singleCattle[0]['cattleDOB']}"));
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // if (eventProvider.individualEventsList.length == 0) {
              //   return Container(
              //     child: Text("No data"),
              //   );
              // }

              return Consumer<EventsProvider>(
                builder: (_, eventProvider, __) =>  eventProvider.individualEventsList.length == 0 ? Center(
          child: Text("No event recorded yet!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange
          ),)
        ) : ListView.builder(
                    padding: EdgeInsets.only(bottom: 70),
                    itemCount: eventProvider.individualEventsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String med = eventProvider
                          .individualEventsList[index].eventType
                          .toString();
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
                                            "${med == 'Other' ? eventProvider.individualEventsList[index].nameOfMedicine : eventProvider.individualEventsList[index].eventType}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      popupMenuWidget(
                                          index,
                                          eventProvider
                                              .individualEventsList[index].id)
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
                                      "${eventProvider.individualEventsList[index].eventDate}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Tag No:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text(
                                      "${provider.singleCattle[0]['cattleTagNo']}",
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
                                            "${eventProvider.individualEventsList[index].nameOfMedicine}",
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
                                        "${eventProvider.individualEventsList[index].eventNotes}",
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IndividualEventForm(index: this.widget.index)));
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
                      builder: (context) => IndividualEventForm(
                          index: this.widget.index, eventIndex: index)));
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
                    
                    EventIndividualService service = EventIndividualService();
                    var response = await service.deleteEventById(id);

                    if (response > 0) {
                      print("successfully deleted");
                      await Provider.of<EventsProvider>(context, listen: false)
                          .getAllIndividualEventRecord( cattleId: this.widget.index);
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
              title: Text("Deleting event!"),
              content: Text(
                  "Deleting this event will not revert any changes to the cattle's stage and status. Click delete to continue."));
        });
  }
}
