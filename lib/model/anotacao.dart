class Anotacao {
  int? id;
  late int numeroAv;
  late int numeroLote;
  late String tipoRacao;
  late String data;
  late int quantidade;
  late String nomeMotorista;

  Anotacao(this.numeroLote, this.numeroAv, this.tipoRacao, this.data,
      this.quantidade, this.nomeMotorista);

  Anotacao.fromMap(Map map) {
    id = map["id"];
    numeroAv = map["numeroAv"];
    numeroLote = map["numeroLote"];
    tipoRacao = map["tipoRacao"];
    data = map["data"];
    quantidade = map["quantidade"];
    nomeMotorista = map["nomeMotorista"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "numeroAv": numeroAv,
      "numeroLote": numeroLote,
      "tipoRacao": tipoRacao,
      "data": data,
      "quantidade": quantidade,
      "nomeMotorista": nomeMotorista
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
