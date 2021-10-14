import 'package:farmapp/pages/individual_event.dart';
import 'package:farmapp/pages/mass_event.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: Colors.black,
            //centerTitle: true,
           // titleSpacing: 0.0,
            toolbarHeight: 100,
            title: Text("Events"),
            bottom: PreferredSize(
              preferredSize: Size.infinite,
              child: Container(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: Colors.orange,
                  //indicatorWeight: 10,
                  //indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.green ,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 8,),
                          Text("INDIVIDUAL",
                         // style: TextStyle( color: Theme.of(context).primaryColor,),
                         )
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(
                            Icons.multitrack_audio_outlined,
                            //color: Colors.white,
                          ),
                          SizedBox(width: 8,),
                          Text("MASS")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [IndividualEvent(), MassEvent()],
          ),
        ),
      ),
    );
  }
}
