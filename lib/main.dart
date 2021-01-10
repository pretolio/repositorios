import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/repo_manager.dart';
import 'screen/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      lazy: false,
      create: (_)=> RepositoriosManager(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Git Repo",
          home: Home(),
          theme: ThemeData.dark(),
      ),
    ),
  );
}
