import 'package:flutter/material.dart';
import '../../domain/entities/training_entity.dart';

class AudienceProfileWidget extends StatelessWidget {
  final TrainingEntity? training;

  const AudienceProfileWidget({super.key, this.training});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Audience profile"));
  }
}
