import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:MTApp/src/Services/Street/Street_S.dart';
import 'package:flutter/material.dart';

class StreetList extends StatefulWidget {
  final StreetDto data;
  StreetList({this.data});
  @override
  _StreetListState createState() => _StreetListState();
}

class _StreetListState extends State<StreetList> {
  Street_S st = new Street_S();
  StreetDto streetList ;


  void updateDate() async {
    setState(() {
      streetList = widget.data;
      print(streetList.data.elementAt(0).currentCars.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    updateDate();
  }

  void _onTapItem(BuildContext context, var street) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(street.streetName + ' - ' + street.streetName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("Streets Info"),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: streetList.data.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Divider(height: 10.0),
                ListTile(
                  title: Text(
                    streetList.data[index].streetName,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    "Current Cars:" +
                        streetList.data[index].currentCars.toString() +
                        ", Capacity:" +
                        streetList.data[index].capacity.toString() +
                        ", Diraction :East",
                    //streetList.data[index].capacity.toString(),
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  // leading: Column(
                  //   children: <Widget>[
                  //     CircleAvatar(
                  //       backgroundColor: Colors.blueAccent,
                  //       radius: 35.0,
                  //       child: Text(
                  //         countries[index].loaction,
                  //         style: TextStyle(
                  //           fontSize: 22.0,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  onTap: () => _onTapItem(context, streetList.data[index]),
                ),
              ],
            );
          }),
    );
  }
}
