import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/provider/cattle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


  // This list holds the data for the list view
  List<CattleModel> _foundUsers = [];
  var cattleProvider;
  @override
  initState() {
    Provider.of<CattleProvider>(context, listen: false).getAllCattles("All");
    cattleProvider = Provider.of<CattleProvider>(context, listen: false).cattleList;
    //cattleProvider.getAllCattles("All");
    // at the beginning, all users are shown
    _foundUsers = cattleProvider;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<CattleModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = cattleProvider;
    } else {
      results = cattleProvider
          .where((user) =>
              user["cattleName"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].id),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index].id.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index].cattleName!),
                          subtitle: Text(
                              '${_foundUsers[index].cattleTagNo.toString()} years old'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


















// import 'package:flutter/material.dart';

// class Search extends SearchDelegate {
//   List<String> data = [
//     "android",
//     "windows",
//     "mac",
//     "linux",
//     "parrotOS",
//     "mint"
//   ];

//   List<String> recentSearch = [
//     "Android",
//     "Windows",
//     "Mac",
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return <Widget>[
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (data.contains(query.toLowerCase())) {
//       return ListTile(
//         title: Text(query),
//         onTap: () {},
//       );
//     } else if (query == "") {
//       return Text("");
//     } else {
//       return ListTile(
//         title: Text("No results found"),
//         onTap: () {},
//       );
//     }
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ListView.builder(
//         itemCount: recentSearch.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(recentSearch[index]),
          
//             onTap: () {},
//           );
//         });
//   }
  
  

// }