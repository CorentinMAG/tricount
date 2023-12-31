import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  String? imageUrl;
  Avatar({super.key, this.imageUrl});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 300.0, maxWidth: 300.0);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    // try {
    //   final bytes = await imageFile.readAsBytes();
    //   final fileExt = imageFile.path.split(".").last;
    //   final fileName = "${DateTime.now().toIso8601String()}.$fileExt";
    //   // await SupabaseManager.supabase.storage
    //   //     .from("TricountAvatar")
    //   //     .uploadBinary(
    //   //       fileName,
    //   //       bytes,
    //   //       fileOptions: FileOptions(contentType: imageFile.mimeType),
    //   //     );
    //   // final imageUrlResponse = await SupabaseManager.supabase.storage
    //   //     .from("TricountAvatar")
    //   //     .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);
    //   // setState(() {
    //   //   widget.imageUrl = imageUrlResponse;
    //   // });
    // } on StorageException catch (error) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(error.message),
    //       backgroundColor: Theme.of(context).colorScheme.error,
    //     ));
    //   }
    // } catch (error) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: const Text("Unexpected error occured"),
    //       backgroundColor: Theme.of(context).colorScheme.error,
    //     ));
    //   }
    // }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: 
        (widget.imageUrl == null || widget.imageUrl!.isEmpty) ?
          DottedBorder(
              child: Center(
                child: IconButton(
                            icon: const Icon(Icons.image_outlined, size: 60.0),
                            onPressed: _isLoading ? null : _upload,
                            disabledColor: Colors.white54,
                          ),
              ),) :
          GestureDetector(
            onTap: _isLoading ? null : _upload,
            child: Image.network(widget.imageUrl!,
                width: 60.0, height: 60.0, fit: BoxFit.cover),
          )
    );
  }
}
