import 'package:flutter/material.dart';

class OrganizerListFragment extends StatelessWidget {
  final Function() onFabPressed;
  final Widget child;
  OrganizerListFragment({required this.onFabPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          child: Icon(Icons.add),
          onPressed: onFabPressed
        ),
        body: child,
      ),
    );
  }
}
