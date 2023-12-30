import { Http } from '../model/Http'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router';
// lineInput()自己随便写的一个名字
@Extend(Text) function titleText() {
  .fontSize(28)
  .fontWeight(FontWeight.Bold) // 加粗
  .margin({ top: 20 })
}

@Extend(TextInput) function lineInput() {
  .fontSize(20)
  .placeholderFont({ size: 20 })
  .margin({ top: 20 })
  .backgroundColor(Color.Transparent)
  .borderWidth({ bottom: 1 }) // bottom底线
  .borderRadius(0) // 圆弧半径
  .borderColor('#ddd') // 边框线颜色
}

@Entry
@Component
struct LoginPage {
  // 定义全局变量
  // String username = "张三"
  @State username: string = ''
  @State password: string = ''
  // 构建UI界面
  build() {
    // 从上往下，垂直排布 Column垂直容器
    Column() { // 大的垂直容器
      Column() { // 小的垂直容器
        Image($r('app.media.ic_yiqing')).width(150).height(150)
        Text('锋云新闻').titleText()
        Text('登录后可以使用更多功能').fontColor(Color.Gray).margin({ top: 10 })
        TextInput({ placeholder: '请输入用户名', text: this.username })
          .onChange(value=>this.username=value)
          .lineInput()
        TextInput({ placeholder: '请输入密码', text: this.password })
          .onChange(value=>this.password=value)
          .lineInput()
          .type(InputType.Password)
        Row() { // 水平容器 如果不会调试，用色块调
          Text('记住密码')
            .fontColor($r('app.color.blue'))
          Text('忘记密码')
            .fontColor($r('app.color.blue'))
        }.width('100%')
        .margin({ top: 20 })
        .justifyContent(FlexAlign.SpaceBetween)
        // Text('忘记密码')
        //   .fontColor($r('app.color.blue'))
        //   .alignSelf(ItemAlign.End)
        Button('登录')
          .fontSize(20)
          .width('80%')
          .margin({ top: 30 })
          .onClick(() => { // 设置点击事件
            console.log("---------------")
            console.log(this.username)
            console.log(this.password)
            console.log("---------------")
            let http = new Http('/login') // java
            http.get({
              username: this.username,
              password: this.password,
            }).then(resp => { // java随便给手机一个响应就行
              if (resp.responseCode == 200) {
                router.pushUrl({
                  url: 'pages/HomePage' // 目标url
                }),
                promptAction.showToast({
                  message: '登录成功，欢迎!'
                })
              } else {
                promptAction.showToast({
                  message: '请输入正确信息！'
                })
              }
            })
          })
      }.width('100%').padding({ top: 100 })

      Row({ space: 20 }) { // 小的水平容器
        Image($r('app.media.kiwifruit'))
          .width(60)
          .height(60)
          .borderRadius(30)
        Image($r('app.media.banana'))
          .width(60)
          .height(60)
          .borderRadius(30)
      }.padding({ bottom: 30 })

    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 15, right: 15 }) // 给容器加宽100%自动水平居中
    // padding内边距     margin外边距
  }
}