import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trading_app/utiles/globals.dart' as globals;


class SocketService {
  IO.Socket? _socket;

  bool get isSocketConnected => _socket?.connected ?? false;

 connectSocket(){
   if(globals.socketService.isSocketConnected == false) {
     globals.socketService.initializeSocket(
       globals.socketURL,
       '1733226591004',
     );
   }
 }
  
  void initializeSocket(String url, String userId) {
    _socket = IO.io(
      url,
      <String, dynamic>{
        'transports': ['websocket', 'polling'], 
        'query': {'user_id': userId},           
        'reconnection': true,                
        'reconnectionAttempts': 10,
        'reconnectionDelay': 2000,
      },
    );


    _socket?.on('connect', (_) {
      print('Connected to the socket server with user ID: $userId');
    });
    
    _socket?.on('disconnect', (_) {
      print('Disconnected from the socket server');
    });

    _socket?.on('connect_error', (data) {
      print('Connection Error: $data');
    });

    _socket?.on('connect_timeout', (data) {
      print('Connection Timeout: $data');
    });

    _socket?.on('reconnect', (attempt) {
      print('Reconnected to the server after $attempt attempts');
    });
  }

  void emitEvent(String event, Map<String, dynamic> data) {
    if (_socket?.connected ?? false) {
      _socket?.emit(event, data);
    } else {
      print('Socket not connected. Cannot emit event.${_socket?.connected}');
    }
  }

  void onEvent(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}