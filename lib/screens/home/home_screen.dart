import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';

import './componenes/card_carta.dart';
import '../login/login_screen.dart';
import '../cadastrar_carta/cadastrar_carta_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer2<Login,ListaCartas>(

      builder: (_,login,listaCartas,__){

        return Scaffold(
          backgroundColor: colorFundo,
          appBar: AppBar(
            title: Text(
              "Cartas de Magic",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: (){
                  login.sair();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen(),
                    ),
                  );
                },
                tooltip: 'Sair',
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8,),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: colorRedSalsa,
            tooltip: "Adicionar Carta",
            onPressed: (){

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarCartaScreen(),
                ),
              );

            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          body: listaCartas.loading?
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
              color: Colors.white,
            ),
          ):
          ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: listaCartas.listaCartas.length,
            itemBuilder: (context,index){

              return CardCarta(carta: listaCartas.listaCartas[index],);

            },

          ),

        );

      },

    );
  }
}
