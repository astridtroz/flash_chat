import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {

  String title;
  Color color;

  String id;

  RoundedButton({super.key, required this.title, required this.color, required this.id });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (){
            Navigator.pushNamed(context, id);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
