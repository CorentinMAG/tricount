part of 'edit_bloc.dart';

enum EditTricountStatus { initial, loading, success, failure }

final class EditTricountState extends Equatable {
  final Tricount tricount;
  final EditTricountStatus status;
  final String message;

  List<bool> labels;
  List<bool> currencies;

  EditTricountState({
    this.status = EditTricountStatus.initial,
    required this.tricount,
    this.message = "",
    this.labels = const [true, false, false, false, false, false],
    this.currencies = const [true, false]
  });

  EditTricountState copyWith({EditTricountStatus? status, Tricount? tricount, String? message, List<bool>? labels, List<bool>? currencies}) {
    return EditTricountState(status: status ?? this.status, tricount: tricount ?? this.tricount, message: message ?? this.message, labels: labels ?? this.labels, currencies: currencies ?? this.currencies);
  }

  @override
  List<Object?> get props => [tricount, status, labels, currencies];
}
