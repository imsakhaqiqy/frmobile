import 'package:badges/badges.dart';
import 'package:field_recruitment/constans.dart';
import 'package:field_recruitment/global.dart';
import 'package:flutter/material.dart';

class BerandaAppBar extends AppBar {
  BerandaAppBar(BuildContext context, {Key? key})
      : super(
            key: key,
            automaticallyImplyLeading: false,
            elevation: 0.25,
            backgroundColor: Colors.white,
            flexibleSpace: _buildBerandaAppBar(context));

  static Widget _buildBerandaAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('FR-Mobile',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45)),
          Row(
            children: <Widget>[
              Container(
                height: 28.0,
                width: 28.0,
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Colors.cyan),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/notifikasi');
                  },
                  child: isNotification != '0'
                      ? Badge(
                          badgeColor: Colors.redAccent,
                          toAnimate: true,
                          shape: BadgeShape.circle,
                          position: BadgePosition.topEnd(top: -12, end: -12),
                          badgeContent: Text(
                            isNotification,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 16.0),
                        )
                      : const Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 16.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
