  import 'package:flutter/material.dart';

SnackBar snackBar(errorMassage) {
    return SnackBar(
      content: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "oh Snap!",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        errorMassage,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
