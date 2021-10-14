import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/pages/cattle_details_event.dart';
import 'package:farmapp/pages/cattle_details_general.dart.dart';
import 'package:flutter/material.dart';

class CattleDetailsPage extends StatefulWidget {

  List<CattleModel> _list;
  int index;

  CattleDetailsPage(this._list, this.index);

  @override
  _CattleDetailsPageState createState() => _CattleDetailsPageState();
}

class _CattleDetailsPageState extends State<CattleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: Colors.black,
            //centerTitle: true,
            titleSpacing: 0.0,
            toolbarHeight: 200,
            leadingWidth: 0.0,

            title: Container(
              color: Colors.redAccent,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset("assets/images/cow.png"),
                  Text("Events"),
                ],
              ))
              ,

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
                          Text("DETAILS",
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
                          Text("EVENTS")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [CattleDetailsGeneral(this.widget._list, this.widget.index), CattleDetailsEvent(this.widget._list, this.widget.index)],
          ),
        ),
      ),
    );
  }
}
