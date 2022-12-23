import 'dart:io';

import 'package:zamongcampus/src/config/size_config.dart';

//가로패딩 값.(사용중->옮길예정)
double kHorizontalPadding = getProportionateScreenWidth(20);

// server
// final devServer = Platform.isAndroid
//     ? "https://52d6-222-235-213-23.jp.ngrok.io"
//     : "https://52d6-222-235-213-23.jp.ngrok.io";

// final devServer =
//     Platform.isAndroid ? "http://10.0.2.2:8080" : "http://localhost:8080";

final devServer =
    Platform.isAndroid ? "http://43.201.34.37:8080" : "http://43.201.34.37:8080";


