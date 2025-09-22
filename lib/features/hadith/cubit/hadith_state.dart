part of 'hadith_cubit.dart';

@immutable
sealed class HadithState {}

final class HadithInitial extends HadithState {}

final class HadithLoading extends HadithState {}

final class HadithLoaded extends HadithState {
  final HadithModel hadithModel;
  HadithLoaded(this.hadithModel);
}

final class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}
