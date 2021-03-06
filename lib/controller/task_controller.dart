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

//Atualizar tarefa
updateDataTask(context, idTask) async {
  if (titleControllerTask.text.isNotEmpty &&
      descriptionControllerTask.text.isNotEmpty) {
    //Converter o formato da data
    if (dateSelected != null) {
      dateFormatTask = '${DateFormat('dd/MM/yyyy').format(dateSelected)}';
    } else {
      dateFormatTask = '$dataIni';
    }

    //Atualizar dados no sqlite
    var dataUpdate = await dbBase.updateBaseDB(
      BaseModel(
        id: int.parse(idTask),
        title: titleControllerTask.text,
        description: descriptionControllerTask.text,
        date: dateFormatTask,
        maker: userMaker,
      ),
    );

    if (dataUpdate > 0) {
      onMSG(
        scaffoldKeyTask,
        '${descriptionControllerTask.text} alterado com sucesso!',
      );

      idTask = '';
      titleControllerTask.text = '';
      descriptionControllerTask.text = '';

      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
      });
    }
  } else {
    onMSG(scaffoldKeyTask, 'Campos obrigatórios!');
  }
}

//Deletar terefa
deleteTask(context, idTask) async {
  if (titleControllerTask.text.isNotEmpty &&
      descriptionControllerTask.text.isNotEmpty) {
    //Exluir a tarefa
    var dataDelete = await dbBase.deleteBaseDB(idTask);

    if (dataDelete == 1) {
      titleControllerTask.text = '';
      descriptionControllerTask.text = '';

      onMSG(scaffoldKeyTask,
          '${descriptionControllerTask.text} excluido com sucesso!');

      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
      });
    }
  }
}
