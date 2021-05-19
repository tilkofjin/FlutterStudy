import 'package:fluter_demo/components/avater_role_name.dart';
import 'package:fluter_demo/components/comment_like_read.dart';
import 'package:fluter_demo/models/video_model.dart';
import 'package:flutter/material.dart';

class TinyVideoCard extends StatelessWidget {
  final VideoItem? videoItem;
  const TinyVideoCard({Key? key, this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _cover(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: AvaterRoleName(
            avater: videoItem!.user.coverPictureUrl,
            nickname: videoItem!.user.nickname,
            type: videoItem!.user.type,
          ),
        ),
        CommentLikeRead(
          commentCount: videoItem!.commentCount,
          thumbUpCount: videoItem!.thumbUpCount,
          readCount: videoItem!.readCount,
        ),
      ],
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/common/lazy-3.png',
                  image: videoItem!.coverPictureUrl,
                  fit: BoxFit.cover)),
          Center(
              child: Image.asset(
            'assets/images/icons/play_plus.png',
            width: 37,
            height: 37,
          )),
        ],
      ),
    );
  }
}
