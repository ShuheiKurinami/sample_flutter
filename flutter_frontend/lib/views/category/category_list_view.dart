import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/category_viewmodel.dart';
import 'category_registration_modal.dart';
import 'category_edit_modal.dart'; // 編集モーダルをインポート

class CategoryListView extends StatefulWidget {
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
  }

  void _openRegistrationModal() {
    showDialog(
      context: context,
      builder: (context) => CategoryRegistrationModal(),
    );
  }

  void _openEditModal(category) {
    showDialog(
      context: context,
      builder: (context) => CategoryEditModal(category: category), // 編集モーダルを開く
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カテゴリ一覧'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRegistrationModal,
        child: Icon(Icons.add),
      ),
      body: Consumer<CategoryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.categories.isEmpty) {
            return Center(child: Text('カテゴリが存在しません。'));
          } else {
            return ListView.builder(
              itemCount: viewModel.categories.length,
              itemBuilder: (context, index) {
                final category = viewModel.categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.description),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _openEditModal(category),
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
