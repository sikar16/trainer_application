import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/content_bloc.dart';
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
    // Don't fetch content here - it will be handled by BlocBuilder
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
            // Title
            Text(
              "Content",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Search bar below title
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

            // Content list with proper height management
            Expanded(
              child: BlocListener<ContentBloc, ContentState>(
                listener: (context, state) {
                  if (state is ContentLoaded) {
                    // Update current page from response to fix search
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
                          // Table with fixed height container
                          Expanded(
                            child: IntrinsicHeight(
                              child: _buildContentTable(contents),
                            ),
                          ),

                          // Pagination controls
                          if (hasMore || _currentPage > 1)
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Previous button with icon
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

                                  // Page number display
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

                                  // Next button with icon
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
    final isAccepted = content.contentStatus == "ACCEPTED";
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
                ? Colors.blue.shade50
                : Colors.green.shade50,
            textColor: content.contentLevel == "LESSON"
                ? Colors.blue
                : Colors.green,
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
            color: isAccepted
                ? Colors.green.shade50
                : content.contentStatus == "REJECTED"
                ? Colors.red.shade50
                : Colors.orange.shade50,
            textColor: isAccepted
                ? Colors.green
                : content.contentStatus == "REJECTED"
                ? Colors.red
                : Colors.orange,
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
    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
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
    if (link == null || link!.isEmpty) {
      return Expanded(
        flex: flex,
        child: Text(
          "Awaiting Link",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      );
    }

    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
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
    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
