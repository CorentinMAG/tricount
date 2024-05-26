import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tricount/views/tricounts/edit/bloc/edit_bloc.dart';

class TricountImagePicker extends StatelessWidget {
  String? imageUrl;
  final picker = ImagePicker();
  TricountImagePicker({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.0,
        height: 100.0,
        child: BlocBuilder<EditTricountBloc, EditTricountState>(
            builder: (context, state) {
          if (state.tricount.image == null) {
            return DottedBorder(
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.image_outlined, size: 60.0),
                  onPressed: () async {
                    final imageFile = await picker.pickImage( source: ImageSource.gallery, maxHeight: 300.0, maxWidth: 300.0);
                    final image = await imageFile?.readAsBytes();
                    if (image != null) {
                    context.read<EditTricountBloc>().add(EditTricountImageChanged(image));
                    }
                  },
                  disabledColor: Colors.white54,
                ),
              ),
            );
          } else {
            if (imageUrl != null) {
              return GestureDetector(
                onTap: () async {
                    final imageFile = await picker.pickImage( source: ImageSource.gallery, maxHeight: 300.0, maxWidth: 300.0);
                    final image = await imageFile?.readAsBytes();
                    if (image != null) {
                    context.read<EditTricountBloc>().add(EditTricountImageChanged(image));
                    }
                  },
                child: Image.network(state.tricount.imageName!,
                    width: 60.0, height: 60.0, fit: BoxFit.cover),
              );
            } else {
              return GestureDetector(
                onTap: () async {
                    final imageFile = await picker.pickImage( source: ImageSource.gallery, maxHeight: 300.0, maxWidth: 300.0);
                    final image = await imageFile?.readAsBytes();
                    if (image != null) {
                    context.read<EditTricountBloc>().add(EditTricountImageChanged(image));
                    }
                  },
                child: Image.memory(state.tricount.image!,
                    width: 60.0, height: 60.0, fit: BoxFit.cover),
              );
            }
          }
        }));
  }
}
