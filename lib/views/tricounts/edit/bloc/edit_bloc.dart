import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tricount/models/enums.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/services/tricount_service.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditTricountBloc extends Bloc<EditTricountEvent, EditTricountState> {

  final TricountService repository;

  EditTricountBloc({
    required this.repository,
    required Tricount? tricount,
    required UserModel user
  }) : super(EditTricountState(
    tricount: tricount ?? Tricount.empty(user),
    )) {
    on<EditTricountSubmitted>(_onSubmitted);
    on<EditTricountTitleChanged>(_onTitleChanged);
    on<EditTricountDescriptionChanged>(_onDescriptionChanged);
    on<EditTricountCurrencyChanged>(_onCurrencyChanged);
    on<EditTricountLabelChanged>(_onLabelChanged);
    on<EditTricountImageChanged>(_onImageChanged);
  }

  Future<void> _onSubmitted(EditTricountSubmitted event, Emitter<EditTricountState> emit) async {

    emit(state.copyWith(status: EditTricountStatus.loading));

    final tricount = state.tricount;

    try {
      await repository.save(tricount);
      emit(state.copyWith(status: EditTricountStatus.success));
    } catch(e) {
      emit(state.copyWith(status: EditTricountStatus.failure, message: e.toString()));
    }
  }

  void _onTitleChanged(EditTricountTitleChanged event, Emitter<EditTricountState> emit) {
    final Tricount tricount = state.tricount.copyWith(title: event.title);
    emit(state.copyWith(tricount: tricount));
  }
  void _onDescriptionChanged(EditTricountDescriptionChanged event, Emitter<EditTricountState> emit) {
    final Tricount tricount = state.tricount.copyWith(description: event.description);
    emit(state.copyWith(tricount: tricount));
  }
  void _onCurrencyChanged(EditTricountCurrencyChanged event, Emitter<EditTricountState> emit) {
    final idx = event.idx;
    final currencies = List.generate(2, (_) => false);
    currencies[idx] = !currencies[idx];
    final Tricount tricount = state.tricount.copyWith(currency: Currency.values[idx]);

    emit(state.copyWith(tricount: tricount, currencies: currencies));
  }
  void _onLabelChanged(EditTricountLabelChanged event, Emitter<EditTricountState> emit) {
    final idx = event.idx;
    final labels = List.generate(6, (_) => false);
    labels[idx] = !labels[idx];
    final Tricount tricount = state.tricount.copyWith(label: TricountLabel.values[idx]);

    emit(state.copyWith(tricount: tricount, labels: labels));
  }

  void _onImageChanged(EditTricountImageChanged event, Emitter<EditTricountState> emit) {
    final Tricount tricount = state.tricount.copyWith(image: event.image);
    emit(state.copyWith(tricount: tricount));
  }
}
