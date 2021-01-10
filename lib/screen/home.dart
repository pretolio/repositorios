import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repositories_git/model/repo_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: scaffoldKey,
      appBar: AppBar(
        title: Text('Repositorios Publicos'), centerTitle: true,
        leading: Padding(padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
          child: Image.asset("assets/GitHub.png"),
        ),
      ),
      body: Consumer<RepositoriosManager>(
        builder: (_, repo, __){

          return Container(
              child: !repo.load ? ShimmerWidget() : repo.repositorio != null ?
              RefreshIndicator(
                onRefresh: () async {
                  await repo.loadRepo();
                },
                child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: repo.repositorio.length,
                    itemBuilder: (BuildContext context, int indice) {
                      return InkWell(
                          onTap: () async {
                            if (await canLaunch(repo.repositorio[indice].url)) {
                              await launch(repo.repositorio[indice].url);
                            } else {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  content: Text("Erro ao carregar o repositorio ${repo.repositorio[indice].repositorio}",
                                    style: TextStyle(color: Colors.white),)
                              ));
                            }
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(repo.repositorio[indice].repositorio,
                                style: TextStyle(fontSize: 20), overflow: TextOverflow.fade,),
                              subtitle: Text(repo.repositorio[indice].usuario,
                                style: TextStyle(fontSize: 16), overflow: TextOverflow.fade,),
                              leading: CachedNetworkImage(
                                imageUrl: repo.repositorio[indice].avatar,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 60.0, width: 57.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(60)),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  height: 60.0, width: 57.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(60)),
                                    color: Colors.grey[100],
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.account_circle),
                              ),
                            ),
                          )
                      );
                    }
                )
              ) : Center(
                child: GestureDetector(
                    child: Icon(Icons.autorenew_outlined,
                      color: Colors.white, size: 45,),
                    onTap: (){
                      repo.loadRepo();
                    }
                ),
              )
          );
        }
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280.0;
    double containerHeight = 10.0;
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all( 12.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 7),
                Container(
                  height: 55.0, width: 55.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height:10),
                    Container(
                      height: containerHeight,
                      width: containerWidth,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: containerHeight,
                      width: containerWidth * 0.75,
                      color: Colors.grey,
                    ),
                    //SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}