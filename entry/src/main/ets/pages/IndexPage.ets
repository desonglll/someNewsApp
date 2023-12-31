import { Http } from '../model/Http'
import { NewsView } from '../views/NewsView'
@Entry
@Component
struct IndexPage {
  // 手机不能直接连接数据库，手机可以连接Java，Java可以连接数据库
  @State navs: string[] = ['全部','国内','国际']
  @State index: number = 0 // @State一旦变量发生变化立即更新到页面中

  aboutToAppear() { // 当页面出现的时候(页面已经出现了)
    // 去java那里拿数据
    let http = new Http('/nav_app')
    http.get().then(resp=>{ // resp就是java给回来的
      this.navs = http.parse(resp)
    })
  }

  // 在鸿蒙中@...叫装饰器
  @Builder // 自定义组件
  Nav(nav,i) { // Nav组件
    Text(nav.nav) // nav数组元素
      .fontColor(i==this.index?$r('app.color.blue'):Color.Black)
      .fontWeight(i==this.index?FontWeight.Bold:FontWeight.Normal)
      .fontSize(i==this.index?25:20)
      .padding({left:15,right:15})
  }

  build() {
    Column() { // 大垂直容器
      Text("资讯热点").fontSize(25).padding({bottom:2}).letterSpacing('10')
      Column() {
        Tabs() { // 容器
          ForEach(this.navs, (item, i) => {
            TabContent() {
              NewsView({ nav: item })
            }.tabBar(this.Nav(item, i))
          })
        }
        .width('100%')
        .height('100%')
        .barWidth('100%')
        .barMode(BarMode.Scrollable)
        .onChange(i => { // i就是你点的那个下标
          this.index = i // 应该没有效果
        })
      }.backgroundColor(Color.White)
      .width('95%')
      .borderRadius({topLeft:10,topRight:10})


    }.width('100%').height('100%')
      .padding({top:20})

    .radialGradient({
      center: ['50%', 150],
      radius: 600,
      colors: [[0xff0000, 0.0], , [0xffff00, 0.8]]
    })
  }
}