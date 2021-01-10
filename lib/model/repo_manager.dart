import 'package:flutter/material.dart';
import 'package:repositories_git/model/repo.dart';
import 'package:repositories_git/screen/home.dart';
import 'package:repositories_git/services/api.dart';

class RepositoriosManager extends ChangeNotifier{
  List<Repositorio> repositorio;
  bool _load = false;

  bool get load => _load;
  set load(bool valor){
    _load = valor;
    notifyListeners();
  }

  RepositoriosManager(){
    loadRepo();
  }

  Future<void> loadRepo() async {
    load = false;
    var listtemp = await Api().GetPubRepo();
    if(listtemp != null){
      repositorio = listtemp;
    }else{
      CustomSnackbar();
    }
    load = true;
    notifyListeners();
  }

  CustomSnackbar(){
    return scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black45,
      content: Text("Problemas de Conexao com Internet, tente novamente!",
        style: TextStyle(color: Colors.white),)
    ));
  }
}