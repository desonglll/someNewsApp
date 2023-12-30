import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { Nav, News } from '../model/Bean';
import { Http } from '../model/Http';
import { NewsItem } from './NewsItem'

@Preview // 可以预览页面碎片
@Component // 页面碎片
export struct NewsView {
  nav: Nav // 类
  @State newsList: News[] = [] // 新闻数组
  @State newsArr: News[] = [] // 新闻数组
  @State isRefreshing: boolean = false

  aboutToAppear() {
    let http = new Http('/get_by_nid')
    http.get({ nid: this.nav.id }).then(resp => {
      this.newsArr = []
      this.newsList = http.parse(resp)
      this.newsList.forEach(element => {
        if (element.operation == "0") {
          this.newsArr.push(element)
        }
        if (!element.operation) {
          if (element.buy == "0") {
            this.newsArr.push(element)
          }
        }
      });
    })
  }

  // onDestroy() {
  //   this.newsArr = []
  // }

  build() { // 列表上下滑动
    // 粘贴看效果
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List() { // List()和ListItem()要一起使用
        ForEach(this.newsArr, (item) => { // newsList-->news
          ListItem() {
            NewsItem({ news: item })
          }.onClick(() => { // 给每一个列表项设置点击事件
            if (!item.buy) {
              // 打开一个邮寄地址页面，交钱了
              router.pushUrl({
                url: 'pages/OrderPage',
                params: {
                  news: item
                }
              })
            } else {
              router.pushUrl({
                url: 'pages/NewsPage',
                params: {
                  news: item
                }
              })
            }
          })
        })
      }.width('100%').height('100%')
      .padding({ left: 10, right: 10 })
    }.onRefreshing(() => {
      setTimeout(() => {
        this.aboutToAppear() // 调用aboutToAppear()
        this.isRefreshing = false
      }, 1000)
      console.log('onRefreshing test')
    })

  }
}