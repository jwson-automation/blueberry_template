import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PageState {
  final PageController pageController;
  final int pageNumber;

  PageState({
    required this.pageController,
    required this.pageNumber
  });
  PageState copyWith({
    PageController? pageController,
    int? pageNumber
  }) {
    return PageState(
        pageController: pageController ?? this.pageController,
        pageNumber: pageNumber ?? this.pageNumber
    );
  }
}

class PageProviderNotifier extends StateNotifier<PageState> {
  PageProviderNotifier() : super(PageState(pageController: PageController(), pageNumber: 0));

  void moveToPage(int index, {PageController? pageController}) {
    state = state.copyWith(pageNumber: index);
    state.pageController.animateToPage(index, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
  }
}

final pageProvider = StateNotifierProvider.autoDispose<PageProviderNotifier, PageState>((ref){
  return PageProviderNotifier();
});