import 'package:flutter/material.dart';

Color background = Color(0xFF211e2f);
Color darkBackground = Color(0xFF191524);
Color secondaryBackground = Color(0xFF272335);
Color thirdBackground = Color(0xFF322f42);
Color secondaryText = Color(0xFF7d7a8b);
Color blueText = Color(0xFF51abd4);
Color darkBlue = Color(0xFF2986a4);
Color gradientGreen = Color(0xFF34ae97);
Color paletteBlue = Color(0xFF50a7b4);
Color paletteGreen = Color(0xFF0d3333);
Color grey = Colors.blueGrey;

Gradient blueGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Colors.lightBlue[300],
      Colors.lightBlue[400],
      Colors.lightBlue[500]
    ],
    stops: [
      0.4, 0.6, 1
    ]
);

Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF34ae97),
      Color(0xFF2986a4),
    ],
    stops: [
      0.2, 0.7
    ]
);

Gradient buttonGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF36b29b),
      Color(0xFF2b89a8),
    ],
    stops: [
      0.3, 0.7
    ]
);

Gradient darkblueGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF1e3c72).withOpacity(0.75),
      Color(0xFF1e3c72),
    ],
    stops: [
      0.1, 1.5,
    ]
);

Gradient greyGradient = LinearGradient(
    colors: [
      const Color(0x36FFFFFF),
      const Color(0x0FFFFFFF)
    ],
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight
);

Gradient greyMessage = LinearGradient(
    colors: [
      const Color(0x1AFFFFFF),
      const Color(0x1AFFFFFF)
    ],
);

Gradient blueMessage = LinearGradient(
    colors: [
      const Color(0xFF3895cf),
      const Color(0xFF38a4cf)
    ],
    begin: FractionalOffset.centerLeft,
    end: FractionalOffset.centerRight,
    stops: [
    0.4, 1,
    ]
);

