import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_suggestion_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "البحث",
        action: Container(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset("assets/icons/shopping-cart.svg"),
        ),
      ),
      body: AppPagePadding(
        child: Column(
          children: [
            Padding12,
            SearchWidget(
              controller: _controller,
              onChanged: (value) {
                ref.read(searchProvider.notifier).onQueryChanged(value);
              },
              onClear: () {
                _controller.clear();
                ref.read(searchProvider.notifier).clearSearch();
              },
            ),
            const SizedBox(height: 16),

            if (state.isLoading) const Center(child: CustomLoading()),

            if (!state.isLoading &&
                state.query.trim().isNotEmpty &&
                state.suggestions.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: SuggestionWidget(
                    suggestions: state.suggestions,
                    onTapSuggestion: (item) {
                      _controller.text = item.name;
                      ref
                          .read(searchProvider.notifier)
                          .onQueryChanged(item.name);
                    },
                  ),
                ),
              ),

            // if (!state.isLoading &&
            //     state.query.trim().isNotEmpty &&
            //     state.suggestions.isEmpty)
            //   const EmptyDataWidget(
            //     text: "لاتوجد نتائج في البحث!",
            //     img: "assets/icons/Object.svg",
            //   ),
          ],
        ),
      ),
    );
  }
}
