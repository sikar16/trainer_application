import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gheero/feature/training/presentation/bloc/content_bloc/content_event.dart';
import '../bloc/content_bloc/content_bloc.dart';
import '../bloc/content_bloc/content_state.dart';
import '../../domain/entities/content_entity.dart';
import '../../../../core/di/injection_container.dart' as sl;

class ContentWidget extends StatefulWidget {
  final String trainingId;

  const ContentWidget({super.key, required this.trainingId});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchContent({String? searchQuery, bool isLoadMore = false}) {
    if (isLoadMore) {
      setState(() {
        _isLoadingMore = true;
      });
    }

    context.read<ContentBloc>().add(
      FetchContent(
        trainingId: widget.trainingId,
        page: isLoadMore ? _currentPage + 1 : 1,
        pageSize: _pageSize,
        searchQuery: searchQuery,
      ),
    );
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _currentPage = 1;
      });
      _fetchContent(searchQuery: query.isEmpty ? null : query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => sl.sl<ContentBloc>()
        ..add(
          FetchContent(trainingId: widget.trainingId, page: 1, pageSize: 10),
        ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Content",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search by Name",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: BlocListener<ContentBloc, ContentState>(
                listener: (context, state) {
                  if (state is ContentLoaded) {
                    setState(() {
                      _currentPage = state.contentResponse.currentPage;
                      _isLoadingMore = false;
                    });
                  }
                },
                child: BlocBuilder<ContentBloc, ContentState>(
                  builder: (context, state) {
                    if (state is ContentLoading && _currentPage == 1) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ContentError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error loading content',
                              style: textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _fetchContent(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is ContentLoaded) {
                      final contents = state.contentResponse.contents;
                      final totalPages = state.contentResponse.totalPages;
                      final hasMore = _currentPage < totalPages;

                      if (contents.isEmpty && _currentPage == 1) {
                        return Center(
                          child: Text(
                            'No content found',
                            style: textTheme.bodyLarge,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: IntrinsicHeight(
                              child: _buildContentTable(contents),
                            ),
                          ),

                          if (hasMore || _currentPage > 1)
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_currentPage > 1)
                                    ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                      ),
                                      label: const Text('Previous'),
                                      onPressed: () {
                                        setState(() {
                                          _currentPage--;
                                        });
                                        _fetchContent();
                                      },
                                    ),

                                  const SizedBox(width: 16),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.blue.shade200,
                                      ),
                                    ),
                                    child: Text(
                                      'Page $_currentPage',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    'of $totalPages',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  if (hasMore)
                                    _isLoadingMore
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                            ),
                                            label: const Text('Next'),
                                            onPressed: () {
                                              setState(() {
                                                _currentPage++;
                                              });
                                              _fetchContent(isLoadMore: true);
                                            },
                                          ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTable(List<ContentEntity> contents) {
    return IntrinsicHeight(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1400,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _tableHeader(),
                  ...contents.map((content) => _tableRow(content)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Row(
        children: [
          _HeaderCell("Name", flex: 2),
          SizedBox(width: 20),

          _HeaderCell("Content For", flex: 3),
          SizedBox(width: 20),

          _HeaderCell("Description", flex: 3),
          SizedBox(width: 20),

          _HeaderCell("Content Level", flex: 2),
          SizedBox(width: 20),

          _HeaderCell("Assigned To", flex: 3),
          SizedBox(width: 20),

          _HeaderCell("File Type", flex: 1),
          SizedBox(width: 20),

          _HeaderCell("Content Link", flex: 2),
          SizedBox(width: 20),

          _HeaderCell("Status", flex: 2),
        ],
      ),
    );
  }

  Widget _tableRow(ContentEntity content) {
    final contentFor = content.lessonName ?? content.moduleName ?? "";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BodyCell(content.name, flex: 2),
          const SizedBox(width: 20),
          _BodyCell(contentFor, flex: 3),
          const SizedBox(width: 20),

          _BodyCell(content.description, flex: 3),
          const SizedBox(width: 20),

          _BodyChip(
            text: content.contentLevel,
            color: content.contentLevel == "LESSON"
                ? const Color.fromARGB(255, 211, 226, 245)
                : content.contentLevel == "ASSESSMENT"
                ? const Color.fromARGB(255, 246, 236, 255)
                : const Color.fromARGB(255, 223, 249, 231),
            textColor: content.contentLevel == "LESSON"
                ? const Color(0xFF3B82F6)
                : content.contentLevel == "ASSESSMENT"
                ? const Color(0xFF8B5CF6)
                : const Color(0xFF22C55E),
            flex: 2,
          ),

          const SizedBox(width: 20),

          _BodyCell(content.contentDeveloper.email, flex: 3),
          const SizedBox(width: 20),

          _BodyCell(content.contentFileType, flex: 2),
          const SizedBox(width: 20),

          _LinkCell("View Link", link: content.link, flex: 2),
          const SizedBox(width: 20),

          _StatusChip(
            text: content.contentStatus,
            color: content.contentStatus == "ACCEPTED"
                ? const Color.fromARGB(255, 223, 249, 231)
                : content.contentStatus == "REJECTED"
                ? const Color.fromARGB(255, 247, 220, 220)
                : const Color.fromARGB(255, 209, 228, 251),
            textColor: content.contentStatus == "ACCEPTED"
                ? const Color(0xFF22C55E)
                : content.contentStatus == "REJECTED"
                ? const Color(0xFFEF4444)
                : const Color(0xFF3B82F6),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HeaderCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool bold;
  const _BodyCell(this.text, {required this.flex, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _BodyChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final int flex;
  const _BodyChip({
    required this.text,
    required this.color,
    required this.textColor,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textTheme.labelSmall?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkCell extends StatelessWidget {
  final String text;
  final String? link;
  final int flex;
  const _LinkCell(this.text, {required this.link, required this.flex});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ColorScheme = Theme.of(context).colorScheme;

    if (link == null || link!.isEmpty) {
      return Expanded(
        flex: flex,
        child: Text(
          "Awaiting Link",
          style: TextStyle(
            color: Colors.grey,
            fontSize: textTheme.bodyMedium?.fontSize,
          ),
        ),
      );
    }

    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () async {
          if (link != null && link!.isNotEmpty) {
            final Uri uri = Uri.parse(link!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        },
        child: Text(
          text,
          style: TextStyle(
            color: ColorScheme.primary,
            fontSize: textTheme.bodyMedium?.fontSize,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final int flex;
  const _StatusChip({
    required this.text,
    required this.color,
    required this.textColor,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textTheme.labelSmall?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
