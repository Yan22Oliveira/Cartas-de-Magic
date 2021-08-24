import 'package:flutter/material.dart';

import '../../../models/models.dart';

class CardCarta extends StatelessWidget {

  final Carta carta;
  CardCarta({required this.carta});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: Image.network(
                carta.imagem,
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              carta.nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              "Força: "+carta.forca.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              carta.descricao,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            
          ],
        ),
      ),
    );

  }

}
