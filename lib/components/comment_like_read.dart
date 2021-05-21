import 'package:fluter_demo/config/app_colors.dart';
import 'package:fluter_demo/utils/util.dart';
import 'package:flutter/material.dart';

class CommentLikeRead extends StatelessWidget {
  final int? commentCount;
  final int? thumbUpCount;
  final int? readCount;

  const CommentLikeRead(
      {Key? key, this.commentCount, this.thumbUpCount, this.readCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconText('assets/images/icons/comment.png', commentCount!),
        _iconText('assets/images/icons/like.png', thumbUpCount!),
        _iconText('assets/images/icons/read.png', readCount!)
      ],
    );
  }

  Widget _iconText(String icon, int count) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: Text(
              formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.un3active,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
