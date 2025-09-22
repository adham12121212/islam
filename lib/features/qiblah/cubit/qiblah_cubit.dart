// lib/features/qibla/cubit/qibla_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:islam/features/qiblah/cubit/qiblah_state.dart';
import 'package:permission_handler/permission_handler.dart';


class QiblaCubit extends Cubit<QiblaState> {
  Stream<QiblahDirection>? _qiblahStream;
  StreamSubscription? _qiblahSubscription;

  QiblaCubit() : super(QiblaInitial());

  Future<void> checkLocationPermission() async {
    emit(QiblaLoading());

    try {
      var status = await Permission.locationWhenInUse.status;
      if (!status.isGranted) {
        final result = await Permission.locationWhenInUse.request();
        if (!result.isGranted) {
          emit(QiblaError("Location permission is required"));
          return;
        }
      }

      final locationStatus = await FlutterQiblah.checkLocationStatus();
      if (!locationStatus.enabled) {
        emit(QiblaError("Please enable Location services"));
        return;
      }

      _qiblahStream = FlutterQiblah.qiblahStream;
      _listenToQiblahStream();

    } catch (e) {
      emit(QiblaError("Error: $e"));
    }
  }

  void _listenToQiblahStream() {
    _qiblahSubscription?.cancel();
    _qiblahSubscription = _qiblahStream?.listen((qiblahData) {
      emit(QiblaLoaded(qiblahData));
    }, onError: (error) {
      emit(QiblaError("Error: $error"));
    });
  }

  @override
  Future<void> close() {
    _qiblahSubscription?.cancel();
    FlutterQiblah().dispose();
    return super.close();
  }
}