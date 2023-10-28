import 'package:flutter/material.dart';
import 'package:tricount/screens/tricount.dart';

class TriCountTile extends StatelessWidget {
  const TriCountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TricountScreen())),
      child: const Card(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image(
                  image: AssetImage("assets/images/money-bag.png"),
                  width: 60.0,
                  height: 60.0,
                ),
              ),
              SizedBox(
                width: 35.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My first Tricount !",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      "Created by: Corentin MAGYAR",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "This is my first tricount and I'm so happy to share it with my best friends",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Chip(
                        backgroundColor: Colors.amber,
                        label: const Text("Holidays",
                            style: TextStyle(fontSize: 12)),
                        avatar: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/hollidays.png"),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.lightBlue,
                        label: const Text("4 Peoples",
                            style: TextStyle(fontSize: 12)),
                        avatar: Icon(Icons.people)
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
