import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/session_report.dart';
import '../bloc/session_report_bloc.dart';
import '../bloc/session_report_event.dart';
import '../bloc/session_report_state.dart';

class ViewReportPage extends StatefulWidget {
  final String sessionId;

  const ViewReportPage({super.key, required this.sessionId});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0;
  final List<TextEditingController> _topicsCoveredControllers = [
    TextEditingController(),
  ];
  final List<TextEditingController> _significantObservationControllers = [
    TextEditingController(),
  ];
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _positiveFeedbackController =
      TextEditingController();
  final TextEditingController _improvementController = TextEditingController();
  final TextEditingController _specificFeedbackController =
      TextEditingController();
  final TextEditingController _strengthsController = TextEditingController();
  final TextEditingController _growthController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();
  final TextEditingController _curriculumController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _assessmentController = TextEditingController();
  final TextEditingController _supportController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  int? _selectedSatisfactionScore;
  int? _selectedEffectivenessScore;

  @override
  void initState() {
    super.initState();
    context.read<SessionReportBloc>().add(
      GetSessionReportEvent(widget.sessionId),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _topicsCoveredControllers) {
      controller.dispose();
    }
    for (var controller in _significantObservationControllers) {
      controller.dispose();
    }
    _summaryController.dispose();
    _positiveFeedbackController.dispose();
    _improvementController.dispose();
    _specificFeedbackController.dispose();
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

  void _addTopicField() {
    setState(() {
      _topicsCoveredControllers.add(TextEditingController());
    });
  }

  void _removeTopicField(int index) {
    if (_topicsCoveredControllers.length > 1) {
      setState(() {
        _topicsCoveredControllers.removeAt(index);
      });
    }
  }

  void _addObservationField() {
    setState(() {
      _significantObservationControllers.add(TextEditingController());
    });
  }

  void _removeObservationField(int index) {
    if (_significantObservationControllers.length > 1) {
      setState(() {
        _significantObservationControllers.removeAt(index);
      });
    }
  }

  Future<void> _addRealFile() async {
    final fileType = context.read<SessionReportBloc>().state is FilesUpdated
        ? (context.read<SessionReportBloc>().state as FilesUpdated)
                  .selectedFileType ??
              'image'
        : 'image';

    try {
      FilePickerResult? result;

      switch (fileType) {
        case 'image':
          result = await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
          );
          break;
        case 'pdf':
          result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
            allowMultiple: false,
          );
          break;
        case 'video':
          result = await FilePicker.platform.pickFiles(
            type: FileType.video,
            allowMultiple: false,
          );
          break;
        case 'document':
          result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['doc', 'docx', 'txt'],
            allowMultiple: false,
          );
          break;
        default:
          result = await FilePicker.platform.pickFiles(
            type: FileType.any,
            allowMultiple: false,
          );
      }

      if (result != null && result.files.single.path != null) {
        PlatformFile file = result.files.single;
        final fileSize = _formatFileSize(file.size);

        context.read<SessionReportBloc>().add(
          AddFileEvent({
            'name': file.name,
            'type': fileType,
            'typeId': '3fa85f64-5717-4562-b3fc-2c963f66afa6',
            'size': fileSize,
            'uploadTime': DateTime.now().toString(),
            'path': file.path ?? '',
          }),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File added: ${file.name}'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file selected'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        // Step 1: Topics and Observations
        final topicsValid = _topicsCoveredControllers.any(
          (controller) => controller.text.trim().isNotEmpty,
        );
        final observationsValid = _significantObservationControllers.any(
          (controller) => controller.text.trim().isNotEmpty,
        );
        return topicsValid && observationsValid;

      case 1:
        // Step 2: Satisfaction and Feedback
        return _selectedSatisfactionScore != null &&
            _summaryController.text.trim().isNotEmpty &&
            _positiveFeedbackController.text.trim().isNotEmpty &&
            _improvementController.text.trim().isNotEmpty &&
            _specificFeedbackController.text.trim().isNotEmpty;

      case 2:
        // Step 3: Teaching Methods
        return _selectedEffectivenessScore != null &&
            _strengthsController.text.trim().isNotEmpty &&
            _growthController.text.trim().isNotEmpty &&
            _goalsController.text.trim().isNotEmpty;

      case 3:
        // Step 4: Recommendations
        return _curriculumController.text.trim().isNotEmpty &&
            _deliveryController.text.trim().isNotEmpty &&
            _assessmentController.text.trim().isNotEmpty &&
            _supportController.text.trim().isNotEmpty &&
            _otherController.text.trim().isNotEmpty;

      case 4:
        // Step 5: Documents (optional)
        return true; // Documents step is always valid

      default:
        return false;
    }
  }

