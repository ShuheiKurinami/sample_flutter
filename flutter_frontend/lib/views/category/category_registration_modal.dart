import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/category_viewmodel.dart';

class CategoryRegistrationModal extends StatefulWidget {
  @override
  _CategoryRegistrationModalState createState() =>
      _CategoryRegistrationModalState();
}

class _CategoryRegistrationModalState extends State<CategoryRegistrationModal> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool success = await Provider.of<CategoryViewModel>(context, listen: false)
          .createCategory(name, description);

      if (success) {
        Navigator.pop(context); // モーダルを閉じる
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('カテゴリの登録に失敗しました。')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('カテゴリ登録'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
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
          child: Text('登録'),
        ),
      ],
    );
  }
}
