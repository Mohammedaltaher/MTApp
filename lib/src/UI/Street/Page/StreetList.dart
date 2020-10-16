import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:MTApp/src/Services/Street/AllStreetDto_S.dart';
import 'package:MTApp/src/Services/Street/Street_S.dart';
import 'package:flutter/material.dart';

class StreetList extends StatefulWidget {
  final AllStreetDto data;
  StreetList({this.data});
  @override
  _StreetListState createState() => _StreetListState();
}

class _StreetListState extends State<StreetList> {
  AllStreetDto_S st = new AllStreetDto_S();
  AllStreetDto streetList;

  void updateDate() async {
    setState(() {
      streetList = widget.data;
      print(streetList.data.elementAt(0).streetName.toString());
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
          title: Text('Streets'),
        ),
        body: ListView(children: <Widget>[
          Center(
              child: Text(
            '',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          DataTable(
            columns: [
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text(' Cars',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('%',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Direction',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
            ],
            rows: streetList.data
                .map(
                  ((element) => DataRow(
                        onSelectChanged: (bool selected) {
                          if (selected) {
                            print(element.carrentCars.toString());
                          }
                        },
                        cells: <DataCell>[
                          DataCell(Text(element.carrentCars.toString())),
                          DataCell(Text(element.capacity.toString())),
                          DataCell(Text(element.streetName.toString())),
                          DataCell(Text(element.streetName.toString())),
                        ],
                      )),
                )
                .toList(),
          ),
        ]));
  }
}

//  return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[500],
//         title: Text("Streets Info"),
//         elevation: 0,
//       ),
//       body: ListView.builder(
//           itemCount: streetList.data.length,
//           padding: const EdgeInsets.all(15.0),
//           itemBuilder: (context, index) {
//             return Column(
//               children: <Widget>[
//                 Divider(height: 10.0),
//                 ListTile(
//                   title: Text(
//                     streetList.data[index].streetName,
//                     style: TextStyle(
//                       fontSize: 22.0,
//                       color: Colors.deepOrangeAccent,
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Current Cars:" +
//                         streetList.data[index].currentCars.toString() +
//                         ", Capacity:" +
//                         streetList.data[index].capacity.toString() +
//                         ", Diraction :East",
//                     //streetList.data[index].capacity.toString(),
//                     style: new TextStyle(
//                       fontSize: 18.0,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   // leading: Column(
//                   //   children: <Widget>[
//                   //     CircleAvatar(
//                   //       backgroundColor: Colors.blueAccent,
//                   //       radius: 35.0,
//                   //       child: Text(
//                   //         countries[index].loaction,
//                   //         style: TextStyle(
//                   //           fontSize: 22.0,
//                   //           color: Colors.white,
//                   //         ),
//                   //       ),
//                   //     )
//                   //   ],
//                   // ),
//                   onTap: () => _onTapItem(context, streetList.data[index]),
//                 ),
//               ],
//             );
//           }),
//     );
