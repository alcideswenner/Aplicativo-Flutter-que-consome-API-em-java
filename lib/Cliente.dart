class Cliente {
  String? nome;
  int? id;
  String? dn;
  Cliente({this.id, this.nome, this.dn});
  factory Cliente.from(Map<String, dynamic> data) =>
      Cliente(id: data["id"], nome: data["nome"], dn: data["dn"]);

  Map<String, dynamic> toJson() => {"id": id, "nome": nome, "dn": dn};
}
