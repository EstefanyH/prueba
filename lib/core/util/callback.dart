import 'package:flutter/material.dart';

typedef ItemSelectedCallback = void Function(BuildContext ctx, int id, String selectedItem);

class EventInterface {
  final ItemSelectedCallback onItemSelected;

  EventInterface({ required this.onItemSelected});
}