  void _saveReportData() {
    if (!_formKey.currentState!.validate()) return;

    final reportData = {
      'topicsCovered': _topicsCoveredControllers
          .map((controller) => controller.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'significantObservations': _significantObservationControllers
          .map((controller) => controller.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'overallSatisfactionScore': (_selectedSatisfactionScore ?? 0) * 20,
      'learnerFeedbackSummary': _summaryController.text,
      'positiveFeedback': _positiveFeedbackController.text,
      'areasForImprovement': _improvementController.text,
      'specificFeedbackExamples': _specificFeedbackController.text,
      'teachingMethodEffectiveness': (_selectedEffectivenessScore ?? 0) * 20,
      'trainerStrengths': _strengthsController.text,
      'trainerAreasForGrowth': _growthController.text,
      'trainerProfessionalGoals': _goalsController.text,
      'curriculumRecommendations': _curriculumController.text,
      'deliveryMethodRecommendations': _deliveryController.text,
      'assessmentRecommendations': _assessmentController.text,
      'learnerSupportRecommendations': _supportController.text,
      'otherRecommendations': _otherController.text,
      'remark': '',
      'sessionReportFiles':
          (context.read<SessionReportBloc>().state is FilesUpdated)
          ? (context.read<SessionReportBloc>().state as FilesUpdated).files
                .map(
                  (file) => {
                    'reportFileTypeId':
                        file['typeId'] ??
                        '3fa85f64-5717-4562-b3fc-2c963f66afa6',
                    'file': file['path'] ?? file['name'] ?? '',
                  },
                )
                .toList()
          : [],
    };

    context.read<SessionReportBloc>().add(
      CreateSessionReportEvent(widget.sessionId, reportData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionReportBloc, SessionReportState>(
      listener: (context, state) {
        if (state is SessionReportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is SessionReportCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Session report created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is SessionReportLoaded) {
          _populateControllers(state.report);
        }
      },
      child: BlocBuilder<SessionReportBloc, SessionReportState>(
        builder: (context, state) {
          final hasReport = state is SessionReportLoaded;
          final isLoading = state is SessionReportLoading;
          final files = (state is FilesUpdated)
              ? state.files
              : <Map<String, String>>[];
          final selectedFileType = (state is FilesUpdated)
              ? state.selectedFileType
              : null;

          return Scaffold(
            appBar: AppBar(
              title: Text(hasReport ? 'View Session Report' : 'Add Report'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildStep1(hasReport),
                        _buildStep2(hasReport),
                        _buildStep3(hasReport),
                        _buildStep4(hasReport),
                        _buildStep5(hasReport, files, selectedFileType),
                      ],
                    ),
                  ),
            bottomNavigationBar: _buildBottomNavigationBar(hasReport),
          );
        },
      ),
    );
  }

  void _populateControllers(SessionReport report) {
    // Clear existing controllers
    for (var controller in _topicsCoveredControllers) {
      controller.dispose();
    }
    for (var controller in _significantObservationControllers) {
      controller.dispose();
    }

    _topicsCoveredControllers.clear();
    _significantObservationControllers.clear();

    // Populate with report data
    for (String topic in report.topicsCovered) {
      _topicsCoveredControllers.add(TextEditingController(text: topic));
    }
    if (_topicsCoveredControllers.isEmpty) {
      _topicsCoveredControllers.add(TextEditingController());
    }

    for (String observation in report.significantObservations) {
      _significantObservationControllers.add(
        TextEditingController(text: observation),
      );
    }
    if (_significantObservationControllers.isEmpty) {
      _significantObservationControllers.add(TextEditingController());
    }

    _summaryController.text = report.learnerFeedbackSummary;
    _positiveFeedbackController.text = report.positiveFeedback;
    _improvementController.text = report.areasForImprovement;
    _specificFeedbackController.text = report.specificFeedbackExamples;
    _strengthsController.text = report.trainerStrengths;
    _growthController.text = report.trainerAreasForGrowth;
    _goalsController.text = report.trainerProfessionalGoals;
    _curriculumController.text = report.curriculumRecommendations;
    _deliveryController.text = report.deliveryMethodRecommendations;
    _assessmentController.text = report.assessmentRecommendations;
    _supportController.text = report.learnerSupportRecommendations;
    _otherController.text = report.otherRecommendations;

    _selectedSatisfactionScore = (report.overallSatisfactionScore / 20).round();
    _selectedEffectivenessScore = (report.teachingMethodEffectiveness / 20)
        .round();
  }

  Widget _buildStep1(bool hasReport) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Session Overview",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          // Topics Covered
          _buildDynamicFieldSection(
            "Topics Covered",
            _topicsCoveredControllers,
            hasReport,
            "Enter topic covered",
            _addTopicField,
            _removeTopicField,
            "Please provide at least one topic covered",
          ),

          const SizedBox(height: 24),

          // Significant Observations
          _buildDynamicFieldSection(
            "Significant Observations",
            _significantObservationControllers,
            hasReport,
            "Enter significant observation",
            _addObservationField,
            _removeObservationField,
            "Please provide at least one significant observation",
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicFieldSection(
    String title,
    List<TextEditingController> controllers,
    bool hasReport,
    String hintText,
    VoidCallback addField,
    Function(int) removeField,
    String? validationMessage,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...controllers.asMap().entries.map((entry) {
          int index = entry.key;
          TextEditingController controller = entry.value;
          final isEmpty = controller.text.isEmpty;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        readOnly: hasReport,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: hasReport ? null : hintText,
                          errorText:
                              !hasReport && isEmpty && validationMessage != null
                              ? validationMessage
                              : null,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isEmpty ? Colors.red : Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isEmpty
                                  ? Colors.red.shade300
                                  : Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!hasReport && controllers.length > 1)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeField(index),
                      ),
                  ],
                ),
                if (!hasReport && isEmpty && validationMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      validationMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
        if (!hasReport)
          TextButton.icon(
            onPressed: addField,
            icon: const Icon(Icons.add),
            label: const Text('Add more'),
          ),
      ],
    );
  }

  Widget _buildStep2(bool hasReport) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Learner Feedback and Satisfaction",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          // Overall Satisfaction Score
          _buildDropdownField(
            "Overall Satisfaction Score",
            hasReport,
            _selectedSatisfactionScore,
            (value) => setState(() => _selectedSatisfactionScore = value),
            (int score) => _getSatisfactionText(score.toDouble()),
            "Please select overall satisfaction score",
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Summary of Learner Feedback",
            _summaryController,
            hasReport,
            maxLines: 3,
            hintText: 'Enter summary of learner feedback',
            validationMessage: 'Please provide learner feedback summary',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Positive Feedback",
            _positiveFeedbackController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter positive feedback',
            validationMessage: 'Please provide positive feedback',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Areas for Improvement",
            _improvementController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter areas for improvement',
            validationMessage: 'Please provide areas for improvement',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Specific Feedback Examples",
            _specificFeedbackController,
            hasReport,
            maxLines: 3,
            hintText: 'Enter specific feedback examples',
            validationMessage: 'Please provide specific feedback examples',
          ),
        ],
      ),
    );
  }

  Widget _buildStep3(bool hasReport) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Self-Reflection on Teaching Practices",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          // Effectiveness of Teaching Methods
          _buildDropdownField(
            "Effectiveness of Teaching Methods",
            hasReport,
            _selectedEffectivenessScore,
            (value) => setState(() => _selectedEffectivenessScore = value),
            (int score) => _getEffectivenessText(score.toDouble()),
            "Please select teaching method effectiveness",
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Strengths",
            _strengthsController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter trainer strengths',
            validationMessage: 'Please provide trainer strengths',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Areas for Growth",
            _growthController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter areas for growth',
            validationMessage: 'Please provide areas for growth',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Professional Development Goals",
            _goalsController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter professional development goals',
            validationMessage: 'Please provide professional development goals',
          ),
        ],
      ),
    );
  }

  Widget _buildStep4(bool hasReport) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommendations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          _buildTextField(
            "Curriculum Recommendations",
            _curriculumController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter curriculum recommendations',
            validationMessage: 'Please provide curriculum recommendations',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Delivery Method Recommendations",
            _deliveryController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter delivery method recommendations',
            validationMessage: 'Please provide delivery method recommendations',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Assessment Recommendations",
            _assessmentController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter assessment recommendations',
            validationMessage: 'Please provide assessment recommendations',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Learner Support Recommendations",
            _supportController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter learner support recommendations',
            validationMessage: 'Please provide learner support recommendations',
          ),

          const SizedBox(height: 24),

          _buildTextField(
            "Other Recommendations",
            _otherController,
            hasReport,
            maxLines: 2,
            hintText: 'Enter other recommendations',
            validationMessage: 'Please provide other recommendations',
          ),
        ],
      ),
    );
  }

  Widget _buildStep5(
    bool hasReport,
    List<Map<String, String>> files,
    String? selectedFileType,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Supporting Documents",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          if (!hasReport) ...[
            // File type selection and upload section
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFileType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                      hintText: 'Select file type',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'pdf',
                        child: Text('PDF Document'),
                      ),
                      DropdownMenuItem(value: 'image', child: Text('Image')),
                      DropdownMenuItem(value: 'video', child: Text('Video')),
                      DropdownMenuItem(
                        value: 'document',
                        child: Text('Document'),
                      ),
                      DropdownMenuItem(value: 'other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      context.read<SessionReportBloc>().add(
                        UpdateFileTypeEvent(value),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _addRealFile,
                  icon: const Icon(Icons.add),
                  label: Text(
                    selectedFileType == 'image' || selectedFileType == null
                        ? 'Add Image'
                        : 'Add Document',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Files list
            if (files.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No files uploaded yet. Select a file type and upload a document.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              Column(
                children: files.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> file = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getFileIcon(file['type'] ?? 'other'),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file['name'] ?? 'Unknown file',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                file['type']?.toUpperCase() ?? 'OTHER',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<SessionReportBloc>().add(
                              RemoveFileEvent(index),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ] else ...[
            // Display existing files for view mode
            const Text(
              "Attached Documents:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text('No documents attached'),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool hasReport, {
    int maxLines = 1,
    String? hintText,
    String? validationMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          readOnly: hasReport,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
            hintText: hasReport ? null : hintText,
            errorText:
                !hasReport &&
                    controller.text.isEmpty &&
                    validationMessage != null
                ? validationMessage
                : null,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.text.isEmpty ? Colors.red : Colors.blue,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.text.isEmpty ? Colors.grey : Colors.grey,
                width: 1,
              ),
            ),
          ),
        ),
        if (!hasReport && controller.text.isEmpty && validationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              validationMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    bool hasReport,
    int? selectedValue,
    Function(int?) onChanged,
    String Function(int) getText,
    String? validationMessage,
  ) {
    final isEmpty = selectedValue == null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        if (hasReport)
          TextField(
            controller: TextEditingController(
              text: selectedValue != null
                  ? '$selectedValue - ${getText(selectedValue)}'
                  : '',
            ),
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          )
        else
          DropdownButtonFormField<int>(
            value: selectedValue,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Select score',
              errorText: isEmpty && validationMessage != null
                  ? validationMessage
                  : null,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isEmpty ? Colors.red : Colors.blue,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isEmpty ? Colors.red.shade300 : Colors.grey,
                  width: 1,
                ),
              ),
            ),
            items: [
              for (int score = 1; score <= 5; score++)
                DropdownMenuItem(
                  value: score,
                  child: Text('$score - ${getText(score)}'),
                ),
            ],
            onChanged: onChanged,
          ),
        if (!hasReport && isEmpty && validationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              validationMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(bool hasReport) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() => _currentStep--);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 4) {
                  // Validate current step before proceeding
                  if (!hasReport && !_validateCurrentStep()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please fill in all required fields before proceeding',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() => _currentStep++);
                } else if (!hasReport) {
                  _saveReportData();
                } else {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                _currentStep < 4 ? 'Next' : (hasReport ? 'Save' : 'Add Report'),
              ),
            ),
          ),
        ],
      ),
    );
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

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.video_file;
      case 'document':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}
