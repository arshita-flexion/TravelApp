// ignore_for_file: strict_top_level_inference
import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CheckConnectionCubit extends Cubit<CheckConnectionStates> {
  CheckConnectionCubit() : super(CheckConnectionLoading());

  static CheckConnectionCubit get(context) => BlocProvider.of(context);

  final _connectivity = Connectivity();
  bool? hasConnection;

  Future<void> initializeConnectivity() async {
    _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        _connectionChange(result);
      }
    });
    for (var result in await _connectivity.checkConnectivity()) {
      _checkConnection(result);
    }
  }

  void _connectionChange(ConnectivityResult result) {
    _checkConnection(result);
  }

  Future<bool?> _checkConnection(ConnectivityResult result) async {
    bool? previousConnection;
    if (kIsWeb) {
      hasConnection = true;
      _connectionChangeController(hasConnection!);
    }
    if (hasConnection != null) {
      previousConnection = hasConnection!;
    }

    if (result == ConnectivityResult.none) {
      hasConnection = false;
      if (previousConnection != hasConnection) {
        _connectionChangeController(hasConnection!);
      }
      return hasConnection;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        if (hasConnection == null) {
          hasConnection = false;
          _connectionChangeController(hasConnection!);
        }
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      _connectionChangeController(hasConnection!);
    }

    return hasConnection;
  }

  bool isNetDialogShow = false;

  void _connectionChangeController(bool hasConnection) {
    if (hasConnection) {
      emit(InternetConnected());
    } else {
      emit(InternetDisconnected());
    }
  }

  /*
  void showInternetDialog({required bool canDismiss, required bool isConnected}){

    if(!isConnected){
      emit(InternetDisconnected());
      isNetDialogShow = true;
      OneContext().showDialog(
          barrierDismissible: canDismiss ? true : false,
          builder: (_) => WillPopScope(
            onWillPop: () async {  return canDismiss ? true : false; },
            child: AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.not_interested),
                  Text('not_net_title'.tr(),style: const TextStyle(fontSize: 20.0),)
                ],
              ),
              content: Text('not_net_msg'.tr(),style: const TextStyle(fontSize: 14.0,color: Colors.grey),),
            ),
          ),
      );

    }
    else{
      emit(InternetConnected());
      if(isNetDialogShow)
      {
        OneContext().popDialog();
        isNetDialogShow = false;

      }
    }

  }
*/
}
