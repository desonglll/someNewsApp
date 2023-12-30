
import { News } from '../model/Bean'
import { Http } from '../model/Http'
@Preview
@Component
export struct NewsItem{ // 结构体加export
  @State news: News = null
  // java写法 News news = null
  build() {
    Column() {
      Row() {
        Text(!this.news.buy?'购物':'新闻')
          .fontColor($r('app.color.blue'))
          .borderWidth(1)
          .borderColor($r('app.color.blue'))
          .padding({left:10,top:5,right:10,bottom:5})
          .borderRadius(5)
        Text((this.news.operation!="1")&&(this.news.title?this.news.title:this.news.product_name))
          .fontWeight(FontWeight.Bold)
          .fontSize(25)
          .margin({left:10})
      }.width('100%')
      Text(this.news.content)
        .textAlign(TextAlign.Start)
        .width('100%')
        .margin({top:15})
        .fontSize(20)
      Row() {
        if (this.news.image) { // 存在image image不为""
          Image(Http.host+this.news.image)
            .width('48%')
            .height(120)
            .borderRadius(10)
        }
        if (this.news.photo) { // photo不为""
          Image(Http.host+this.news.photo)
            .width('48%')
            .height(120)
            .borderRadius(10)
        }
      }.width('100%')
      .margin({top:10})
      .justifyContent(FlexAlign.SpaceBetween)

      Text(this.news.datetime)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({top:10,bottom:15})
        .fontColor(Color.Gray)

    }.width('100%')
    .borderWidth({bottom:1})
    .borderColor('#ddd')
    .padding({top:15})
  }
}