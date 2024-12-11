import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/category_viewmodel.dart'; // CategoryViewModelをインポート
import 'views/user/user_list_view.dart';
import 'views/category/category_list_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()), // 追加
      ],
      child: FlutterApp(),
    ),
  );
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Backend App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListView(), // 初期画面をUserListViewに設定
    );
  }
}
