import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/components/custom_appbar.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/home_controller.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/add_task/add_task.dart';
import 'package:flutter_test_dev/view/task_list/task_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getListTaskDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppBar('Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddTask()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: colorDark,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot){
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                case ConnectionState.active:
                  Widget widget;

                  if(snapshot.data != null){
                    widget = Column(
                      children: _listCard(snapshot.data),
                    );
                  } else {
                    widget = Container();
                  }

                  return widget;
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _listCard(snapshot) {
    List<Widget> returnData = [];

    for (int i = 0; i < snapshot.length; i++) {
      returnData.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => TaskList()),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: mediaQuery(context, 0.5),
                          child: Flexible(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: mediaQuery(context, 0.04),
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${snapshot[i]['id']} - ${snapshot[i]['title']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${snapshot[i]['date']}',
                          style: TextStyle(
                            fontSize: mediaQuery(context, 0.035),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: colorDark),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: mediaQuery(context, 0.8),
                              child: Text(
                                '${snapshot[i]['description']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return returnData;
  }
}
