part of 'azkar_cubit.dart';

@immutable
abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final List<AzkarModel> azkar;
  AzkarLoaded(this.azkar);
}

class AzkarError extends AzkarState {
  final String message;
  AzkarError(this.message);
}
