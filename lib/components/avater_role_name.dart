import 'package:fluter_demo/config/app_colors.dart';
import 'package:flutter/material.dart';

class AvaterRoleName extends StatelessWidget {
  final String? avater;
  final String? nickname;
  final String? type;
  final bool showType;
  const AvaterRoleName(
      {Key? key, this.avater, this.nickname, this.showType = true, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avater(),
        Offstage(
          offstage: !showType,
          child: _role(),
        ),
        _nickname(),
      ],
    );
  }

  Widget _role() {
    return Container(
      margin: EdgeInsets.only(left: 6),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type ?? '未知',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _avater() {
    return SizedBox(
      width: 20,
      height: 20,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-1.png', image: avater!),
      ),
    );
  }

  Widget _nickname() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 6),
        child: Text(
          nickname!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.unactive,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
