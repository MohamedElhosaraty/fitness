import 'package:fitness/feature/learn/ui/widget/custom_learn_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/helpers/shared_prefs_keys.dart';
import '../../data/model/tip_data.dart';
import '../../data/model/tip_model.dart';
import 'custom_learn_filter_row.dart';
import 'custom_learn_section.dart';
import 'custom_learn_stats_row.dart';

class LearnScreenBody extends StatefulWidget {
  const LearnScreenBody({super.key});

  @override
  State<LearnScreenBody> createState() => _LearnScreenBodyState();
}

class _LearnScreenBodyState extends State<LearnScreenBody> {
  TipCategory? _selectedCategory;
  Set<int> _savedIndices = {};

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  void _loadSaved() {
    final raw = SharedPrefHelper.getString(SharedPrefsKeys.savedKey);
    if (raw.isEmpty) return;
    setState(() {
      _savedIndices =
          raw.split(',').map((e) => int.tryParse(e)).whereType<int>().toSet();
    });
  }

  Future<void> _persistSaved() async {
    await SharedPrefHelper.setString(SharedPrefsKeys.savedKey, _savedIndices.join(','));
  }

  bool get _isSavedFilter => _selectedCategory == TipCategory.saved;

  List<TipCategory> get _visibleCategories {
    if (_isSavedFilter) return [];
    if (_selectedCategory != null) return [_selectedCategory!];
    return TipCategory.values.where((c) => c != TipCategory.saved).toList();
  }

  List<MapEntry<int, TipModel>> get _savedTips =>
      TipsData.all
          .asMap()
          .entries
          .where((e) => _savedIndices.contains(e.key))
          .toList();

  void _onCategorySelected(TipCategory? category) {
    setState(() => _selectedCategory = category);
  }

  void _onToggleSave(int index) {
    setState(() {
      if (_savedIndices.contains(index)) {
        _savedIndices.remove(index);
      } else {
        _savedIndices.add(index);
      }
    });
    _persistSaved();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: const CustomLearnTopBar(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomLearnStatsRow(
              totalTips: TipsData.all.length,
              savedCount: _savedIndices.length,
            ),
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomLearnFilterRow(
              selected: _selectedCategory,
              onSelected: _onCategorySelected,
            ),
          ),
          16.verticalSpace,
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              children: [
                if (_isSavedFilter)
                  CustomLearnSection(
                    category: TipCategory.saved,
                    tips: _savedTips,
                    savedIndices: _savedIndices,
                    onToggleSave: _onToggleSave,
                  )
                else
                  ..._visibleCategories.map((cat) {
                    final tips =
                        TipsData.all
                            .asMap()
                            .entries
                            .where((e) => e.value.category == cat)
                            .toList();
                    return CustomLearnSection(
                      category: cat,
                      tips: tips,
                      savedIndices: _savedIndices,
                      onToggleSave: _onToggleSave,
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
