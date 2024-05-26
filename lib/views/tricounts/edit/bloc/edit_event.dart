part of 'edit_bloc.dart';

sealed class EditTricountEvent extends Equatable {
  const EditTricountEvent();

  @override
  List<Object> get props => [];
}

class EditTricountSubmitted extends EditTricountEvent {}

class EditTricountTitleChanged extends EditTricountEvent {
  final String title;

  const EditTricountTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class EditTricountDescriptionChanged extends EditTricountEvent {
  final String description;

  const EditTricountDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class EditTricountLabelChanged extends EditTricountEvent {
  final int idx;

  const EditTricountLabelChanged(this.idx);

  @override
  List<Object> get props => [idx];
}

class EditTricountCurrencyChanged extends EditTricountEvent {
  final int idx;

  const EditTricountCurrencyChanged(this.idx);

  @override
  List<Object> get props => [idx];
}

class EditTricountImageChanged extends EditTricountEvent {
  final Uint8List image;

  const EditTricountImageChanged(this.image);

  @override
  List<Object> get props => [image];
}
