class Carta {

  String id        = '';
  String nome      = '';
  String descricao = '';
  int    forca     = 0;
  String imagem    = '';

  Carta({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.forca,
    required this.imagem,
  });

  Carta.fromJson(Map<String, dynamic> json,String key) {
    id         = key;
    nome       = json['nome']??"";
    descricao  = json['descricao']??"";
    forca      = json['forca']??"";
    imagem     = json['imagem']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']        = this.id;
    data['nome']      = this.nome;
    data['descricao'] = this.descricao;
    data['forca']     = this.forca;
    data['imagem']    = this.imagem;
    return data;
  }

  Carta.clear(){
    id         = "";
    nome       = "";
    descricao  = "";
    forca      = 0;
    imagem     = "";
  }

}