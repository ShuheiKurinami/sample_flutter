import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // カテゴリ一覧を取得
  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await CategoryApiService.fetchCategories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'カテゴリの取得に失敗しました。';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // カテゴリを作成
  Future<bool> createCategory(String name, String description) async {
    _isLoading = true;
    notifyListeners();

    try {
      Category? category = await CategoryApiService.createCategory(name, description);
      if (category != null) {
        _categories.add(category); // 新しいカテゴリをリストに追加
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'カテゴリの登録に失敗しました。';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'カテゴリの登録に失敗しました。';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
