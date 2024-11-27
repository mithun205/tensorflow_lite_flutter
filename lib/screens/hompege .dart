// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [

          const SizedBox(height: 280,),

          //logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              'assets/SS logo.png', 
                            
              height: 200,
            ),
          ),

          const SizedBox(height: 80,),
          
          GestureDetector(
            onTap: () {
                    Navigator.pushNamed(context, "/detect scrn_page");
                  },
            child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Start Detecting",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}