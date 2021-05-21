import 'package:fluter_demo/config/app_colors.dart';
import 'package:fluter_demo/models/video_model.dart';
import 'package:flutter/material.dart';
import 'avater_role_name.dart';
import 'comment_like_read.dart';
import 'package:fluter_demo/utils/util.dart';

class VideoCard extends StatelessWidget {
  final VideoItem? videoItem;
  const VideoCard({Key? key, this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          _title(),
          SizedBox(
            height: 20,
          ),
          _cover(),
          SizedBox(
            height: 20,
          ),
          _bottom(),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      videoItem!.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-2.png',
              image: videoItem!.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  getDurationTime(Duration(seconds: videoItem!.contentSeconds)),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvaterRoleName(
            avater: videoItem!.user.coverPictureUrl,
            nickname: videoItem!.user.nickname,
            type: videoItem!.user.type,
          ),
        ),
        Expanded(
            child: CommentLikeRead(
          commentCount: videoItem!.commentCount,
          thumbUpCount: videoItem!.thumbUpCount,
          readCount: videoItem!.readCount,
        ))
      ],
    );
  }
}
