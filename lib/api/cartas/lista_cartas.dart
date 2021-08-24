import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ListaCartas extends ChangeNotifier{

  ListaCartas(){
    getListaCartas();
  }

  Dio dio = Dio();

  List<Carta> listaCartas = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaCartas() async {

    loading = true;
    listaCartas.clear();

    SharedPreferences prefs = await  SharedPreferences.getInstance();

    var localId = prefs.getString('localId')??"";

    try{

      final response = await dio.get(
        api_cartas+localId+"/cartas/.json",
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Carta carta = Carta.fromJson(value,key);
          listaCartas.add(carta);
        });

      }else{
        listaCartas.clear();
      }

    }catch(e){
      print(e);
      listaCartas.clear();
    }

    loading = false;

  }

}