import 'package:fluter_demo/config/app_colors.dart';
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
        children: [
          Image.asset(
            icon,
            width: 14,
            height: 14,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              count.toString(),
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
