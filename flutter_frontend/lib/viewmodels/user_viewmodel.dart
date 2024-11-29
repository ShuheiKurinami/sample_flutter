// lib/viewmodels/user_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ユーザー一覧を取得
  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await ApiService.fetchUsers();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'ユーザーの取得に失敗しました。';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ユーザーを作成
  Future<bool> createUser(String name, String sex, String address) async {
    _isLoading = true;
    notifyListeners();

    try {
      User? user = await ApiService.createUser(name, sex, address);
      if (user != null) {
        _users.insert(0, user); // 新しいユーザーをリストの先頭に追加
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'ユーザーの登録に失敗しました。';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'ユーザーの登録に失敗しました。';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
