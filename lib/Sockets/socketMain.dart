import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  static late IO.Socket socketHelper;
  static initSocketIO() async {
    log("initSocketIO");
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    log(token);
    Map<String, String>? headers;
    headers = ({"Authorization": "Bearer $token"});
    headers = await ApiHelper().GetContentType(headers);
    final socket = IO.io(
      "http://${ApiStringConstants.baseUrl}",
      IO.OptionBuilder()
          .enableForceNew()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .setAuth(headers)
          .build(),
    );
    socket.connect();
    socketHelper = socket;
    log("Socket Connected", name: socketHelper.toString());
  }
}
