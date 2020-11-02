import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Services/Street/AllStreetDto_S.dart';
import 'package:MTApp/src/UI/Login/Widget/NavDrawerWidget.dart';
import 'package:MTApp/src/UI/Map/Page/Loding.dart';
import 'package:MTApp/src/UI/Street/Page/LodeStreetData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LodeStreetData()));
    setState(() {});
    _refreshController.loadComplete();
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
        drawer: NavDrawerWidget(),
        appBar: AppBar(
          title: Text('Streets'),
          backgroundColor: Color(0xfff7892b),
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(children: <Widget>[
              Center(
                  child: Text(
                '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              DataTable(
                columns: [
                  DataColumn(
                      label: Text('Name',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text(' From',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('To',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Traffic %',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                ],
                rows: streetList.data
                    .map(
                      ((element) => DataRow(
                            onSelectChanged: (bool selected) {
                              if (selected) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Loding(
                                        streetId: element.streetID,
                                      ),
                                    ));
                                print(element.carrentCars.toString());
                              }
                            },
                            cells: <DataCell>[
                              DataCell(Text(element.streetName.toString(),
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(element.from.toString(),
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(element.to.toString(),
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(
                                  element.trafficJam.toStringAsFixed(2) + "%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: getTrafficColor(
                                        (element.trafficJam),
                                      )))),
                            ],
                          )),
                    )
                    .toList(),
              ),
            ])));
  }

  Color getTrafficColor(double trafficJam) {
    if (trafficJam > 90) {
      return Colors.red;
    } else if (trafficJam > 70) {
      return Colors.orange[600];
    } else if (trafficJam > 60) {
      return Colors.yellow[600];
    } else if (trafficJam > 20) {
      return Colors.green[600];
    }
    return Colors.blue;
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
