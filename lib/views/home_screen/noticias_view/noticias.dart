import 'package:flutter/material.dart';
import 'package:arena/widgets/styled_card.dart';
import './noticia.dart';

class Noticias extends StatelessWidget {
  const Noticias({
    Key key,
  }) : super(key: key);

  final leading = false;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      title: 'Noticias',
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 2)
            return Noticia(
              leading: leading,
              mainImage:
                  'https://i.pinimg.com/236x/59/77/f2/5977f28d3e23f3a6268cfb3e45325c93--xabi-alonso-vintage-football.jpg',
            );
          return Noticia(leading: leading);
        },
        itemCount: 8,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
