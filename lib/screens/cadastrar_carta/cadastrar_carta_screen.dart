import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class CadastrarCartaScreen extends StatefulWidget {

  @override
  _CadastrarCartaScreenState createState() => _CadastrarCartaScreenState();
}

class _CadastrarCartaScreenState extends State<CadastrarCartaScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Carta carta = Carta.clear();

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarCartas,Login>(

      builder: (_,cadastrarCartas,login,__){

        return Scaffold(
          key: cadastrarCartas.scaffoldKey,
          backgroundColor: colorSmokyBlack,
          appBar: AppBar(
            backgroundColor: colorSmokyBlack,
            title: Text(
              "Cadastrar Carta",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.4,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Form(
                key: formKey,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      height: double.maxFinite,
                      color: colorSmokyBlack,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              const SizedBox(height: 16),
                              FormField(
                                validator: (oferta){
                                  if(cadastrarCartas.imagem.path.isEmpty)
                                    return 'É necessário adicionar uma foto';
                                  return null;
                                },
                                builder: (state){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextoTituloForm(texto: 'Foto da Carta',),
                                      const SizedBox(height: 4,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        color: Colors.white,
                                        elevation: 1,
                                        child: Container(
                                          height: 200,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              if(cadastrarCartas.imagem.path.isNotEmpty)
                                              Center(
                                                child: Image.file(
                                                  cadastrarCartas.imagem,
                                                  height: 200,
                                                ),
                                              ),
                                              Align(
                                                alignment: cadastrarCartas.imagem.path.isNotEmpty?
                                                Alignment.topRight:
                                                Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    onPressed: ()async{
                                                      await cadastrarCartas.pegarImagemGaleria(context);
                                                    },
                                                    tooltip: "Adicionar imagem",
                                                    icon: Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: colorRedSalsa,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                            ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if(state.hasError)
                                        const SizedBox(height: 4,),
                                      if(state.hasError)
                                        Text(
                                          state.errorText as String,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12
                                          ),
                                        ),
                                    ],
                                  );
                                },

                              ),

                              const SizedBox(height: 16),
                              FormField(
                                validator: (linkOferta){
                                  if(carta.nome.trim().isEmpty)
                                    return 'Campo obrigatório';
                                  return null;
                                },
                                builder: (state){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextoTituloForm(texto: 'Nome da carta',),
                                      const SizedBox(height: 4,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FormGeral(
                                          hintText: '',
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          onSaved: (text){
                                            carta.nome = text!;
                                          },
                                        ),
                                      ),
                                      if(state.hasError)
                                        const SizedBox(height: 4,),
                                      if(state.hasError)
                                        Text(
                                          state.errorText as String,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12
                                          ),
                                        ),
                                    ],
                                  );

                                },
                              ),

                              const SizedBox(height: 16),
                              FormField(
                                validator: (linkOferta){
                                  if(carta.forca <= 0)
                                    return 'Campo obrigatório';
                                  return null;
                                },
                                builder: (state){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextoTituloForm(texto: 'Força da carta',),
                                      const SizedBox(height: 4,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FormGeral(
                                          hintText: '0',
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          onSaved: (text){
                                            carta.forca = int.parse(text!);
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            RealInputFormatter(centavos: false),
                                          ],
                                        ),
                                      ),
                                      if(state.hasError)
                                        const SizedBox(height: 4,),
                                      if(state.hasError)
                                        Text(
                                          state.errorText as String,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12
                                          ),
                                        ),
                                    ],
                                  );

                                },
                              ),

                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextoTituloForm(texto: 'Descrição',),
                                  const SizedBox(height: 4,),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: FormGeral(
                                      hintText: 'Descrição da carta',
                                      onSaved: (text){
                                        carta.descricao = text!;
                                      },
                                    ),
                                  ),
                                ],
                              ),


                              const SizedBox(height: 36),

                              RaisedButton(
                                onPressed:cadastrarCartas.loading?null:(){

                                  formKey.currentState!.save();

                                  if(formKey.currentState!.validate()){

                                    cadastrarCartas.postCadastrarCartas(
                                        idUser: login.user.localId,
                                        carta: carta,
                                        onSuccess: (text)async{

                                          //Atualizar as listas das cartas
                                          context.read<ListaCartas>().getListaCartas();

                                          await cadastrarCartas.mensagemDeRetorno(
                                            context: context,
                                            voltarTela: true,
                                            color: Colors.green,
                                            mensagem: text,
                                          );

                                          carta = Carta.clear();

                                        },
                                        onFail: (text)async{
                                          await cadastrarCartas.mensagemDeRetorno(
                                            context: context,
                                            voltarTela: false,
                                            color: Colors.redAccent,
                                            mensagem: text,
                                          );
                                        },
                                    );

                                  }else{
                                    cadastrarCartas.mensagemDeRetorno(
                                      context: context,
                                      voltarTela: false,
                                      color: Colors.redAccent,
                                      mensagem: "Favor, preencher todos os campos obrigatório",
                                    );
                                  }

                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 3,
                                color: Colors.green,
                                padding: EdgeInsets.all(8),
                                child: cadastrarCartas.loading?
                                Center(
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator(
                                      color: colorRedSalsa,
                                    ),
                                  ),
                                ):
                                Container(
                                  height: 36,
                                  child: Center(
                                    child: Text(
                                      "Cadastrar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

      },
    );

  }
}
