import 'package:flutter/material.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/session_report_remote_data_source.dart';
import '../../data/models/session_report_model.dart';

class ViewReportPage extends StatefulWidget {
  final String sessionId;

  const ViewReportPage({super.key, required this.sessionId});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  int _currentStep = 0;
  bool _isLoading = true;
  String? _error;

  late final SessionReportRemoteDataSource _reportDataSource;
  SessionReportModel? _reportData;

  final TextEditingController _topicsCoveredController =
      TextEditingController();
  final TextEditingController _significantObservationController =
      TextEditingController();
  final TextEditingController _satisfactionController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _positiveFeedbackController =
      TextEditingController();
  final TextEditingController _improvementController = TextEditingController();
  final TextEditingController _specificFeedbackController =
      TextEditingController();

  final TextEditingController _effectivenessController =
      TextEditingController();
  final TextEditingController _strengthsController = TextEditingController();
  final TextEditingController _growthController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();

  final TextEditingController _curriculumController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _assessmentController = TextEditingController();
  final TextEditingController _supportController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reportDataSource = SessionReportRemoteDataSource(sl<ApiClient>());
    _fetchSessionReport();
  }

  @override
  void dispose() {
    _significantObservationController.dispose();
    _topicsCoveredController.dispose();
    _satisfactionController.dispose();
    _summaryController.dispose();
    _positiveFeedbackController.dispose();
    _improvementController.dispose();
    _specificFeedbackController.dispose();
    _effectivenessController.dispose();
    _strengthsController.dispose();
    _growthController.dispose();
    _goalsController.dispose();
    _curriculumController.dispose();
    _deliveryController.dispose();
    _assessmentController.dispose();
    _supportController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  Future<void> _fetchSessionReport() async {
    try {
      final reportData = await _reportDataSource.getSessionReport(
        widget.sessionId,
      );
      setState(() {
        _reportData = reportData;
        _isLoading = false;
        _populateControllers();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _populateControllers() {
    if (_reportData == null) return;

    _topicsCoveredController.text = _reportData!.topicsCovered.isNotEmpty
        ? _reportData!.topicsCovered.join(', ')
        : 'No topics covered';
    _significantObservationController.text =
        _reportData!.significantObservations.isNotEmpty
        ? _reportData!.significantObservations.join(', ')
        : 'No significant observations';
    _satisfactionController.text =
        '${_reportData!.overallSatisfactionScore.toString()} - ${_getSatisfactionText(_reportData!.overallSatisfactionScore)}';
    _summaryController.text = _reportData!.learnerFeedbackSummary.isNotEmpty
        ? _reportData!.learnerFeedbackSummary
        : 'No summary available';
    _positiveFeedbackController.text = _reportData!.positiveFeedback.isNotEmpty
        ? _reportData!.positiveFeedback
        : 'No positive feedback';
    _improvementController.text = _reportData!.areasForImprovement.isNotEmpty
        ? _reportData!.areasForImprovement
        : 'No areas for improvement';
    _specificFeedbackController.text =
        _reportData!.specificFeedbackExamples.isNotEmpty
        ? _reportData!.specificFeedbackExamples
        : 'No specific feedback examples';

    _effectivenessController.text =
        '${_reportData!.teachingMethodEffectiveness.toString()} - ${_getEffectivenessText(_reportData!.teachingMethodEffectiveness)}';
    _strengthsController.text = _reportData!.trainerStrengths.isNotEmpty
        ? _reportData!.trainerStrengths
        : 'No strengths identified';
    _growthController.text = _reportData!.trainerAreasForGrowth.isNotEmpty
        ? _reportData!.trainerAreasForGrowth
        : 'No areas for growth';
    _goalsController.text = _reportData!.trainerProfessionalGoals.isNotEmpty
        ? _reportData!.trainerProfessionalGoals
        : 'No professional goals';

    _curriculumController.text =
        _reportData!.curriculumRecommendations.isNotEmpty
        ? _reportData!.curriculumRecommendations
        : 'No curriculum recommendations';
    _deliveryController.text =
        _reportData!.deliveryMethodRecommendations.isNotEmpty
        ? _reportData!.deliveryMethodRecommendations
        : 'No delivery method recommendations';
    _assessmentController.text =
        _reportData!.assessmentRecommendations.isNotEmpty
        ? _reportData!.assessmentRecommendations
        : 'No assessment recommendations';
    _supportController.text =
        _reportData!.learnerSupportRecommendations.isNotEmpty
        ? _reportData!.learnerSupportRecommendations
        : 'No learner support recommendations';
    _otherController.text = _reportData!.otherRecommendations.isNotEmpty
        ? _reportData!.otherRecommendations
        : 'No other recommendations';
  }

  String _getSatisfactionText(double score) {
    if (score >= 4.5) return 'Very Satisfied';
    if (score >= 3.5) return 'Satisfied';
    if (score >= 2.5) return 'Neutral';
    if (score >= 1.5) return 'Dissatisfied';
    return 'Very Dissatisfied';
  }

  String _getEffectivenessText(double score) {
    if (score >= 4.5) return 'Very Effective';
    if (score >= 3.5) return 'Effective';
    if (score >= 2.5) return 'Moderately Effective';
    if (score >= 1.5) return 'Somewhat Effective';
    return 'Not Effective';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("View Session Report"),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading report',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _fetchSessionReport,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => _buildStepIndicator(index, context),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildStepContent(),

                  const SizedBox(height: 32),

                  _buildNavigationButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildStepIndicator(int index, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    bool isActive = index == _currentStep;
    bool isCompleted = index < _currentStep;

    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive || isCompleted
              ? colorScheme.primary
              : colorScheme.outlineVariant,
          child: Text(
            (index + 1).toString(),
            style: textTheme.labelLarge?.copyWith(
              color: isActive || isCompleted
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 2,
          color: isCompleted ? colorScheme.primary : colorScheme.outlineVariant,
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return _buildStep1();
    }
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _currentStep--;
              });
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Back"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        else
          const SizedBox(width: 120),

        if (_currentStep < 4)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _currentStep++;
              });
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        else
          ElevatedButton.icon(
            onPressed: () {
              _saveReportData();
              Navigator.pop(context);
            },
            label: const Text("Save "),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
      ],
    );
  }

  void _saveReportData() {}

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Summary of Training Sessions Conducted",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Topics Covered",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _topicsCoveredController,
              readOnly: true,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Significant Observation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _significantObservationController,
              readOnly: true,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Learner Feedback and Satisfaction",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overall Satisfaction Score",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _satisfactionController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Summary of Learner Feedback",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _summaryController,
              readOnly: true,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Positive Feedback",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _positiveFeedbackController,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Areas for Improvement",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _improvementController,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Specific Feedback Examples",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _specificFeedbackController,
              readOnly: true,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Self-Reflection on Teaching Practices",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Effectiveness of Teaching Methods",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _effectivenessController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Strengths",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _strengthsController,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Areas for Growth",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _growthController,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Professional Development Goals",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _goalsController,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommendations for Future Training Sessions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        _buildTextFieldSection("Curriculum and Content", _curriculumController),
        const SizedBox(height: 24),
        _buildTextFieldSection("Delivery Methods", _deliveryController),
        const SizedBox(height: 24),
        _buildTextFieldSection("Assessment", _assessmentController),
        const SizedBox(height: 24),
        _buildTextFieldSection("Learner Support", _supportController),
        const SizedBox(height: 24),
        _buildTextFieldSection("Other Recommendations", _otherController),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Supporting Documents",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(
    String title,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          readOnly: true,
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(String title, String details) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.description,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
    );
  }
}
