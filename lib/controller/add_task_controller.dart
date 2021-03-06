import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/model/base_model.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:intl/intl.dart';

final formKeyAddTask = GlobalKey<FormState>();
final scaffoldKeyAddTask = GlobalKey<ScaffoldState>();
final TextEditingController titleControllerAddTask = TextEditingController();
final TextEditingController descriptionControllerAddTask =
    TextEditingController();

final FocusNode titleFocusAddTask = FocusNode();
final FocusNode descriptionFocusAddTask = FocusNode();

saveDataAddTask() async {
  if (formKeyAddTask.currentState.validate()) {

    //Converter o formato da data
    if (dateSelected != null) {
      dateFormatTask = '${DateFormat('dd/MM/yyyy').format(dateSelected)}';
    } else {
      dateFormatTask = '$dataIni';
    }

    //Salvar dados no sqlite
    var dataSave = await dbBase.saveBaseDB(
      BaseModel(
        title: titleControllerAddTask.text,
        description: descriptionControllerAddTask.text,
        date: dateFormatTask,
        maker: userMaker,
      ),
    );

    if (dataSave > 0) {
      onMSG(
        scaffoldKeyAddTask,
        '${titleControllerAddTask.text} tarefa salva com sucesso!',
      );

      titleControllerAddTask.text = '';
      descriptionControllerAddTask.text = '';
    }
  } else {
    onMSG(scaffoldKeyAddTask, 'Campos obrigatórios!');
  }
}
