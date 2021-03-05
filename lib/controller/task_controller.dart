import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/model/base_model.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:intl/intl.dart';

final formKeyTask = GlobalKey<FormState>();
final scaffoldKeyTask = GlobalKey<ScaffoldState>();
final TextEditingController titleControllerTask = TextEditingController();
final TextEditingController descriptionControllerTask = TextEditingController();

final FocusNode titleFocusTask = FocusNode();
final FocusNode descriptionFocusTask = FocusNode();

var idTask;

saveDataTask() async {
  if (formKeyTask.currentState.validate()) {
    if (dateSelected != null) {
      dateFormatTask = '${DateFormat('dd/MM/yyyy').format(dateSelected)}';
    } else {
      dateFormatTask = '$dataIni';
    }

    //Salvar dados no sqlite
    var dataSave = await dbBase.updateBaseDB(
      BaseModel(
          id: idTask,
          title: titleControllerTask.text,
          description: descriptionControllerTask.text,
          date: dateFormatTask,
      ),
    );

    print(dataSave);
    if (dataSave > 0) {
      idTask = '';
      titleControllerTask.text = '';
      descriptionControllerTask.text = '';
    }
  } else {
    onMSG(scaffoldKeyTask , 'Campos obrigatórios!');
  }
}
