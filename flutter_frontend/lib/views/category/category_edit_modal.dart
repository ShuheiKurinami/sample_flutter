import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../../models/category.dart';
import '../../services/category_api_service.dart';

class CategoryEditModal extends StatefulWidget {
  final Category category;

  CategoryEditModal({required this.category});

  @override
  _CategoryEditModalState createState() => _CategoryEditModalState();
}

class _CategoryEditModalState extends State<CategoryEditModal> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;

  @override
  void initState() {
    super.initState();
    name = widget.category.name;
    description = widget.category.description;
  }

  void _submit() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    try {
      await CategoryApiService.updateCategory(
        widget.category.id,
        name,
        description,
      );
      Navigator.pop(context, true); // モーダルを閉じる
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('カテゴリの更新に失敗しました。')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('カテゴリ編集'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'カテゴリ名'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'カテゴリ名を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: '説明'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '説明を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('保存'),
        ),
      ],
    );
  }
}
