
class Repositorio{
  String repositorio;
  String usuario;
  String avatar;
  String url;

  Repositorio({this.repositorio, this.usuario, this.avatar, this.url});

  factory Repositorio.fromJson(Map<String, dynamic> json) {
    return Repositorio(
      repositorio: json["name"],
      usuario: json["owner"]["login"],
      avatar: json["owner"]["avatar_url"],
      url: json["html_url"],
    );
  }
}