// lib/components/sidebar.dart
import 'package:flutter/material.dart';
import '../views/category/category_list_view.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onNavigateToCategories;

  Sidebar({required this.onNavigateToCategories});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'サイドバー',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ユーザー一覧'),
            onTap: () {
              Navigator.pop(context); // サイドバーを閉じる
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('カテゴリ一覧'),
            onTap: () {
              Navigator.pop(context); // サイドバーを閉じる
              onNavigateToCategories();
            },
          ),
        ],
      ),
    );
  }
}
