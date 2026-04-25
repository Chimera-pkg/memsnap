import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_gamification/providers/gem_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('initializes with zero balance', () async {
    final ctrl = GemProvider();
    await ctrl.init();
    expect(ctrl.balance, 0);
  });

  test('claimDailyIfEligible awards 1-4 gems', () async {
    final ctrl = GemProvider();
    await ctrl.init();
    final reward = await ctrl.claimDailyIfEligible();
    expect(reward >= 1 && reward <= 4, isTrue);
    expect(ctrl.balance, reward);
  });

  test('unlockCategory requires 50 gems', () async {
    final ctrl = GemProvider();
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
    final ctrl = GemProvider();
    await ctrl.init();
    await ctrl.addGems(10);
    await ctrl.resetForTesting();
    expect(ctrl.balance, 0);
    expect(ctrl.unlockedCategories.isEmpty, true);
  });
}
