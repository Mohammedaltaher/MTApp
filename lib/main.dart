import 'package:MTApp/src/UI/Home/Page/HomePage.dart';
import 'package:MTApp/src/UI/Login/Page/welcomePage.dart';
import 'package:MTApp/src/UI/Login/Widget/NavDrawerWidget.dart';
import 'package:MTApp/src/UI/Map/Page/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Monitroing Traffic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _DataTableExample createState() => _DataTableExample();
// }

// class _DataTableExample extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Steen Street info'),
//           ),
//           body: ListView(children: <Widget>[
//             Center(
//                 child: Text(
//               '',
//               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//             )),
//             DataTable(
//               columns: [
//                 DataColumn(
//                     label: Text('Time',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text(' Cars',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('%',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('Direction',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//               ],
//               rows: [
//                 DataRow(
//                     onSelectChanged: (bool selected) {
//                       if (selected) {
//                         print("df");
//                       }
//                     },
//                     cells: [
//                       DataCell(Text('today')),
//                       DataCell(Text('Stephen')),
//                       DataCell(Text('Actor')),
//                       DataCell(Text('Actor')),
//                     ]),
//                 DataRow(cells: [
//                   DataCell(Text('Last Week')),
//                   DataCell(Text('Stephen')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Actor')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('Last month')),
//                   DataCell(Text('Stephen')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Actor')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('Last Year')),
//                   DataCell(Text('Stephen')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Actor')),
//                 ]),
//               ],
//             ),
//           ])),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {runApp(MyApp());}
//
// class MyApp extends StatefulWidget {
//   @override
//   _DataTableExample createState() => _DataTableExample();
// }
//
// class _DataTableExample extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Street List'),
//           ),
//           body: ListView(children: <Widget>[
//             Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 )),
//             DataTable(
//               columns: [
//                 DataColumn(label: Text(
//                     ' Name',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
//                 )),
//                 DataColumn(label: Text(
//                     ' Cars',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
//                 )),
//                 DataColumn(label: Text(
//                     '%',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
//                 )),
//                 DataColumn(label: Text(
//                     'Direction',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
//                 )),
//               ],
//               rows: [
//                 DataRow(cells: [
//                   DataCell(Text('1')),
//                   DataCell(Text('Stephen')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Actor')),
//
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('5')),
//                   DataCell(Text('John')),
//
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Student')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('10')),
//                   DataCell(Text('Harry')),
//
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Leader')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('15')),
//                   DataCell(Text('Peter')),
//                   DataCell(Text('Actor')),
//                   DataCell(Text('Scientist')),
//                 ]),
//               ],
//             ),
//           ])
//       ),
//     );
//   }
// }
