import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/models/event_individual_model.dart';
import 'package:farmapp/models/event_model.dart';

import 'package:farmapp/pages/individual_event_form.dart';
import 'package:farmapp/services/event_individual_service.dart';

import 'package:farmapp/services/event_service.dart';

import 'package:flutter/material.dart';

class CattleDetailsEvent extends StatefulWidget {
  final List<CattleModel> _list;
  final int index;

  CattleDetailsEvent(this._list, this.index);
  @override
  _CattleDetailsEventState createState() => _CattleDetailsEventState();
}

class _CattleDetailsEventState extends State<CattleDetailsEvent> {
  EventIndividualService _eventService = EventIndividualService();
  List<EventIndividualModel> _list = [];
  List<EventIndividualModel> _listSearch = [];

  @override
  void initState() {
    super.initState();
    _getAllIndividualEventRecord();
    //_searchResearch();
  }

  _getAllIndividualEventRecord() async {
    var response = await _eventService.getAllEventRecord();
    print(response);

    response.forEach((data) {
      setState(() {
        var model = EventIndividualModel();

        model.cattleId = data['cattleId'];
        model.eventDate = data['eventDate'];
        model.eventType = data['eventType'];
        model.nameOfMedicine = data['nameOfMedicine'];
        model.eventNotes = data['eventNotes'];
        model.cattleTagNo = data['cattleTagNo'];

        _list.add(model);

        var searchTag = model.cattleTagNo.toString();
      
        if (searchTag ==
            this.widget._list[this.widget.index].cattleTagNo.toString()) {
          _listSearch.add(model);
        }
      });
    });

  
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listSearch.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(bottom: 70),
              itemCount: _listSearch.length,
              itemBuilder: (BuildContext context, int index) {
                String med = _listSearch[index].eventType.toString();
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
                                    Icon(
                                      Icons.multitrack_audio_outlined,
                                      color: Colors.white70,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${med == 'Other' ? _listSearch[index].nameOfMedicine : _listSearch[index].eventType}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                )
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
                                "${_listSearch[index].eventDate}",
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
                                width: 80,
                              ),
                              Text(
                                "${_listSearch[index].cattleTagNo}",
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
                                      "${_listSearch[index].nameOfMedicine}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
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
                                  "${_listSearch[index].eventNotes}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
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
              context,
              MaterialPageRoute(
                  builder: (context) => IndividualEventForm(
                      this.widget._list, this.widget.index)));
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
