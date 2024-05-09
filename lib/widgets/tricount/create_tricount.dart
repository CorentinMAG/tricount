import 'package:flutter/material.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/widgets/avatar.dart';

class CreateTricountScreen extends StatefulWidget {
  const CreateTricountScreen({super.key});

  @override
  State<CreateTricountScreen> createState() => _CreateTricountScreenState();
}

class _CreateTricountScreenState extends State<CreateTricountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleControler;
  late final TextEditingController _descriptionController;

  final List<bool> _currencies = [false, true];
  final List<bool> _labels = [true, false, false, false, false, false];

  @override
  void initState() {
    _titleControler = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void onPressedCurrencies(int index) {
    setState(() {
      for (int i = 0; i < _currencies.length; i++) {
        _currencies[i] = i == index;
      }
    });
  }

  void onPressedLabels(int index) {
    setState(() {
      for (int i = 0; i < _labels.length; i++) {
        _labels[i] = i == index;
      }
    });
  }

  void onCreateTricount() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tricount created'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Tricount"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Avatar(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autofocus: true,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _titleControler,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: "Title..."),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
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
                      onPressed: onPressedLabels,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.blue[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.blue[200],
                      color: Colors.blue[400],
                      isSelected: _labels,
                      children: [
                        Image.asset("assets/images/event.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/project.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/work.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/other.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/holiday.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/trip.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    maxLength: 200,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration:
                        const InputDecoration(hintText: "Description..."),
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
                      onPressed: onPressedCurrencies,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.blue[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.blue[200],
                      color: Colors.blue[400],
                      isSelected: _currencies,
                      children: [
                        Image.asset("assets/images/dollar.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                        Image.asset("assets/images/euro.png",
                            width: 40.0, height: 40.0, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: ElevatedButton(
                        onPressed: onCreateTricount,
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
