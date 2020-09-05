import 'package:flutter/material.dart';

class Noticia extends StatelessWidget {
  const Noticia({
    Key key,
    @required this.leading,
    this.mainImage,
  }) : super(key: key);

  final bool leading;
  final String mainImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: leading
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    'https://i.pinimg.com/236x/59/77/f2/5977f28d3e23f3a6268cfb3e45325c93--xabi-alonso-vintage-football.jpg',
                    fit: BoxFit.fill,
                    width: 100,
                  ),
                )
              : Text(
                  '11.18',
                  style: TextStyle(color: Colors.grey),
                ),
          title: Text(
            'Pirlo confirmó que no contará con Gonzalo Higuaín en la Juventus',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (mainImage != null)
          Container(
            padding: EdgeInsets.zero,
            child: Image.network(
              mainImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
      ],
    );
  }
}
