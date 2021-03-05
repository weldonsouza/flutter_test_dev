import 'package:flutter/material.dart';
import 'package:flutter_test_dev/components/custom_appbar.dart';
import 'package:flutter_test_dev/controller/add_task_controller.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  void initState() {
    super.initState();
    titleControllerAddTask.text = '';
    descriptionControllerAddTask.text = '';
    dateSelected = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = Container(
      alignment: Alignment.center,
      child: dateSelected != null
          ? Text(
              '${DateFormat('dd/MM/yyyy').format(dateSelected)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorDark,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery(context, 0.04),
              ),
            )
          : Text(
              '$dataIni',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorDark,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery(context, 0.04),
              ),
            ),
    );

    return Scaffold(
      key: scaffoldKeyAddTask,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppBar('Adicionar Tarefa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveDataAddTask,
        child: Icon(Icons.done),
        backgroundColor: colorDark,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKeyAddTask,
          child: Column(
            children: [
              Container(
                width: mediaQuery(context, 1),
                margin: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 5,
                ),
                child: TextFormField(
                  controller: titleControllerAddTask,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: titleFocusAddTask,
                  validator: validateTitle,
                  autovalidate: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(descriptionFocusAddTask);
                  },
                  cursorColor: colorDark,
                  style: TextStyle(
                    color: colorDark,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorDark.withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorDark.withOpacity(0.4),
                      ),
                    ),
                    labelText: 'Titulo',
                    labelStyle: TextStyle(
                      color: colorDark,
                    ),
                  ),
                ),
              ),
              Container(
                width: mediaQuery(context, 1),
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 5,
                ),
                child: TextFormField(
                  controller: descriptionControllerAddTask,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  focusNode: descriptionFocusAddTask,
                  validator: validateDescription,
                  autovalidate: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  cursorColor: colorDark,
                  style: TextStyle(
                    color: colorDark,
                  ),
                  maxLines: 5,
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorDark.withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorDark.withOpacity(0.4),
                      ),
                    ),
                    labelText: 'Descrição',
                    labelStyle: TextStyle(
                      color: colorDark,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _showDateTimePicker,
                      child: Container(
                        width: mediaQuery(context, 1),
                        height: 40,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: colorDark.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            dateFormat,
                            Icon(
                              MdiIcons.calendar,
                              color: colorDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Popup do calendario
  _showDateTimePicker() async {
    dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 10)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: const Color(0xFF607D8B),
            accentColor: const Color(0xFF607D8B),
            colorScheme: ColorScheme.light(primary: const Color(0xFF607D8B)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    setState(() {});
  }
}
