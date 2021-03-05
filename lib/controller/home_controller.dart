import 'package:flutter_test_dev/model/base_model.dart';
import 'package:flutter_test_dev/utils/globals.dart';

List<BaseModel> getBase;

//Atualizar a lista das coletas salvas no sqlite
getListTaskDB() async {
  getBase = await dbBase.getBaseDB();
}
