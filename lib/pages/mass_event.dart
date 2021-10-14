import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/pages/mass_event_form.dart';
import 'package:farmapp/pages/milk_record_form_page.dart';
import 'package:farmapp/services/cattle_service.dart';
import 'package:farmapp/services/event_service.dart';
import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/material.dart';

class MassEvent extends StatefulWidget {
  @override
  _MassEventState createState() => _MassEventState();
}

class _MassEventState extends State<MassEvent> {
 EventService _eventService = EventService();
  List<EventModel> _list = [];

  @override
  void initState() {
    super.initState();
    _getAllEventRecord();
  }

  _getAllEventRecord() async {
    var response = await _eventService.getAllEventRecord();
    print(response);

    response.forEach((data) {
      setState(() {
        var model = EventModel();

        model.eventDate = data['eventDate'];
        model.eventType = data['eventType'];
        model.nameOfMedicine = data['nameOfMedicine'];
        model.eventNotes = data['eventNotes'];

        _list.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: _list.isNotEmpty
          ? ListView.builder(
            padding: EdgeInsets.only(bottom: 50),
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                String med = _list[index].eventType.toString();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.multitrack_audio_outlined,
                                    color: Colors.white70,),
                                    SizedBox(width:10),
                                    Text(
                                      "${med == 'Other' ? _list[index].nameOfMedicine : _list[index].eventType}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                         ),
                                      ),
                                  ],
                                ),
                                Icon(Icons.more_vert,
                                color: Colors.white,)
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            
                            children: [
                              Text("Date:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 80,),
                              Text(
                                "${_list[index].eventDate}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ),

                       med == "Vacination/Injection" || med == "Deworming" || med == "Treatment/Medication" 
                        ? SizedBox(height: 15,) : Container(),
                        med == "Vacination/Injection" || med == "Deworming" || med == "Treatment/Medication" 
                        ? Row(
                            children: [
                              Text("Medicine:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 45,),
                              Text(
                                "${_list[index].nameOfMedicine}",
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                                ),
                                
                                )
                            ],
                          ) : Container(),

                           SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Notes:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18
                                ),
                                ),
                              SizedBox(width: 70,),
                              Container(
                                width: 200,
                                child: Text(
                                  "${_list[index].eventNotes}",
                                  style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16
                                  ),
                                  
                                  ),
                              )
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No milk records entered yet!",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MassEventForm()));
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
}
