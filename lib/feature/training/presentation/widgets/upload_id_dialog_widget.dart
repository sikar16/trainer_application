import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/trainee_entity.dart';
import '../../../../core/network/api_client.dart';

class UploadIDDialogWidget extends StatefulWidget {
  final TraineeEntity? trainee;

  const UploadIDDialogWidget({super.key, this.trainee});

  @override
  State<UploadIDDialogWidget> createState() => _UploadIDDialogWidgetState();
}

class _UploadIDDialogWidgetState extends State<UploadIDDialogWidget> {
  String? _selectedIdType;
  String? _frontImagePath;
  String? _backImagePath;
  bool _isUploading = false;

  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    if (widget.trainee != null) {
      _selectedIdType = _mapIdTypeToDisplay(widget.trainee!.idType);
      _frontImagePath = widget.trainee!.frontIdUrl;
      _backImagePath = widget.trainee!.backIdUrl;
    } else {
      _selectedIdType = null;
      _frontImagePath = null;
      _backImagePath = null;
    }
  }

  String? _mapIdTypeToDisplay(String? idType) {
    if (idType == null) return null;

    switch (idType) {
      case 'PASSPORT':
        return 'Passport';
      case 'NATIONAL_ID':
        return 'National ID';
      case 'KEBELE_ID':
        return 'Resident (Kebele) ID (Requires back image)';
      case 'DRIVING_LICENSE':
        return 'Driving License (Requires back image)';
      default:
        return null;
    }
  }

  String? _mapDisplayToIdType(String? displayType) {
    if (displayType == null) return null;

    switch (displayType) {
      case 'Passport':
        return 'PASSPORT';
      case 'National ID':
        return 'NATIONAL_ID';
      case 'Resident (Kebele) ID (Requires back image)':
        return 'KEBELE_ID';
      case 'Driving License (Requires back image)':
        return 'DRIVING_LICENSE';
      case 'Consent Form':
        return 'CONSENT_FORM';
      default:
        return null;
    }
  }

  Future<void> _pickFile(bool isBack) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isBack) {
          _backImagePath = result.files.single.path;
        } else {
          _frontImagePath = result.files.single.path;
        }
      });
    }
  }

  bool get _requiresBackImage {
    return _selectedIdType == 'Resident (Kebele) ID (Requires back image)' ||
        _selectedIdType == 'Driving License (Requires back image)';
  }

  List<String> get _availableIdTypes {
    if (widget.trainee?.pendingTraineeId != null) {
      return [
        'Passport',
        'National ID',
        'Resident (Kebele) ID (Requires back image)',
        'Driving License (Requires back image)',
      ];
    }
    return ['Consent Form'];
  }

  bool get _hasExistingDocuments {
    final trainee = widget.trainee;
    return trainee?.frontIdUrl != null ||
        trainee?.backIdUrl != null ||
        trainee?.consentFormUrl != null ||
        trainee?.signatureUrl != null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.trainee != null
                        ? "Edit Documents "
                        : "Upload ID Documents",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 70),
                  IconButton(
                    icon: Icon(Icons.close),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "ID Type",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedIdType,
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: Text(
                      "Select ID type",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    items: _availableIdTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: textTheme.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedIdType = newValue;
                        if (!_requiresBackImage) {
                          _backImagePath = null;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedIdType == 'Consent Form'
                      ? "Consent Form"
                      : "Front of ID",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _pickFile(false),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    child: _frontImagePath != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox.expand(
                                  child: _buildImageWidget(_frontImagePath!),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () => _pickFile(false),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _selectedIdType == 'Consent Form'
                                    ? "Upload Consent Form"
                                    : "Upload Front",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),

            if (_requiresBackImage) ...[
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Back of ID",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _pickFile(true),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: colorScheme.surfaceContainerHighest,
                      ),
                      child: _backImagePath != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox.expand(
                                    child: _buildImageWidget(_backImagePath!),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () => _pickFile(true),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 48,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Upload Back",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],

            if (widget.trainee?.signatureUrl != null) ...[
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signature",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final url = widget.trainee!.signatureUrl!;
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open signature'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "View Signature",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            if (widget.trainee?.consentFormUrl != null) ...[
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Consent Form",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final url = widget.trainee!.consentFormUrl!;
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open consent form'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "View Consent Form",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Cancel", style: textTheme.labelLarge),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : () => _uploadDocuments(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _selectedIdType == 'Consent Form'
                          ? "Upload Consent Form"
                          : "Upload ID",
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadDocuments() async {
    if (_selectedIdType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an ID type')));
      return;
    }

    if (_frontImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _selectedIdType == 'Consent Form'
                ? 'Please upload consent form'
                : 'Please upload front image',
          ),
        ),
      );
      return;
    }

    if (_requiresBackImage && _backImagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please upload back image')));
      return;
    }

    if (widget.trainee?.pendingTraineeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trainee does not have pending ID')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final apiType = _mapDisplayToIdType(_selectedIdType);

      if (_selectedIdType == 'Consent Form') {
        final Map<String, MultipartFile> files = {
          'consentFormFile': await MultipartFile.fromFile(
            _frontImagePath!,
            filename: _frontImagePath!.split('/').last,
          ),
        };

        final response = await _apiClient.postMultipart(
          '/api/pending-trainee/upload-consent',
          data: {'pendingTraineeId': widget.trainee!.pendingTraineeId},
          files: files,
        );

        if (response.statusCode == 200) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Consent form uploaded successfully')),
          );
        } else {
          throw Exception('Upload failed');
        }
      } else {
        final Map<String, MultipartFile> files = {
          'idFrontFile': await MultipartFile.fromFile(
            _frontImagePath!,
            filename: _frontImagePath!.split('/').last,
          ),
        };

        if (_backImagePath != null) {
          files['idBackFile'] = await MultipartFile.fromFile(
            _backImagePath!,
            filename: _backImagePath!.split('/').last,
          );
        }

        final response = await _apiClient.postMultipart(
          '/api/pending-trainee/update-id',
          data: {
            'pendingTraineeId': widget.trainee!.pendingTraineeId,
            'idType': apiType,
          },
          files: files,
        );

        if (response.statusCode == 200) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ID uploaded successfully')),
          );
        } else {
          throw Exception('Upload failed');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                "ID Image",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                imagePath.split('/').last,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      );
    }
  }
}
