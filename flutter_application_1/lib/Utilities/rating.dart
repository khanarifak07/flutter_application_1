import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/app_theme.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final bool isOverAll;
  const ProductRating({
    required this.rating,
    super.key,
    required this.isOverAll,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor(); // Number of full stars
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Whether to show a half star
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0); // Remaining stars

    return Row(
      children: [
        Row(
          children: List.generate(fullStars, (i) {
            return Icon(Icons.star,
                color: AppTheme.ratingColor, size: isOverAll ? 22.rs : 18.rs);
          }),
        ),
        if (hasHalfStar)
          Icon(Icons.star_half,
              color: AppTheme.ratingColor, size: isOverAll ? 22.rs : 18.rs),
        Row(
          children: List.generate(emptyStars, (i) {
            return Icon(Icons.star_border,
                color: AppTheme.ratingColor, size: isOverAll ? 22.rs : 18.rs);
          }),
        ),
        SizedBox(width: 5.rw),
        Text(
          isOverAll ? rating.toString() : rating.toString().substring(0, 0),
          style: AppTheme.subtitle,
        ),
      ],
    );
  }
}
