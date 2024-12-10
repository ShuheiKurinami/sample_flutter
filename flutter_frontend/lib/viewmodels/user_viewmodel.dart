// lib/viewmodels/user_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter and Setter for Users
  List<User> get users => _users;

  // Getter and Setter for isLoading
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Getter and Setter for errorMessage
  String? get errorMessage => _errorMessage;
  set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  // ユーザー一覧を取得
  Future<void> fetchUsers() async {
    isLoading = true;
    try {
      _users = await ApiService.fetchUsers();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'ユーザーの取得に失敗しました。';
    } finally {
      isLoading = false;
    }
  }

  // ユーザーを作成
  Future<bool> createUser(String name, String sex, String address, String phone) async {
  _isLoading = true;
  notifyListeners();

  try {
    User? user = await ApiService.createUser(name, sex, address, phone); // phoneを追加
    if (user != null) {
      _users.insert(0, user);
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

  // ユーザーを更新
  Future<bool> updateUser(int id, String name, String sex, String address, String phone) async {
    isLoading = true;
    try {
      await ApiService.updateUser(id, name, sex, address, phone);
      await fetchUsers(); // 更新後に一覧を再取得
      return true;
    } catch (e) {
      errorMessage = 'ユーザーの更新に失敗しました。';
      return false;
    } finally {
      isLoading = false;
    }
  }
}
