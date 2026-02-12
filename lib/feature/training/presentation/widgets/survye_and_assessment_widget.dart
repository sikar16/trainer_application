import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/survey_bloc/survey_bloc.dart';
import '../bloc/survey_bloc/survey_event.dart';
import '../bloc/survey_bloc/survey_state.dart';
import '../bloc/assessment_bloc/assessment_bloc.dart';
import '../bloc/assessment_bloc/assessment_event.dart';
import '../bloc/assessment_bloc/assessment_state.dart';
import '../../domain/entities/survey_entity.dart';
import '../../domain/entities/assessment_entity.dart';

class SurveyAndAssessment extends StatefulWidget {
  const SurveyAndAssessment({
    super.key,
    this.onHeightChanged,
    required this.trainingId,
  });

  final Function(double)? onHeightChanged;
  final String trainingId;

  @override
  State<SurveyAndAssessment> createState() => _SurveyAndAssessmentState();
}

class _SurveyAndAssessmentState extends State<SurveyAndAssessment> {
  bool isSurveyExpanded = false;
  bool isAssessmentExpanded = false;

  String? selectedSurvey;
  String? selectedAssessment;

  @override
  void initState() {
    super.initState();
    context.read<SurveyBloc>().add(
      GetSurveysEvent(trainingId: widget.trainingId),
    );
    context.read<AssessmentBloc>().add(
      GetAssessmentsEvent(trainingId: widget.trainingId),
    );
  }

  void _notifyHeightChanged() {
    if (widget.onHeightChanged != null) {
      final height = (isSurveyExpanded || isAssessmentExpanded) ? 250.0 : 120.0;
      widget.onHeightChanged!(height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTopButton(
                      title: "Survey Status",
                      isExpanded: isSurveyExpanded,
                      onTap: () {
                        setState(() {
                          isSurveyExpanded = !isSurveyExpanded;
                          isAssessmentExpanded = false;
                        });
                        _notifyHeightChanged();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTopButton(
                      title: "Assessment Scores",
                      isExpanded: isAssessmentExpanded,
                      onTap: () {
                        setState(() {
                          isAssessmentExpanded = !isAssessmentExpanded;
                          isSurveyExpanded = false;
                        });
                        _notifyHeightChanged();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (isSurveyExpanded) _buildSurveyContent(),

              if (isAssessmentExpanded) _buildAssessmentContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }

  Widget _buildSurveyContent() {
    return BlocBuilder<SurveyBloc, SurveyState>(
      builder: (context, state) {
        if (state is SurveyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurveyError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is SurveyLoaded) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedSurvey,
                  hint: const Text("Select survey to view completion status"),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.surveys
                      .map(
                        (survey) => DropdownMenuItem(
                          value: survey.id,
                          child: Text(survey.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSurvey = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  "Shows which students have completed the selected survey",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAssessmentContent() {
    return BlocBuilder<AssessmentBloc, AssessmentState>(
      builder: (context, state) {
        if (state is AssessmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AssessmentError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is AssessmentLoaded) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedAssessment,
                  hint: const Text("Select assessment to view scores"),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.assessments
                      .map(
                        (assessment) => DropdownMenuItem(
                          value: assessment.id,
                          child: Text(assessment.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAssessment = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  "Shows assessment scores for selected assessment",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
