import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'database.dart';
import 'databasehelperclass.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


void main() {
  //wait NotesDatabaseHelper.instance.init();
  runApp(const MaterialApp(
    home: Civil(
      branch: 'CV',
    ),
    debugShowCheckedModeBanner: false,
  ));
}

// CompSci class
class Civil extends StatefulWidget {
  const Civil({Key? key, required this.branch}) : super(key: key);
  final String branch;
  @override
  State<Civil> createState() => _CivilState();
}

class _CivilState extends State<Civil> {
  String selectedYear = 'Year';
  String selectedScheme = 'Scheme';
  String selectedSemester = 'Semester';

  List<String> years = ['Year', '1', '2', '3', '4'];
  List<String> schemes = ['Scheme', '2018', '2021', '2022'];
  List<String> semesters = ['Semester', '1', '2', '3', '4', '5', '6', '7', '8'];
  List<String> downloadedPDFs = [];
  List<Note> filteredNotes = [];
  @override
  void initState() {
    super.initState();
    getFilteredNotes();
  }

  Future<void> getFilteredNotes() async {
    try {
      await NotesDatabaseHelper.instance.init();
      List<Note> notes = await NotesDatabaseHelper.instance.getFilteredNotes(
        widget.branch,
        selectedYear,
        selectedScheme,
        selectedSemester,
      );

      setState(() {
        filteredNotes = notes;
      });
    } catch (e) {
      print('Error in database operation: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildDropdown('Select Year', years, selectedYear, (value) {
                  setState(() {
                    selectedYear = value!;
                    getFilteredNotes();
                  });
                }),
                SizedBox(height: 5.0),
                _buildDropdown('Select Scheme', schemes, selectedScheme,
                        (value) {
                      setState(() {
                        selectedScheme = value!;
                        getFilteredNotes();
                      });
                    }),
                SizedBox(height: 5.0),
                _buildDropdown('Select Semester', semesters, selectedSemester,
                        (value) {
                      setState(() {
                        selectedSemester = value!;
                        getFilteredNotes();
                      });
                    }),
                SizedBox(height: 5.0),
              ],
            ),
            SizedBox(height: 16.0),
            _buildNotesList()
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label,
      List<String> items,
      String value,
      ValueChanged<String?> onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(label),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    if (filteredNotes.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: filteredNotes.length,
          itemBuilder: (context, index) {
            Note currentNote = filteredNotes[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                  title: Text(currentNote.title),
                  onTap: () {
                    // Open PDF using flutter_pdfview
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFView(
                          filePath: currentNote.pdfPath,
                          enableSwipe: true,
                          swipeHorizontal: false,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                      onPressed: () async {
                        await downloadPDF(currentNote.pdfPath);
                        downloadedPDFs.add(currentNote.pdfPath);
                      },
                      icon: Icon(Icons.download_for_offline_rounded))),
            );
          },
        ),
      );
    }
  }
  Future<void> downloadPDF(String pdfPath) async {
    try {
      // Read the local file
      var file = File(pdfPath);

      // Check if the file exists
      if (await file.exists()) {
        // Get the application documents directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String documentsPath = appDocDir.path;

        // Extract the file name from the path
        String fileName = pdfPath.split('/').last;

        // Create a new file path in the documents directory
        String filePath = '/storage/emulated/0/Download/$fileName';

        // Copy the file to the new path
        await file.copy(filePath);

        print('PDF downloaded to: $filePath');
      } else {
        print('File not found: $pdfPath');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }



}
