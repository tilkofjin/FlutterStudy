import 'package:fluter_demo/components/avater_role_name.dart';
import 'package:fluter_demo/components/comment_like_read.dart';
import 'package:fluter_demo/config/app_colors.dart';
import 'package:fluter_demo/models/song_model.dart';
import 'package:fluter_demo/utils/util.dart';
import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final SongItem? songItem;
  const SongCard({Key? key, this.songItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(toRpx(context, 40)),
      child: Row(
        children: [
          _songCover(),
          SizedBox(
            width: 8,
          ),
          _songContent(),
        ],
      ),
    );
  }

  // 封面图
  Widget _songCover() {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: songItem!.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/tiny_video.png',
              width: 22,
              height: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _songContent() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Stack(
          children: [
            Text(
              songItem!.cnName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.active,
                fontSize: 16,
              ),
            ),
            Positioned(
              top: 25,
              child: Text(
                songItem!.enName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.un3active,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: AvaterRoleName(
                      avater: songItem!.user.coverPictureUrl,
                      nickname: songItem!.user.nickname,
                      showType: false,
                      avatarSize: 20,
                      // type: 'ADMIN',
                    ),
                  ),
                  Expanded(
                    child: CommentLikeRead(
                      commentCount: songItem!.commentCount,
                      thumbUpCount: songItem!.thumbUpCount,
                      readCount: songItem!.readCount,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
