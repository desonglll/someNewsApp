import http from '@ohos.net.http';

export class Http {
  static host = 'http://192.168.200.14:8000'
  project = '/api' // 项目名
  url = ''
  // 构造方法   new Http('/nav_app')
  constructor(url) {
    this.url = url
  }
  // 请求get  post  ...
  // post不行，在预览器中post没有效果
  get(data?) {
    let params = ''
    if (data) {
      params = '?'
      for (let k in data) {
        params += k + '=' + data[k] + '&'
      } // 可以把最后一个&去掉
      params = params.substring(0, params.length - 1)
    }
    return http.createHttp().request(Http.host + this.project + this.url + params)
  }

  parse(resp) { // 不用太研究这个东西是怎么封装的12
    let data = `${resp.result}`
    console.log(data.split('/').join('\\'))
    return JSON.parse(data)
  }
}