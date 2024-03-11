import 'dart:developer';

import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  initSocketIO() async {
    log("initSocketIO");
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    log(token);
    Map<String, String>? headers;
    headers = ({"Authorization": "Bearer $token"});
    headers = await ApiHelper().GetContentType(headers);
    final socket = IO.io(
      "https://${ApiStringConstants.baseUrl}",
      IO.OptionBuilder()
          .enableForceNew()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .setAuth(headers)
          .build(),
    );
    socket.connect();
    return socket;
  }
}
