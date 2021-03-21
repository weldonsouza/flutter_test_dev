import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/components/custom_appbar.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/home_controller.dart';
import 'package:flutter_test_dev/controller/network_test_connectivity.dart';
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
    streamController.add(null);
    streamJsonController.add(null);
    getListTaskDB();
    getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: streamController.stream,
                  builder: (context, snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.active:
                        Widget widget;

                        if(snapshot.data != null){
                          widget = Container(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Column(
                              children: _listCard(snapshot.data),
                            ),
                          );
                        } else {
                          widget = Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Container(
                                  width: mediaQuery(context, 1),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: mediaQuery(context, 0.04),
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Não há tarefas salvas',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return widget;
                      default:
                        return Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Container(
                                width: mediaQuery(context, 1),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: mediaQuery(context, 0.04),
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Não há tarefas salvas',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                    }
                  },
                ),
                StreamBuilder(
                  stream: streamJsonController.stream,
                  builder: (context, snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.active:
                        Widget widget;

                        if(snapshot.data != null){
                          widget = Container(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Divider(
                                          color: colorDark,
                                          height: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          child: Text(
                                            'Lista da API "TODOS"',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: mediaQuery(context, 0.04),
                                              color: colorDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: colorDark,
                                          height: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: _listJson(snapshot.data),
                                ),
                              ],
                            ),
                          );
                        } else {
                          widget = Container();
                        }

                        return widget;
                      default:
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorDark,
                              ),
                            ),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),

        //Barra de informando se tem internet
        NetworkTestConnectivity(),
      ],
    );
  }

  _listCard(snapshot) {
    List<Widget> returnData = [];

    for (int i = 0; i < snapshot.length; i++) {
      returnData.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => TaskList(
                  id: snapshot[i]['id'],
                  title: snapshot[i]['title'],
                  description: snapshot[i]['description'],
                  date: snapshot[i]['date'],
                ))
              );
            },
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

  _listJson(snapshot) {
    List<Widget> returnData = [];

    for (int i = 0; i < snapshot.length; i++) {
      returnData.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: mediaQuery(context, 1),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: mediaQuery(context, 0.04),
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${snapshot[i].id} - ${snapshot[i].title}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: colorDark),
                  Text(
                    'Completado: ${snapshot[i].completed}',
                    style: TextStyle(
                      fontSize: mediaQuery(context, 0.035),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return returnData;
  }
}
