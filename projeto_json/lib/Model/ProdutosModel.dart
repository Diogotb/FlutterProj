class Produto {
  int id;
  String nome;
  String descricao;
  int quantidade;
  String foto;
  double preco;
  List<String> categorias;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.foto,
    required this.preco,
    required this.categorias,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'quantidade': quantidade,
        'foto': foto,
        'preco': preco,
        'categorias': categorias,
      };

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: json['id'],
        nome: json['nome'],
        descricao: json['descricao'],
        quantidade: json['quantidade'],
        foto: json['foto'],
        preco: json['preco'],
        categorias: List<String>.from(json['categorias']),
      );
}