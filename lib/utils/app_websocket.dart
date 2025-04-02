import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStateType { connected, disconnected, connecting, error }

class AppWebSocket {
  static int _counter = 1;
  static ConnectionStateType connectionState = ConnectionStateType.disconnected;
  static String database = '';
  WebSocketChannel? _channel;
  final StreamController<ConnectionStateType> _connectionStateController =
      StreamController.broadcast();
  final StreamController<String> messageBroadcast =
      StreamController.broadcast();

  Stream<ConnectionStateType> get connectionStream =>
      _connectionStateController.stream;
  var _host = '';
  Function(Map<String, dynamic>)? _callerHandleMessage;

  AppWebSocket() {
    _connect();
  }

  void _connect() {
    if (prefs.string('serveraddress').isEmpty) {

      if (kDebugMode) {
        print('Websocket address not configured');
      }
      Future.delayed(const Duration(seconds: 5)).then((_) {
        _connect();
      });
      return;
    }
    if (!(Prefs.config['use_websocket'] ?? false)) {
      if (kDebugMode) {
        print('Websocket not used');
      }
      Future.delayed(const Duration(seconds: 15)).then((_) {
        _connect();
      });
      return;
    }
    if (connectionState == ConnectionStateType.connected ||
        connectionState == ConnectionStateType.connecting) {
      return;
    }

    _host = prefs.string('serveraddress');
    if (_host.contains('https')) {
      _host = _host.substring(8);
      _host = 'wss://$_host/ws';
    } else if (_host.contains('http')) {
      _host = _host.substring(7);
      _host = 'ws://$_host/ws';
    } else {
      _host = 'wss://$_host/ws';
    }

    if (kDebugMode) {
      print('Connecting to: $_host');
    }
    _setConnectionState(ConnectionStateType.connecting);
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_host));
      _channel?.stream.listen(_handleMessage, onError: (e) {
        if (kDebugMode) {
          print('Error on $_host: $e');
        }
        _replyMessage({'errorCode': -10, 'errorMessage': e.toString()});
        _closeChannel();
        _setConnectionState(ConnectionStateType.error);
        _socketDisconnected();
      }, onDone: _socketDisconnected);
      if (kDebugMode) {
        print('Connected to: $_host');
      }
      _replyMessage({'errorCode': -12, 'errorMessage': 'Reconnected'});
      _setConnectionState(ConnectionStateType.connected);
      sendMessage(
          jsonEncode({
            'command': 'register_socket',
            'socket_type': 4,
            'userid': 0,
            'database': database
          }));
    } catch (e) {
      _replyMessage({'errorCode': -10, 'errorMessage': e.toString()});
      _closeChannel();
      _setConnectionState(ConnectionStateType.error);
      _reconnect();
    }
  }

  void _setConnectionState(ConnectionStateType t) {
    connectionState = t;
    _connectionStateController.add(t);
  }

  void _socketDisconnected() {
    if (kDebugMode) {
      print('Websocket disconnected');
    }
    _closeChannel();
    _connectionStateController.add(ConnectionStateType.disconnected);
    _replyMessage(_makeErrorMsg('Websocket disconnected'));
    _reconnect();
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      _connect();
    });
  }

  void _closeChannel() {
    _channel?.sink.close();
    _channel = null;
    connectionState = ConnectionStateType.disconnected;
  }

  void _replyMessage(Map<String, dynamic> reply) {
    if (_callerHandleMessage != null) {
      _callerHandleMessage!(reply);
      _callerHandleMessage = null;
    }
  }

  void _handleMessage(dynamic msg) {
    if (kDebugMode) {
      print('Websocket message: $msg');
    }
    _replyMessage(jsonDecode(msg));
  }

  int messageId() {
    return _counter++;
  }

  Map<String, dynamic> _makeErrorMsg(String error) {
    return {"errorCode": -10, "errorMessage": error};
  }

  Future<Map<String, dynamic>> sendMessage(String msg) async {
    if (connectionState != ConnectionStateType.connected || _channel == null) {
      return _makeErrorMsg('Service unavailable: -10');
    }

    final completer = Completer<Map<String, dynamic>>();
    final int id = messageId();

    _callerHandleMessage = (Map<String, dynamic> reply) {
      if (!completer.isCompleted) {
        completer.complete(reply);
      }
    };

    try {
      if (kDebugMode) {
        print(msg);
      }
      _channel?.sink.add(msg);
      return completer.future;
    } catch (e) {
      _setConnectionState(ConnectionStateType.error);
      _socketDisconnected();
      return _makeErrorMsg(e.toString());
    }
  }

}
