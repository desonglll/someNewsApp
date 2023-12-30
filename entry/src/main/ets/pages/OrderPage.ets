// 不能和其他文件重名？很奇怪，华为没做好
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { News } from '../model/Bean'
import { Http } from '../model/Http'
import { TitleBar } from '../views/TitleBar'

@Extend(TextInput) function line() {
  .fontSize(20)
  .placeholderFont({ size: 20 })
  .margin({ top: 20 })
  .backgroundColor(Color.Transparent)
  .borderWidth({ bottom: 1 }) // bottom底线
  .borderRadius(0) // 圆弧半径
  .borderColor('#ddd') // 边框线颜色
}
// 全局变量 = 获取带过来的参数['news'] as 类型约束
let news = router.getParams()['news'] as News

@Entry // 完整的页面
@Component
struct OrderPage {
  @State name: string = ''
  @State address: string = ''
  @State phone: string = '18234567890'
  @State quantity: string = '1'

  build() {
    Column() {
      TitleBar({ title: '订单信息' })

      Column() {
        Text(news.product_name)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 15 })
        Text(news.description)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 15 })
        if (news.image) { // 做一个测试
          Image(Http.host + news.image).width(200).height(200)
        }
        TextInput({ placeholder: '请填写姓名', text: this.name }).line().onChange(value=>this.name=value)
        TextInput({ placeholder: '请填写地址', text: this.address }).line().onChange(value=>this.address=value)
        TextInput({ placeholder: '请填写手机', text: this.phone }).line().onChange(value=>this.phone=value)
        TextInput({ placeholder: '填写购买个数', text: this.quantity }).line().onChange(value=>this.quantity=value)
          .type(InputType.Number)
        Button('购买')
          .width('80%')
          .fontSize(20)
          .margin({ top: 30 })
          .onClick(() => { // 设置点击事件
            let http = new Http('/buy') // java
            http.get({
              name: this.name,
              address: this.address,
              phone: this.phone,
              quantity: this.quantity,
              product_id: news.id,
              operation:"1"
            }).then(resp => { // java随便给手机一个响应就行
              promptAction.showToast({
                message: '购买成功'
              })
            })
          })
      }.width('100%').padding({ left: 15, right: 15 })
    }
  }
}