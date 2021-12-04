import 'package:farmapp/pages/individual_event.dart';
import 'package:farmapp/pages/mass_event.dart';
import 'package:farmapp/pages/mass_event_form.dart';
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
           actions: [
             popupMenuWidget()
           ],
            toolbarHeight: 100,
            title: Text("Events"),
            bottom: PreferredSize(
              preferredSize: Size.zero,
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
   Widget popupMenuWidget() {
     String getSelectedValue = "";
     return PopupMenuButton(
       onSelected: (value){
         setState(() {
           getSelectedValue = value as String;
           if(getSelectedValue == "New Mass Event"){
             Navigator.push(context, 
             MaterialPageRoute(builder: (context) => MassEventForm()));

           } else if(getSelectedValue == "New Individual Event"){

               final snackBar = SnackBar(
      content: const Text('Individual events are added from the cattle details page!'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

           }
         });

       },
       itemBuilder: (_) => [

         PopupMenuItem(
          value: "New Mass Event",
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.multitrack_audio_outlined,
                color: Colors.orange,
              ),
              SizedBox(
                width: 15,
              ),
              Text("New Mass Event"),
              
            ],
          ),
        ),
        PopupMenuItem(
          value: "New Individual Event",
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.orange,
              ),
              SizedBox(
                width: 15,
              ),
              Text("New Individual Event"),
             
            ],
          ),
        ),

       ],
     );
   }
}
