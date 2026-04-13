import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_gamification/core/controllers/gem_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('initializes with zero balance', () async {
    final ctrl = GemController();
    await ctrl.init();
    expect(ctrl.balance, 0);
  });

  test('claimDailyIfEligible awards 1-4 gems', () async {
    final ctrl = GemController();
    await ctrl.init();
    final reward = await ctrl.claimDailyIfEligible();
    expect(reward >= 1 && reward <= 4, isTrue);
    expect(ctrl.balance, reward);
  });

  test('add and spend gems', () async {
    final ctrl = GemController();
    await ctrl.init();
    await ctrl.addGems(50);
    expect(ctrl.balance, 50);
    final ok = await ctrl.spendGems(25);
    expect(ok, true);
    expect(ctrl.balance, 25);
  });

  test('unlockCategory requires 50 gems', () async {
    final ctrl = GemController();
    await ctrl.init();
    expect(ctrl.isUnlocked('category_4'), false);
    var ok = await ctrl.unlockCategory('category_4');
    expect(ok, false);
    await ctrl.addGems(50);
    ok = await ctrl.unlockCategory('category_4');
    expect(ok, true);
    expect(ctrl.isUnlocked('category_4'), true);
  });

  test('resetForTesting clears state', () async {
    final ctrl = GemController();
    await ctrl.init();
    await ctrl.addGems(10);
    await ctrl.resetForTesting();
    expect(ctrl.balance, 0);
    expect(ctrl.unlockedCategories.isEmpty, true);
  });
}
