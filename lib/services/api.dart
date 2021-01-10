import 'dart:convert';
import 'dart:typed_data';
import 'package:repositories_git/model/repo.dart';
import 'package:http/http.dart' as http;

class Api {
  String _urlbase = "https://api.github.com/repositories";

  Future< List<Repositorio> > GetPubRepo() async {
    try {
      http.Response response = await http.get(_urlbase,
        headers: {"Accept": "application/vnd.github.v3+json"}
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        //var dados = response.body ;
        List<dynamic> dados = json.decode( response.body );

        List<Repositorio> repo = dados.map<Repositorio>(
            (map) {
              return Repositorio.fromJson(map);
              Api().GetPhoto(map["owner"]["avatar_url"]).then((img){

              });
            }
        ).toList();
        print("repo " + repo.toString());
        return repo;
      }else{
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future< Uint8List > GetPhoto(String url) async {
    try {
      http.Response response = await http.get(_urlbase,);
      if(response.statusCode == 200){
        print(response.bodyBytes);
        return response.bodyBytes;
      }else{
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}