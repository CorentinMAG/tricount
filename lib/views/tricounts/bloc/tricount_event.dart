part of 'tricount_bloc.dart';

sealed class TricountEvent extends Equatable {
  const TricountEvent();

  @override
  List<Object?> get props => [];
}

class TricountDeletionRequested extends TricountEvent {}
class TricountDeleted extends TricountEvent {}
class TricountToggleFilterMode extends TricountEvent {
  const TricountToggleFilterMode();
}
class TricountSubscriptionRequested extends TricountEvent {
  const TricountSubscriptionRequested();
}
class TricountFilterChanged extends TricountEvent {
  final String? text;

  const TricountFilterChanged(this.text);

  @override
  List<Object?> get props => [text];
}