import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';

class UserRegistrationView extends StatefulWidget {
  @override
  _UserRegistrationViewState createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String sex = '';
  String address = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool success = await Provider.of<UserViewModel>(context, listen: false)
          .createUser(name, sex, address);

      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ユーザーの登録に失敗しました。')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<UserViewModel>(context).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー登録'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: '性別'),
                      value: null, // 初期値を設定しない
                      items: ['男', '女']
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          sex = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '性別を選択してください';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        sex = value!;
                      },
                    ),
                    TextFormField(
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text('登録'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
