import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class TeamInfo extends StatefulWidget {
  const TeamInfo({super.key});

  @override
  State<TeamInfo> createState() => _TeamInfoState();
}

class _TeamInfoState extends State<TeamInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Stack(
                  children: [
                     Padding(
                       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            "https://upload.wikimedia.org/wikipedia/sco/thumb/4/47/FC_Barcelona_%28crest%29.svg/2020px-FC_Barcelona_%28crest%29.svg.png",
                            width: 38,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "FC BARCELONA",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w900
                            ), 
                          )                     
                        ],
                      ),
                     ),

                    Positioned(
                      right: 20,
                      top: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryColor,
                        ),
                        child: const Text(
                          "+",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
               
                const Text(
                  "2023/24",
                  style: TextStyle(
                    color: whiteColor ,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ) ,

                const SizedBox(height: 8),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Manager: ",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ) ,
                    CircleAvatar(
                      radius: 18,  
                      backgroundImage: NetworkImage("https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt6ad6eccbd0da5414/64a191a7f233a0834366be09/GettyImages-1491878704.jpg?auto=webp&format=pjpg&width=3840&quality=60")
                    ),   
                    SizedBox(width: 5),               
                    Text(
                      "Xavi Hernandez", 
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ) ,

              ]
            ),
          ) ;
  }
}