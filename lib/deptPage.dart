import 'package:flutter/material.dart';

import 'CSE.dart';
import 'Civil.dart';
import 'ECE.dart';
import 'Mech.dart';
import 'notesupload.dart';

void main() {
  runApp(const MaterialApp(
    home: DeptPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DeptPage extends StatefulWidget {
  const DeptPage({super.key});

  @override
  State<DeptPage> createState() => _DeptPageState();
}

class _DeptPageState extends State<DeptPage> {
  void _CSE() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CompSci(branch: 'CSE')),
    );
  }

  void _ECE() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EleCom(branch: 'ECE')),
    );
  }

  void _ME() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Mech(branch: 'ME')),
    );
  }

  void _CV() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Civil(branch: 'CV')),
    );
  }


  @override
  Widget build(BuildContext context) {
   /* double screenWIdth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;*/

    return Scaffold(
      appBar: AppBar(
        title: const Text('Department',style: TextStyle(fontFamily: 'Agbalumo'),),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NoteUploadScreen()));
            },
            icon: const Icon(Icons.book_rounded)),
      ),
      body: Container(
        /*height: screenHeight*0.3,*/
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.blueAccent]),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 100),
                child: Text(
                  'Select you department',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'PoetsenOne'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _CSE,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                ),
                child: const Text('Computer Science Engineering',style: TextStyle(fontFamily: 'PoetsenOne'),),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _ECE,
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
                child: const Text(
                  'Electronic Communication and Engineering',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'PoetsenOne'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _ME,
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
                child: const Text('Mechanical Engineering',style: TextStyle(fontFamily: 'PoetsenOne'),),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _CV,
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
                child: const Text('Civil Engineering',style: TextStyle(fontFamily: 'PoetsenOne'),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
