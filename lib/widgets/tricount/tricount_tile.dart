import 'package:flutter/material.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/screens/tricount.dart';
import 'package:tricount/utils/constants.dart';
import 'package:tricount/widgets/tricount/label.dart';

class TricountTile extends StatelessWidget {
  final Tricount tricount;
  const TricountTile({super.key, required this.tricount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TricountScreen())),
      child: Card(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tricount.imageName != null ?
              ClipOval(
                child: Image.network('${Environment.baseUrl.toString()}${tricount.uri}/${tricount.imageName}', fit: BoxFit.cover, width: 60.0, height: 60.0,)
              ) : 
              const ClipOval(
                child: Image(image: AssetImage("assets/images/money-bag.png"), width: 60.0, height: 60.0)
              ),
              const SizedBox(
                width: 35.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tricount.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      "Created by: ${tricount.owner.username}",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      tricount.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Label(label: tricount.label),
                      Chip(
                        backgroundColor: Colors.lightBlue,
                        label: Text("${tricount.users.length + 1} Peoples",
                            style: const TextStyle(fontSize: 12)),
                        avatar: const Icon(Icons.people)
                      )
                    ]),
                  ],
                ),
              )
            ]),
      )),
    );
  }
}
