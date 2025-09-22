part of 'azan_page_cubit.dart';


sealed class AzanPageState {}

final class AzanPageInitial extends AzanPageState {}

final class AzanPageLoading extends AzanPageState {}

final class AzanPageLoaded extends AzanPageState {
  final List<AzanModel> prayerTimes;
  final AzanModel nextPrayer;
  final String city;
  final String country;

  AzanPageLoaded({
    required this.prayerTimes,
    required this.nextPrayer,
    required this.city,
    required this.country,
  });
}

final class AzanPagePlaying extends AzanPageState {
  final AzanModel prayer;
  AzanPagePlaying(this.prayer);
}

final class AzanPageError extends AzanPageState {
  final String error;
  AzanPageError(this.error);
}
