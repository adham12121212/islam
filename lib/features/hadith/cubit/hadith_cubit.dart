import 'package:bloc/bloc.dart';
import 'package:islam/features/hadith/data/model/hadith_model.dart';
import 'package:islam/features/hadith/data/services/hadith_service.dart';
import 'package:meta/meta.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit() : super(HadithInitial());

  final HadithService _service = HadithService();

  Future<void> getHadith() async {
    emit(HadithLoading());
    try {
      final hadithModel = await _service.getHadith();
      emit(HadithLoaded(hadithModel)); // ✅ no need for `as HadithModel`
    } catch (e) {
      emit(HadithError('Failed to load hadith: $e'));
    }
  }
}
