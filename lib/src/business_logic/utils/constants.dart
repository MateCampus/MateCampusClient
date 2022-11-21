import 'dart:io';

import 'package:zamongcampus/src/config/size_config.dart';

//가로패딩 값.(사용중->옮길예정)
double kHorizontalPadding = getProportionateScreenWidth(20);

// server
final devServer = Platform.isAndroid
    ? "https://a7c8-106-253-227-235.ngrok.io"
    : "https://a7c8-106-253-227-235.ngrok.io";

// final devServer =
//     Platform.isAndroid ? "http://10.0.2.2:8080" : "http://localhost:8080";

// final devServer =
//     Platform.isAndroid ? "http://3.36.41.198:8080" : "http://3.36.41.198:8080";

const dankookEmail = "@dankook.ac.kr";

const appIdForAgora = "1db42f592687465e9ad1564ae4b55221";
