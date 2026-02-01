import 'package:flutter/material.dart';

  void autoScroll(ScrollController scrollConteoller, { bool force = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollConteoller.hasClients) return;

      final maxScroll = scrollConteoller.position.maxScrollExtent;

      if (force || scrollConteoller.offset < maxScroll) {
        scrollConteoller.jumpTo(maxScroll + 20);
      }
    });
  }