import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/services/tricount_service.dart';

part 'tricount_event.dart';
part 'tricount_state.dart';

class TricountBloc extends Bloc<TricountEvent, TricountState> {
  final TricountService _repository;
  TricountBloc({required repository})
      : _repository = repository,
        super(const TricountState()) {
    on<TricountFilterChanged>(_onFilterChanged);
    on<TricountSubscriptionRequested>(_onSubscriptionRequested);
    on<TricountToggleFilterMode>(_onToggleFilterMode);
  }

  void _onFilterChanged(TricountFilterChanged event, emit) {
    emit(state.copyWith(filter: event.text));
  }

  Future<void> _onSubscriptionRequested(TricountSubscriptionRequested event, Emitter<TricountState> emit) async {
    emit(state.copyWith(status: TricountsStatus.loading));

    await _repository.fetch();

    await emit.forEach<List<Tricount>>(
      _repository.get(),
      onData: (tricounts) => state.copyWith(status: TricountsStatus.success, tricounts: tricounts),
      onError: (_, __) => state.copyWith(status: TricountsStatus.failure)
    );

  }

  void _onToggleFilterMode(event, emit) {
    emit(state.copyWith(search: !state.search, filter: ""));
  }
}
