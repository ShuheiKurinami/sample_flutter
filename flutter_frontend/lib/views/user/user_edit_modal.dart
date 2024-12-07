import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../../models/user.dart';

class UserEditModal extends StatefulWidget {
  final User user;

  UserEditModal({required this.user});

  @override
  _UserEditModalState createState() => _UserEditModalState();
}

class _UserEditModalState extends State<UserEditModal> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String sex;
  late String address;

  @override
  void initState() {
    super.initState();
    name = widget.user.name;
    sex = widget.user.sex;
    address = widget.user.address;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool success = await Provider.of<UserViewModel>(context, listen: false)
          .updateUser(widget.user.id, name, sex, address);

      if (success) {
        Navigator.pop(context); // モーダルを閉じる
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ユーザーの更新に失敗しました。')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ユーザー編集'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: '名前'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '名前を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                initialValue: sex,
                decoration: InputDecoration(labelText: '性別'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '性別を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  sex = value!;
                },
              ),
              TextFormField(
                initialValue: address,
                decoration: InputDecoration(labelText: '住所'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '住所を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value!;
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
