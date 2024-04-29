import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({Key key}) : super(key: key);

  Color fundoColor = Color.fromARGB(255, 239, 239, 239);
  Color componentColor = Color.fromARGB(255, 40, 78, 121);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: fundoColor,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logoCabecalho.png',
            width: 100, // Ajuste o tamanho conforme necessário
            height: 30,
          ),
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: componentColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
