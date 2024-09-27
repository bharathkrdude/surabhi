import 'package:flutter/material.dart';

class AppSizes {
  // This function returns the screen width based on the context
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
   
const kHeight10 = SizedBox(height: 10);
const kHeight5 = SizedBox(height: 5);
const kHeight20 = SizedBox(height: 20);
const kHeight25 = SizedBox(height: 25);

const kHeight15 = SizedBox(height: 15);

const kHeight30 = SizedBox(height: 30);
const kHeight35 = SizedBox(height: 35);
const kHeight40 = SizedBox(height: 40);
const kHeight50 = SizedBox(height: 50);
const kWidth5 = SizedBox(width: 5);
const kWidth25 = SizedBox(width: 25);
const kWidth10 = SizedBox(width: 10);
const kWidth15 = SizedBox(width: 15);
const kWidth20 = SizedBox(width: 20);
const kWidth30 = SizedBox(width: 30);
const kWidth40 = SizedBox(width: 40);
const kWidth50 = SizedBox(width: 50);


// Textstyles
class TextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle bodyTextWhite = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
   static const TextStyle bodyTextWhite2 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
static const TextStyle heading3 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle hintTextStyle1 = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  // Add hint text style with grey color
  static const TextStyle hintTextStyle2 = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
  static const TextStyle drawerText = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: Colors.blueGrey,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,  // Hint text color set to grey
  );
 
}

  


