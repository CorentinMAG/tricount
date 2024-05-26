import 'package:flutter/material.dart';
import 'package:tricount/models/enums.dart';

class Label extends StatelessWidget {

  TricountLabel label;
  Label({super.key, required this.label});

  @override
  Widget build(BuildContext context) {

    switch(label) {
      case TricountLabel.event:
        return _buildEventLabel();
      case TricountLabel.holidays:
        return _buildHolidayLabel();
      case TricountLabel.other:
        return _buildOtherLabel();
      case TricountLabel.project:
        return _buildProjectLabel();
      case TricountLabel.trip:
        return _buildTripLabel();
      case TricountLabel.work:
        return _buildWorkLabel();
      default:
        return _buildOtherLabel();
    }
  }

  Widget _buildEventLabel() {
    return const Chip(
      backgroundColor: Colors.purple,
      label:  Text("Event", style: TextStyle(fontSize: 12)),
      avatar:  CircleAvatar(
        backgroundImage: AssetImage("assets/images/event.png"),
      )
    );
  }

  Widget _buildHolidayLabel() {
    return const Chip(
      backgroundColor: Colors.amber,
      label:  Text("Holiday", style: TextStyle(fontSize: 12)),
      avatar:  CircleAvatar(
        backgroundImage: AssetImage("assets/images/holiday.png"),
      )
    );
  }

  Widget _buildOtherLabel() {
    return Container(
      child: const Chip(
        backgroundColor: Colors.blue,
        label:  Text("Other", style: TextStyle(fontSize: 12)),
        avatar:  CircleAvatar(
          backgroundImage: AssetImage("assets/images/other.png"),
        )
      ),
    );
  }

  Widget _buildProjectLabel() {
    return const Chip(
      backgroundColor: Colors.red,
      label:  Text("Project", style: TextStyle(fontSize: 12)),
      avatar:  CircleAvatar(
        backgroundImage: AssetImage("assets/images/project.png"),
      )
    );
  }

  Widget _buildTripLabel() {
    return const Chip(
      backgroundColor: Colors.green,
      label:  Text("Trip", style: TextStyle(fontSize: 12)),
      avatar:  CircleAvatar(
        backgroundImage: AssetImage("assets/images/trip.png"),
      )
    );
  }

  Widget _buildWorkLabel() {
    return const Chip(
      backgroundColor: Colors.grey,
      label:  Text("Work", style: TextStyle(fontSize: 12)),
      avatar:  CircleAvatar(
        backgroundImage: AssetImage("assets/images/work.png"),
      )
    );
  }
}
