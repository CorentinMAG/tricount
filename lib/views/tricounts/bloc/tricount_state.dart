part of 'tricount_bloc.dart';

enum TricountsStatus { initial, loading, success, failure }


final class TricountState extends Equatable {
  const TricountState({
    this.status = TricountsStatus.initial,
    this.tricounts = const [],
    this.filter = "",
    this.search = false
  });

  final TricountsStatus status;
  final List<Tricount> tricounts;
  final String filter;
  final bool search;

  TricountState copyWith({
    TricountsStatus? status,
    List<Tricount>? tricounts,
    String? filter,
    bool? search
  }) {
    return TricountState(
      status: status ?? this.status,
      tricounts: tricounts ?? this.tricounts,
      filter: filter ?? this.filter,
      search: search ?? this.search
    );
  }

  List<Tricount> get filteredTricounts => filter != "" ? tricounts.where((t) => t.title.toLowerCase().startsWith(filter!.toLowerCase())).toList() : tricounts;

  @override
  List<Object?> get props => [status, tricounts, filter, search];
}
