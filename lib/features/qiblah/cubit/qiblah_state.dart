// lib/features/qibla/cubit/qibla_state.dart
import 'package:flutter_qiblah/flutter_qiblah.dart';

abstract class QiblaState {}

class QiblaInitial extends QiblaState {}

class QiblaLoading extends QiblaState {}

class QiblaLoaded extends QiblaState {
  final QiblahDirection qiblahData;

  QiblaLoaded(this.qiblahData);
}

class QiblaError extends QiblaState {
  final String message;

  QiblaError(this.message);
}