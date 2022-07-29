import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget child;
  const BasePage({
    Key? key,
    required this.title,
    required this.child,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: kToolbarHeight,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      if (leading != null)
                        Positioned(
                          left: 7.0,
                          top: 7.0,
                          child: leading!,
                        ),
                      Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (actions != null)
                        Positioned(
                          right: 7.0,
                          top: 7.0,
                          child: Row(
                            children: actions!,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: child,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
