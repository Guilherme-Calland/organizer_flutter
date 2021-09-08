import 'package:flutter/material.dart';

void main() => runApp(Organizer());

class Organizer extends StatelessWidget{
    @override
    Widget build(_){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: Center(
                    child: Text(
                        'Organizer',
                        style: TextStyle(fontSize: 40),
                    ),
                ),
            ),
        );
    }
}