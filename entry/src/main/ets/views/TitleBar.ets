
import router from '@ohos.router'
@Preview
@Component // 页面碎片
export struct TitleBar {
  @State title: string = '标题'
  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(38)
        .height(38)
        .margin({left:15,right:15})
        .onClick(()=>{
          router.back() // 返回上一页
        })
      Text(this.title)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
    }.width('100%').height(60)
  }
}