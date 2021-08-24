import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarCartas extends ChangeNotifier{

  Dio dio = Dio();

  final scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKeyCartas');

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  //Pegar Imagem
  final imagemTemporaria = PickedFile;
  final _picker = ImagePicker();

  File _imagem = File("");
  File get imagem => _imagem;
  set imagem(File value){
    _imagem = value;
    notifyListeners();
  }

  Future<void> pegarImagemGaleria(BuildContext context) async {
    PickedFile? imagemTemporaria = await _picker.getImage(source: ImageSource.camera,imageQuality: 80);
    if(imagemTemporaria!=null){
      imagem = File(imagemTemporaria.path);
    }
  }

  Future<String> salvarImagem()async {

    final firebaseStorageRef = FirebaseStorage.instance.ref().child("cartas/"+imagem.path.split('/').last);
    final uploadTask = firebaseStorageRef.putFile(imagem);

    final taskSnapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await taskSnapshot.ref.getDownloadURL();

    return urlDownload;

  }

  Future<void> postCadastrarCartas({
    required String idUser,
    required Carta carta,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    try{

      var caminhoImagem = await salvarImagem();

      var corpo = json.encode({
        "nome": carta.nome,
        "descricao": carta.descricao,
        "forca": carta.forca,
        "imagem": caminhoImagem,
      });

      final response = await dio.post(
        api_cartas+idUser+"/cartas/.json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Carta cadastrada com sucesso!");
        }else{
          onFail("Erro ao cadastrar Carta!");
        }
      }else{
        onFail("Erro ao cadastrar Carta!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Carta!");
    }

    loading = false;

  }

  Future<void> mensagemDeRetorno({
    required BuildContext context,
    required String mensagem,
    required Color color,
    required bool voltarTela,
  })async{

    scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            mensagem,
            textAlign: TextAlign.center,
          ),
          backgroundColor: color,
          duration: Duration(seconds: 2),
        )
    );

    if(voltarTela){
      Future.delayed(Duration(seconds: 2)).then((_){
        Navigator.pop(context);
      });
    }

  }

}