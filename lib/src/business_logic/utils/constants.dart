import 'dart:io';

import 'package:zamongcampus/src/config/size_config.dart';

//가로패딩 값.(사용중->옮길예정)
double kHorizontalPadding = getProportionateScreenWidth(20);

// server
// final devServer = Platform.isAndroid
//     ? "https://52d6-222-235-213-23.jp.ngrok.io"
//     : "https://52d6-222-235-213-23.jp.ngrok.io";

// final devServer =
//     Platform.isAndroid ? "http://172.30.1.22:8080" : "http://172.30.1.22:8080";

final devServer = Platform.isAndroid
    ? "https://matecampus.duckdns.org:8080"
    : "https://matecampus.duckdns.org:8080";
