# BlogDemos
本项目主要保存一些自己平时写的博文Demo或者一些小实验


[![platform](https://img.shields.io/badge/platform-iOS-red.svg)]()
[![weibo](https://img.shields.io/badge/weibo-%40杭城小刘-green.svg)](http://weibo.com/3194053975/profile?rightmod=1&wvr=6&mod=personinfo&is_hot=1)
[![Updated](https://img.shields.io/badge/Updated-2017--08--24-green.svg)]()

### Demo1:模仿微信公众号文章效果，长按UIWebView上的图片，弹出对话框，用户点击确定则保存图片到本地相册。

#### 主要思路

* 给UIWebView添加长按手势
* 监听手势动作，拿到坐标点\(x,y\)
* UIWebView注入js:Document.elementFromPoint\(x,y\).src拿到img标签的src
* 判断拿到的src是否有值，有值则代表点击的网页上的img标签，此时弹出对话框，是否保存到相册。如果src为空，则代表点击网页上的非img标签，则不需要弹出对话框。
* 拿到图片的url，生成UIImage
* 图片保存到相册

#### 有巨坑

* 长按手势事件不能每次都响应，据我猜测UIWebView本身就有很多事件，所以实现下UIGestureRecognizerDelegate代理方法。长按手势准确率100%

* 如果需要查看详情请看[博文](http://www.jianshu.com/p/9304a1e7ae97)或者下载代码运行查看效果。


*各位同学觉得有帮助的欢迎给个star，我会继续优化代码。
如果有不懂的地方可以加入QQ交流群讨论：<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c9dc4ab0b2062e0004b3b2ed556da1ce898631742e15780297feb3465ad08eda">**515066271**</a>。这个QQ群讨论技术范围包括：iOS、H5混合开发、前端开发、PHP开发，欢迎大家讨论技术。
