import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/services/authentication_service.dart';
import 'package:tricount/services/tricount_service.dart';
import 'package:tricount/views/tricounts/edit/bloc/edit_bloc.dart';
import 'package:tricount/widgets/image_picker.dart';

class EditTricountScreen extends StatelessWidget {
  const EditTricountScreen({super.key});

  static Route<void> route({Tricount? tricount}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider<EditTricountBloc>(
        create: (context) => EditTricountBloc(
            repository: context.read<TricountService>(),
            tricount: tricount,
            user: context.read<AuthenticationService>().currentUser!),
        child: const EditTricountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EditTricountView();
  }
}

class EditTricountView extends StatelessWidget {
  EditTricountView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTricountBloc>().state;

    return BlocListener<EditTricountBloc, EditTricountState>(
      listener: (context, state) {
        if (state.status == EditTricountStatus.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state.status == EditTricountStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Tricount ${state.tricount.title} has been created !")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: state.tricount.id == null ? const Text("New Tricount") : const Text("Update Tricount"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TricountImagePicker(imageUrl: state.tricount.imageName),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autofocus: true,
                    maxLength: 30,
                    initialValue: state.tricount.title,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) => context.read<EditTricountBloc>().add(
                          EditTricountTitleChanged(value),
                        ),
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: "Title..."),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9\s]'))
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "Choose a label:",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int idx) =>
                          context.read<EditTricountBloc>().add(
                                EditTricountLabelChanged(idx),
                              ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.blue[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.blue[200],
                      color: Colors.blue[400],
                      isSelected: state.labels,
                      children: [
                        Image.asset("assets/images/event.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/holiday.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/other.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/project.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/trip.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/work.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    maxLength: 200,
                    initialValue: state.tricount.description,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) => context.read<EditTricountBloc>().add(
                          EditTricountDescriptionChanged(value),
                        ),
                    maxLines: 5,
                    decoration:
                        const InputDecoration(hintText: "Description..."),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    "Currency:",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int idx) =>
                          context.read<EditTricountBloc>().add(
                                EditTricountCurrencyChanged(idx),
                              ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.blue[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.blue[200],
                      color: Colors.blue[400],
                      isSelected: state.currencies,
                      children: [
                        Image.asset("assets/images/euro.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/dollar.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: ElevatedButton(
                        onPressed: state.status == EditTricountStatus.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<EditTricountBloc>().add(
                                        EditTricountSubmitted(),
                                      );
                                }
                              },
                        child: const Text("Create tricount"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
