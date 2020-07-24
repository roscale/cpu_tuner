import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  int selectedItem;
  Function onItemSelected;

  Sidebar({Key key, this.selectedItem, this.onItemSelected}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  Widget _createItem(int id, Widget leading, Widget title) {
    return InkWell(
      child: Container(
        color: widget.selectedItem == id ? Colors.blue : Colors.transparent,
        child: ListTile(
          leading: leading,
          title: title,
          onTap: () {
            setState(() {
              widget.selectedItem = id;
            });
            widget.onItemSelected(id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Color(0xFF404040),
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              _createItem(0, Icon(Icons.memory), Text("System information")),
              _createItem(1, Icon(Icons.build), Text("Tuning")),
            ],
          ),
          _createItem(2, Icon(Icons.info_outline), Text("About")),
        ],
      ),
    );
  }
}
