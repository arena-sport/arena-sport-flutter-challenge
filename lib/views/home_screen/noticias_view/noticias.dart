import 'package:flutter/material.dart';
import 'package:arena/widgets/styled_card.dart';
import './noticia.dart';

class Noticias extends StatelessWidget {
  const Noticias({
    Key key,
    this.news,
  }) : super(key: key);

  final news;
  final leading = false;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      title: 'Noticias',
      child: ListView.separated(
        itemBuilder: (context, index) {
          if ((index + 1) % 3 == 0 && index != 0) {
            return Noticia(
              leading: leading,
              displayImage: true,
              article: news[index],
            );
          }
          return Noticia(
            leading: leading,
            article: news[index],
            displayImage: false,
          );
        },
        itemCount: 8,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
