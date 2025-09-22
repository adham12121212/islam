import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../data/model/azkar_model.dart';
import '../data/services/azkar_service.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  final AzkarService _service = AzkarService();

  Future<void> getAzkar() async {
    emit(AzkarLoading());
    try {
      final azkarList = await _service.getAzkar();

      if (azkarList.isEmpty) {
        emit(AzkarError("No Azkar found"));
      } else {
        emit(AzkarLoaded(azkarList));
      }
    } catch (e) {
      emit(AzkarError(e.toString()));
    }
  }
}
