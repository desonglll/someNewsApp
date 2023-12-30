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
      Tabs() { // 容器
        ForEach(this.navs, (item,i) => {
          TabContent(){
            NewsView({nav: item})
          }.tabBar(this.Nav(item,i))
        })
      }.width('100%').height('100%')
      .barWidth('100%')
      .barMode(BarMode.Scrollable)
      .onChange(i=>{ // i就是你点的那个下标
        // @ts-ignore
        console.log(i);
        this.index = i // 应该没有效果
      })

    }.width('100%')
    .height('100%')
    // .backgroundImage($r('app.media.ic_yiqing'))
    // .backgroundImageSize({width:100%,height:100%})

  }
}