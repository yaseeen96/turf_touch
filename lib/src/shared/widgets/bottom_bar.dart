import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/shared/providers/bottom_bar_index_provider.dart';

class TurfTouchBottomBar extends ConsumerWidget {
  const TurfTouchBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomBarIndexProvider);
    void onNotificationPress() {
      ref.read(bottomBarIndexProvider.notifier).state = 2;
      context.go("/notifications");
    }

    void onHistoryPress() {
      ref.read(bottomBarIndexProvider.notifier).state = 0;
      context.go("/history");
    }

    return BottomAppBar(
      color: CTheme.of(context).theme.backgroundInverse,
      child: SizedBox(
        height: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: onHistoryPress,
                icon: Icon(Icons.receipt,
                    color: (index == 0)
                        ? CTheme.of(context).theme.primaryColor
                        : CTheme.of(context).theme.backgroundColor),
              ),
            ),
            Expanded(
                child: IconButton(
              onPressed: onNotificationPress,
              icon: Icon(
                Icons.notifications,
                color: (index == 2)
                    ? CTheme.of(context).theme.primaryColor
                    : CTheme.of(context).theme.backgroundColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
