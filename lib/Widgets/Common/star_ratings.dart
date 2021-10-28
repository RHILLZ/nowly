import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nowly/Configs/configs.dart';


// ignore: must_be_immutable
class StarRatingBar extends StatefulWidget {
  StarRatingBar({
    Key? key,
    this.startCount = 5,
    required this.onRate,
    this.rating = 4.5,
    this.size = 16,
    this.showText = false,
    this.isRatable = false,
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

  final int startCount;
  final Function(double) onRate;
  double rating = 4.5;
  final double size;
  final bool showText;
  final bool isRatable;
  final MainAxisAlignment alignment;

  @override
  _StarRatingBarState createState() => _StarRatingBarState();
}

class _StarRatingBarState extends State<StarRatingBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.alignment,
      children: [
        RatingBar.builder(
          initialRating: widget.rating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: widget.size,
          itemCount: widget.startCount,
          // itemPadding:  const EdgeInsets.symmetric(horizontal: 0.1),
          glowColor: Colors.amber,
          updateOnDrag: true,
          unratedColor: kGray,
          glowRadius: 0.2,
          glow: false,
          ignoreGestures: !widget.isRatable,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              widget.rating = rating;
            });
            widget.onRate(rating);
          },
        ),
        if (widget.showText) Text(" ${widget.rating}")
      ],
    );
  }
}
