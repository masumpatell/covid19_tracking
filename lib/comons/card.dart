import 'package:flutter/material.dart';

Widget cards(context,String title,String value){
  return Container(
    padding: const EdgeInsets.only(left: 20,right: 20),
    margin: const EdgeInsets.only(left: 20,right: 20),
    color: Colors.grey[900],
    height: MediaQuery.of(context).size.height*0.07,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        Text(value,style: const TextStyle(color: Colors.white))
      ],
    ),
  );
}