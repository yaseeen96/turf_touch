import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class TurfTouchBottomBar extends StatefulWidget {
  const TurfTouchBottomBar({super.key});

  @override
  State<TurfTouchBottomBar> createState() => _TurfTouchBottomBarState();
}

class _TurfTouchBottomBarState extends State<TurfTouchBottomBar> {
  int _index = 0;
  void goToScreen(int index) async {
    if (index == 0) {
      context.go("/home");
    } else if (index == 1) {
      context.go("/search");
    } else if (index == 2) {
      context.go("/notifications");
    } else if (index == 3) {
      context.go("/profile");
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: IconButton(onPressed: () {}, icon: Icon(Icons.history))),
          Expanded(
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.notification_add))),
        ],
      ),
    );
    // return BottomNavigationBar(
    //     currentIndex: _index,
    //     onTap: (index) {
    //       setState(() {
    //         _index = index;
    //       });
    //       goToScreen(index);
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //         label: "Home",
    //         icon: Icon(
    //           Icons.home,
    //         ),
    //       ),
    //       BottomNavigationBarItem(
    //         label: "Notificatins",
    //         icon: Icon(
    //           Icons.notification_important,
    //         ),
    //       ),
    //       BottomNavigationBarItem(
    //         label: "My bookings",
    //         icon: Icon(
    //           Icons.history,
    //         ),
    //       ),
    //       BottomNavigationBarItem(
    //         label: "My Profile",
    //         icon: Icon(
    //           Icons.man,
    //         ),
    //       )
    //     ]);
  }
}
