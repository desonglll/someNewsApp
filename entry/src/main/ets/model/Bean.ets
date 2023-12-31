// ArkTS
// 有点像Java，跟Java还是有一些区别的
// 数据表--JavaBean-->HarBean 一一对应
export class Nav {
  id: number // 换行了自动带一个;
  nav: string
  type: number
}

export class News {
  datetime: string
  nav: string = "0"
  description:string
  product_name:string
  quantity:string
  name:string
  operation:string
  address:string
  phone:string
  type: number
  id: number
  buy:string
  title: string
  content: string
  // Date ctime; // java时间，arkts用不了
  nid: number
  image: string
  photo: string
  price: number
}