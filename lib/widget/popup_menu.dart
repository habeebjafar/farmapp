import 'package:flutter/material.dart';

class PopupMenu extends StatefulWidget {
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  static String? _groupSelectedValue;

  @override
  void initState() {
    _groupSelectedValue = "All Active";
    super.initState();
  }

  _groupSelectedValueOnchanged(String? value) {
    setState(() {
      _groupSelectedValue = value!;
      print("from group $_groupSelectedValue");
      Navigator.pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      //child: Text("Radio PopupMenuBotton"),
      onSelected: (value) {
        _groupSelectedValue = value as String?;
        print("from popup $_groupSelectedValue");
      },
      icon: Icon(Icons.filter_list),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "All Active",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("All Active"),
                  ],
                ),
                Radio(
                    activeColor: Colors.orange,
                    value: "All Active",
                    groupValue: _groupSelectedValue,
                    onChanged: _groupSelectedValueOnchanged),
              ],
            )),
        PopupMenuItem(
            value: "Lactating",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Lactating"),
                  ],
                ),
                Radio(
                    activeColor: Colors.orange,
                    value: "Lactating",
                    groupValue: _groupSelectedValue,
                    onChanged: _groupSelectedValueOnchanged),
              ],
            )),
        PopupMenuItem(
            value: _groupSelectedValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non Lactating"),
                  ],
                ),
                Radio(
                    activeColor: Colors.orange,
                    value: "Non Lactating",
                    groupValue: _groupSelectedValue,
                    onChanged: _groupSelectedValueOnchanged),
              ],
            )),
      ],
    );
  }
}
