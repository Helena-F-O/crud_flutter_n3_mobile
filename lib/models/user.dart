class User {
  final String? id;
  final String nome;
  final String email;
  final String avatarUrl;
  final String peso;
  final String altura;
  final String imc;


  const User({
    this.id,
    required this.nome,
    required this.email,
    required this.avatarUrl,
    required this.peso,
    required this.altura,
    required this.imc,
  });
}
