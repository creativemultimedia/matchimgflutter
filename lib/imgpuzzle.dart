import 'package:flutter/material.dart';


class imgpuzzle extends StatefulWidget {
  const imgpuzzle({Key? key}) : super(key: key);

  @override
  _imgpuzzleState createState() => _imgpuzzleState();
}

class _imgpuzzleState extends State<imgpuzzle> {

  List<String> imglist=["car1.png","car2.png","car3.png","car4.png","car1.png","car2.png","car3.png","car4.png","car5.png","car6.png","car5.png","car6.png"];
  List<bool>? visiblelist;
  int t=1;
  int? pos1,pos2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imglist.shuffle();
    visiblelist=List.filled(imglist.length, true);
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        visiblelist=List.filled(imglist.length, false);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: imglist.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          childAspectRatio: 2
        ),
        itemBuilder: (context, index) {
          return Container(
            child: InkWell(
              onTap: () {
                setState(() {
                  if(!visiblelist![index] && t==1)
                  {
                    print("firstclick");
                    visiblelist![index]=true;
                    pos1=index;
                    t=3;
                    Future.delayed(Duration(milliseconds: 10)).then((value) {
                      t=2;
                    });
                  }
                  if(!visiblelist![index] && t==2)
                  {
                    print("secondclick");
                    visiblelist![index]=true;
                    pos2=index;
                    t=3;
                    if(imglist[pos1!]!=imglist[pos2!])
                    {
                      Future.delayed(Duration(seconds:1)).then((value) {
                        setState(() {
                          visiblelist![pos1!]=false;
                          visiblelist![pos2!]=false;
                          t=1;
                          if(!visiblelist!.contains(false))
                          {
                            print("win");
                          }
                        });
                      });
                    }
                    else{
                      Future.delayed(Duration(seconds:1)).then((value) {
                        setState(() {
                          t=1;
                          if(!visiblelist!.contains(false))
                          {
                            print("win");
                          }
                        });
                      });
                    }
                  }
                });
              },
              child: Visibility(
                visible: visiblelist![index],
                replacement: Container(color: Colors.green,),
                child: Image.asset("images/${imglist[index]}"),
              ),
            ),
          );
        },),
    );
  }
}