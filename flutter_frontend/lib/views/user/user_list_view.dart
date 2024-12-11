import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';
import 'user_registration_view.dart';
import 'user_edit_modal.dart';
import '../category/category_list_view.dart'; // カテゴリ一覧画面をインポート

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).fetchUsers();
  }

  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserRegistrationView()),
    );
  }

  void _navigateToCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryListView()),
    );
  }

  void _openEditModal(user) {
    showDialog(
      context: context,
      builder: (context) => UserEditModal(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー一覧'),
        actions: [
          IconButton(
            icon: Icon(Icons.category),
            tooltip: 'カテゴリ一覧へ移動',
            onPressed: _navigateToCategories,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegistration,
        child: Icon(Icons.add),
        tooltip: '新しいユーザーを追加',
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.users.isEmpty) {
            return Center(child: Text('ユーザーが存在しません。'));
          } else {
            return ListView.builder(
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                final user = viewModel.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('${user.sex}, ${user.address}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _openEditModal(user),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
