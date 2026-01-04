import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/custom_popupdropdown.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class MysessionsWidget extends StatefulWidget {
  const MysessionsWidget({super.key});

  @override
  State<MysessionsWidget> createState() => _MysessionsWidgetState();
}

class _MysessionsWidgetState extends State<MysessionsWidget> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    SampleItem? selectedItem;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attendance",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 210, 210, 210),
                width: 1,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cohorts", style: textTheme.titleMedium),
                SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text("Test cohort 4"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text("Test cohort 4"),
                      ),
                      SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text("Test cohort 4"),
                      ),
                      SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text("Test cohort 4"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 210, 210, 210),
                width: 1,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sessions", style: textTheme.titleMedium),
                SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text("Digital literacy"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 210, 210, 210),
                width: 1,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 8,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Digital literacy",
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Cohort:Test cohort 4",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "07/10/2025",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Time",
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "12:00 PM -3:00 PM",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Business Center,",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 210, 210, 210),
                width: 1,
              ),
            ),
            child: Text("data"),
          ),

          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey.shade400),
          //     borderRadius: BorderRadius.circular(8),
          //     color: Colors.white,
          //   ),
          //   child: PopupMenuButton<SampleItem>(
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           selectedItem != null
          //               ? selectedItem!.name.replaceAll("item", "Item ")
          //               : "Select Item",
          //           style: const TextStyle(color: Colors.black),
          //         ),
          //         const SizedBox(width: 6),
          //         const Icon(Icons.arrow_drop_down),
          //       ],
          //     ),
          //     onSelected: (SampleItem item) {
          //       setState(() {
          //         selectedItem = item;
          //       });
          //     },
          //     itemBuilder: (BuildContext context) =>
          //         <PopupMenuEntry<SampleItem>>[
          //           const PopupMenuItem<SampleItem>(
          //             value: SampleItem.itemOne,
          //             child: Text('Item 1'),
          //           ),
          //           const PopupMenuItem<SampleItem>(
          //             value: SampleItem.itemTwo,
          //             child: Text('Item 2'),
          //           ),
          //           const PopupMenuItem<SampleItem>(
          //             value: SampleItem.itemThree,
          //             child: Text('Item 3'),
          //           ),
          //         ],
          //   ),
          // ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bottom Sheet Title",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Here is the content of the bottom sheet.",
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text("Show Bottom Sheet"),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 220, 220, 220),
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: const Text("Save Attendance"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search students",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        backgroundColor: const Color.fromRGBO(134, 239, 172, 1),
                        foregroundColor: const Color.fromARGB(255, 27, 71, 28),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 133, 199, 136),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const Text("View Report"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: Colors.grey.shade300),
                          outside: BorderSide(color: Colors.grey.shade300),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(60),
                          1: FixedColumnWidth(180),
                          2: FixedColumnWidth(140),
                          3: FixedColumnWidth(120),
                          4: FixedColumnWidth(260),
                          5: FixedColumnWidth(220),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("data"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Full Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Phone number",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Attendance",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "ID & Consent Form",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(""),
                              ),

                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("Student test one"),
                              ),

                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("+25196677889"),
                              ),

                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("07/10/2025"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),

                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.message_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                96,
                                                96,
                                                96,
                                              ),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.save_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                96,
                                                96,
                                                96,
                                              ),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 0,
                                    ),

                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: const Color.fromRGBO(
                                          221,
                                          221,
                                          221,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(width: 1),
                                      TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.white,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                            ),
                                            builder: (context) {
                                              return SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 16,
                                                    bottom:
                                                        MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom +
                                                        16,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Upload ID Document - student test",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      const Text("ID Type"),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomPopupDropdown<
                                                        SampleItem
                                                      >(
                                                        selectedItem:
                                                            selectedItem,
                                                        hint: "Select Item",
                                                        items: const [
                                                          DropdownMenuItem(
                                                            value: SampleItem
                                                                .itemOne,
                                                            child: Text(
                                                              "Item 1",
                                                            ),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: SampleItem
                                                                .itemTwo,
                                                            child: Text(
                                                              "Item 2",
                                                            ),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: SampleItem
                                                                .itemThree,
                                                            child: Text(
                                                              "Item 3",
                                                            ),
                                                          ),
                                                        ],
                                                        onSelected: (item) {
                                                          setState(() {
                                                            selectedItem = item;
                                                          });
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                            ),
                                                        child: const Text(
                                                          "Close",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          "Show Bottom Sheet",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
