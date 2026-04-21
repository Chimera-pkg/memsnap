import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller that manages the gem economy.
///
/// - Persists `balance`, `lastDaily` and `unlockedCategories` using
///   `SharedPreferences`.
/// - Exposes methods to claim daily reward, add/spend gems, and unlock
///   categories.
class GemProvider extends ChangeNotifier {
  static const String kBalanceKey = 'gem_balance';
  static const String kLastDailyKey = 'gem_last_daily';
  static const String kUnlockedKey = 'gem_unlocked_categories';

  /// Cost to unlock a single category (Milestone requirement)
  static const int categoryCost = 50;

  /// Categories that are free by design (top 3 free)
  final List<String> topFreeCategories;

  int _balance = 0;
  DateTime? _lastDaily;
  final List<String> _unlocked = [];

  bool _initialized = false;

  GemProvider({List<String>? freeCategories})
    : topFreeCategories =
          freeCategories ?? const ['category_1', 'category_2', 'category_3'];

  /// Initialize controller state from SharedPreferences.
  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    _balance = prefs.getInt(kBalanceKey) ?? 0;
    final last = prefs.getString(kLastDailyKey);
    if (last != null && last.isNotEmpty) {
      _lastDaily = DateTime.tryParse(last);
    }
    _unlocked.clear();
    _unlocked.addAll(prefs.getStringList(kUnlockedKey) ?? []);
    _initialized = true;
    notifyListeners();
  }

  int get balance => _balance;
  DateTime? get lastDaily => _lastDaily;
  List<String> get unlockedCategories => List.unmodifiable(_unlocked);

  /// Claims the daily reward if the last claim was on a previous day.
  /// Returns the number of gems awarded (0 if not eligible).
  Future<int> claimDailyIfEligible() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (_lastDaily != null) {
      final lastDate = DateTime(
        _lastDaily!.year,
        _lastDaily!.month,
        _lastDaily!.day,
      );
      if (lastDate.isAtSameMomentAs(today)) {
        return 0; // already claimed today
      }
    }

    final reward = Random().nextInt(4) + 1; // 1..4 gems
    _balance += reward;
    _lastDaily = now;
    await _savePrefs();
    notifyListeners();
    return reward;
  }

  /// Add gems (e.g., after in-app purchase or quiz reward)
  Future<void> addGems(int amount) async {
    if (amount <= 0) return;
    _balance += amount;
    await _savePrefs();
    notifyListeners();
  }

  /// Spend gems if enough balance. Returns true when successful.
  Future<bool> spendGems(int amount) async {
    if (amount <= 0) return false;
    if (_balance < amount) return false;
    _balance -= amount;
    await _savePrefs();
    notifyListeners();
    return true;
  }

  /// Check if a category is unlocked (either purchased or top-free).
  bool isUnlocked(String category) {
    return _unlocked.contains(category) || topFreeCategories.contains(category);
  }

  /// Attempt to unlock a category. If the category is free or already unlocked,
  /// it will be marked unlocked and return true. Otherwise it will attempt to
  /// spend `categoryCost` gems and unlock on success.
  Future<bool> unlockCategory(String category) async {
    if (isUnlocked(category)) {
      if (!_unlocked.contains(category) &&
          !topFreeCategories.contains(category)) {
        _unlocked.add(category);
        await _savePrefs();
        notifyListeners();
      }
      return true;
    }

    if (_balance >= categoryCost) {
      _balance -= categoryCost;
      _unlocked.add(category);
      await _savePrefs();
      notifyListeners();
      return true;
    }

    return false;
  }

  /// Helper used by tests or debug flows to reset state.
  Future<void> resetForTesting() async {
    _balance = 0;
    _lastDaily = null;
    _unlocked.clear();
    await _savePrefs();
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kBalanceKey, _balance);
    if (_lastDaily != null) {
      await prefs.setString(kLastDailyKey, _lastDaily!.toIso8601String());
    } else {
      await prefs.setString(kLastDailyKey, '');
    }
    await prefs.setStringList(kUnlockedKey, _unlocked);
  }
}

/*
Usage example (in `main.dart`):

final gemController = GemController();
await gemController.init();

// Provide via Provider:
// ChangeNotifierProvider(create: (_) => gemController, child: MyApp())

// Claim daily:
// final reward = await gemController.claimDailyIfEligible();
*/
