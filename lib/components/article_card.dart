import 'package:fluter_demo/components/avater_role_name.dart';
import 'package:fluter_demo/components/comment_like_read.dart';
import 'package:fluter_demo/config/app_colors.dart';
import 'package:fluter_demo/models/article_model.dart';
import 'package:fluter_demo/utils/util.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  final ArticleItem? articleItem;
  ArticleCard({Key? key, this.articleItem}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

const double paddingSize = 20;
const double spaceSize = 10;

class _ArticleCardState extends State<ArticleCard> {
  late double boxSize;

  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - paddingSize * 2;
    return Container(
      padding: EdgeInsets.all(paddingSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: paddingSize,
          ),
          _getCoverByType(),
          SizedBox(
            height: paddingSize,
          ),
          _bottom()
        ],
      ),
    );
  }

  // 图片展示样式种类
  // 1张图 显示方式 1种
  // 2张图 显示方式 2种，2、3
  // 3张图 显示方式 6种，2、3、4、5、6、7
  // 4张图 显示方式 7种 2、3、4、5、6、7、8
  // 根据 coverUrlList 长度来随机展示图片的显示方式

  int _getTypeBylen() {
    int length = widget.articleItem!.coverUrlList.length;
    int coverType;
    switch (length) {
      case 2:
        coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        coverType = getRandomRangeInt(2, 7);
        break;
      case 4:
        coverType = getRandomRangeInt(2, 8);
        break;
      default:
        coverType = 1;
    }
    return coverType;
  }

  //  根据 coverType 展示不同类型的图片样式
  _getCoverByType() {
    int coverType = _getTypeBylen();

    Widget _coverWidget;

    switch (coverType) {
      case 2:
        _coverWidget = _coverTwo();
        break;
      case 3:
        _coverWidget = _coverThree();
        break;
      case 4:
        _coverWidget = _coverFour();
        break;
      case 5:
        _coverWidget = _coverFive();
        break;
      case 6:
        _coverWidget = _coverSix();
        break;
      case 7:
        _coverWidget = _coverSeven();
        break;
      case 8:
        _coverWidget = _coverEight();
        break;
      default:
        _coverWidget = _coverOne();
    }
    return _coverWidget;
  }

  // 1张图显示
  Widget _coverOne() {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: _cover(),
    );
  }

  // 2张图显示 左右布局 -- 2
  Widget _coverTwo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 1),
        )
      ],
    );
  }

  // 2张图显示 上下布局 -- 3
  Widget _coverThree() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        )
      ],
    );
  }

  // 3张图显示 左竖右上下布局 -- 4
  Widget _coverFour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            )
          ],
        ),
      ],
    );
  }

  // 3张图显示 左上下右竖布局 -- 5
  Widget _coverFive() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            )
          ],
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  // 3张图显示 上左右下横布局 -- 6
  Widget _coverSix() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            )
          ],
        ),
        SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  // 3张图显示 上横下左右布局 -- 7
  Widget _coverSeven() {
    return Column(
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
        SizedBox(height: spaceSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            )
          ],
        ),
      ],
    );
  }

  // 4张图显示 上左右下左右布局 -- 8
  Widget _coverEight() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            )
          ],
        ),
        SizedBox(height: spaceSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 3),
            )
          ],
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      widget.articleItem!.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/common/lazy-1.png',
        image: widget.articleItem!.coverUrlList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvaterRoleName(
            avater: widget.articleItem!.user.coverPictureUrl,
            nickname: widget.articleItem!.user.nickname,
            type: widget.articleItem!.user.type,
          ),
        ),
        Expanded(
            child: CommentLikeRead(
          commentCount: widget.articleItem!.commentCount,
          thumbUpCount: widget.articleItem!.thumbUpCount,
          readCount: widget.articleItem!.readCount,
        ))
      ],
    );
  }
}
