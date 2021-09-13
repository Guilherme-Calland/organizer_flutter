import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;
import 'organizer_container.dart';

class OrganizerEntryFragment extends StatelessWidget {
  final Widget child;
  final Function() onCancelPressed;
  final Function() onSavePressed;
  OrganizerEntryFragment({required this.child, required this.onCancelPressed, required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: child),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OrganizerContainer(
                color: values.organizerThemeColor,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onCancelPressed,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'SquadaOne'),
                    ),
                  ),
                ),
                bottomRounded: false,
              ),
              OrganizerContainer(
                color: values.organizerThemeColor,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'SquadaOne'),
                    ),
                  ),
                  onTap: onSavePressed,
                ),
                bottomRounded: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}