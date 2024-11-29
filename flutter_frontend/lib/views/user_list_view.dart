// lib/views/user_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';
import 'user_registration_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー一覧'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegistration,
        child: Icon(Icons.add),
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
                  trailing: Text(
                    '${user.created_at.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
