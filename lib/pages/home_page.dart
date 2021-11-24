import 'package:farmapp/pages/cattle_page.dart';
import 'package:farmapp/pages/event_page.dart';
import 'package:farmapp/pages/events_report_page.dart';
import 'package:farmapp/pages/farm_notes.dart';
import 'package:farmapp/pages/farm_setup_page.dart';
import 'package:farmapp/pages/login_page.dart';
import 'package:farmapp/pages/milk_record_page.dart';
import 'package:farmapp/pages/milk_report_page.dart';
import 'package:farmapp/pages/report_page.dart';
import 'package:farmapp/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Farm Dairy"),
      ),
      drawer: Container(
          color: Colors.black,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('My Farm Diary'),
                  accountEmail: Text('support@farmdiary.com'),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 100,
                      child: Image.asset(
                        "assets/images/cow2.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                // Divider(
                //   height: 1,
                //   thickness: 1,
                // ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Want more features?',
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Go Premium'),
                  selected: _selectedDestination == 0,
                  //onTap: () => selectDestination(0),
                ),

                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Premium Only',
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.my_library_books),
                  title: Text('Milk Report'),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MilkReportPage()));
                  },
                  // onTap: () => selectDestination(3),
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Event Report'),
                  selected: _selectedDestination == 1,
                  //onTap: () => selectDestination(1),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventsReportPage()));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.label),
                //   title: Text('Back & Restore'),
                //   selected: _selectedDestination == 2,
                //   //onTap: () => selectDestination(2),
                // ),

                // Divider(
                //   height: 1,
                //   thickness: 2,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     'Farm Account',
                //   ),
                // ),
                // ListTile(
                //   leading: Icon(Icons.bookmark),
                //   title: Text('Login Or create Account'),
                //   selected: _selectedDestination == 3,
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => LoginPage()));
                //   },
                // ),

                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Preferences',
                  ),
                ),

                   // ListTile(
                //   leading: Icon(Icons.bookmark),
                //   title: Text('Settings'),
                //   selected: _selectedDestination == 3,
                //   // onTap: () => selectDestination(3),
                // ),

                   // ListTile(
                //   leading: Icon(Icons.bookmark),
                //   title: Text('Reminders'),
                //   selected: _selectedDestination == 3,
                //   // onTap: () => selectDestination(3),
                // ),

                ListTile(
                  leading:  Icon(Icons.note),
                  title: Text('Farm Notes'),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FarmNote()));
                  },
                 
                ),

                ListTile(
                  leading: Icon(Icons.share_sharp),
                  title: Text('Share Via Whatsapp'),
                  selected: _selectedDestination == 1,
                  onTap: (){
                     Navigator.pop(context);
                    Share.share('check out my website https://example.com', subject: 'Look what I made!');
                  }
                ),
                ListTile(
                  leading: Icon(Icons.policy),
                  title: Text('Privacy Policy'),
                  selected: _selectedDestination == 2,
                  //onTap: () => selectDestination(2),
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('User Guide/Manual'),
                  selected: _selectedDestination == 2,
                  //onTap: () => selectDestination(2),
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Help & Feedback'),
                  selected: _selectedDestination == 2,
                  //onTap: () => selectDestination(2),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(200, 50),
                    bottomLeft: Radius.elliptical(200, 50)),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CattlePage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/cattle.jpg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Cattle",
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w800
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MilkRecordPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/milk.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Milk Records",
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w800
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 0.5,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/notes.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Events",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactiontPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/money-bag.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Transactions",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmSetupPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/agronomy.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Farm Setup",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportPage()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            width: 160,
                            height: 180,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/increase.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
