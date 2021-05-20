import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  const AuthButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text(
          "Авторизоваться",
              style: TextStyle(
            color: Colors.white
        ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Color(0xFF3985c0),
        onPressed: (){
          
        },
      ),
    );
  }
}