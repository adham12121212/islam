
import 'package:equatable/equatable.dart';

class TasbihState extends Equatable {
  final int count;
  final String zikr;
  final int? target; // optional (e.g., 33, 100)

  const TasbihState({
    this.count = 0,
    this.zikr = "سُبْحَانَ اللَّهِ",
    this.target,
  });

  TasbihState copyWith({
    int? count,
    String? zikr,
    int? target,
  }) {
    return TasbihState(
      count: count ?? this.count,
      zikr: zikr ?? this.zikr,
      target: target ?? this.target,
    );
  }

  bool get isTargetReached => target != null && count >= target!;

  @override
  List<Object?> get props => [count, zikr, target];
}
