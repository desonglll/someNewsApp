import { TitleBar } from '../views/TitleBar'
import { News } from '../model/Bean'
import { Http } from '../model/Http'

import router from '@ohos.router';


let news = router.getParams()['news'] as News

@Entry
@Component
struct NewsPage {
  private scroller: Scroller = new Scroller()

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll(this.scroller) {
        Column() {
          TitleBar({ title: '新闻详情' })
          Flex({ direction: FlexDirection.Column }) {
            Text(news.title)
              .fontWeight(FontWeight.Bold)
              .fontSize(30)
              .margin({ left: 10 })
              .padding({ top: 10 })
            Text(news.datetime)
              .width('100%')
              .fontWeight(FontWeight.Bold)
              .fontSize(15)
              .margin({ left: 10 })
              .padding({ top: 10, left: 5 })
              .textAlign(TextAlign.Start)
              .fontColor(Color.Gray)
            Row() {
              Text(news.content ? news.content : news.description)
                .textAlign(TextAlign.Start)
                .width('100%')
                .margin({ top: 15 })
                .fontSize(20)
                .padding({ left: 20, right: 20 })
            }
          }.margin({ left: 0 })

          Column() {
            if (news.image) { // 存在image image不为""
              Image(Http.host + "/" + news.image)
                .width('80%')
                .padding({ top: 5 })
                .objectFit(ImageFit.Contain).margin(5)
            }
            if (news.photo) { // photo不为""
              Image(Http.host + news.photo)
                .width('80%')
                .padding({ top: 5 })
                .objectFit(ImageFit.Contain).margin(5)
            }
          }.width('100%')
          .margin({ top: 10 })
          .justifyContent(FlexAlign.Center)
        }
      }
      .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
      .scrollBarWidth(2) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
    }
  }
}