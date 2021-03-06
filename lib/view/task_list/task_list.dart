import 'package:flutter/material.dart';
import 'package:flutter_test_dev/components/custom_appbar.dart';
import 'package:flutter_test_dev/components/custom_text_field.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/task_controller.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class TaskList extends StatefulWidget {
  int id;
  String title;
  String description;
  String date;

  TaskList({this.id, this.title, this.description, this.date, Key key})
      : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
    idTask = '';
    titleControllerTask.text = widget.title;
    descriptionControllerTask.text = widget.description;
    dateSelected = DateFormat('dd/MM/yyyy').parse(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    //Vereficar se a data esta vazia
    var dateFormatTask = Container(
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
      key: scaffoldKeyTask,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppBar('Tarefa'),
      ),
      body: Form(
        key: formKeyTask,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: _button('Editar', Colors.green),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: _button('Excluir', Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Titulo',
                    marginTop: 16,
                    marginBottom: 5,
                    controller: titleControllerTask,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: titleFocusTask,
                    focusScope: descriptionFocusTask,
                    validate: validateTitle,
                    colorBord: colorDark.withOpacity(0.4),
                  ),
                  CustomTextField(
                    labelText: 'Descrição',
                    marginBottom: 5,
                    marginTop: 0,
                    controller: descriptionControllerTask,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    focusNode: descriptionFocusTask,
                    validate: validateDescription,
                    maxLines: 5,
                    colorBord: colorDark.withOpacity(0.4),
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
                                dateFormatTask,
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
          ],
        ),
      ),
    );
  }

  _button(title, color) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Material(
          color: color,
          child: InkWell(
            onTap: () {
              //Remover foco do campo de texto
              titleFocusTask.unfocus();
              descriptionFocusTask.unfocus();

              if (title == 'Editar') {
                updateDataTask(context, widget.id.toString());
              } else {
                deleteTask(context, widget.id);
              }
            },
            child: Container(
              width: mediaQuery(context, 0.42),
              height: 45,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '$title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaQuery(context, 0.04),
                ),
              ),
            ),
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
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
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
