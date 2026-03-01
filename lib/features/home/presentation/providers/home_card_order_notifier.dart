import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_card_order_notifier.g.dart';

const _homeCardOrderKey = 'home_card_order';

/// Default card order
const defaultCardOrder = ['menu', 'recipes', 'tasks', 'shopping', 'expenses', 'events'];

@Riverpod(keepAlive: true)
class HomeCardOrderNotifier extends _$HomeCardOrderNotifier {
  @override
  List<String> build() {
    _loadOrder();
    return defaultCardOrder;
  }

  Future<void> _loadOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_homeCardOrderKey);
    if (json == null) return;

    try {
      final saved = List<String>.from(jsonDecode(json) as List);
      // Merge: keep saved order for known IDs, append any new IDs not in saved list
      final merged = <String>[];
      for (final id in saved) {
        if (defaultCardOrder.contains(id)) merged.add(id);
      }
      for (final id in defaultCardOrder) {
        if (!merged.contains(id)) merged.add(id);
      }
      state = merged;
    } catch (_) {
      // Ignore corrupt data, keep defaults
    }
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final list = [...state];
    if (oldIndex < newIndex) newIndex -= 1;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = list;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_homeCardOrderKey, jsonEncode(list));
  }
}
