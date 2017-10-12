# BlogDemos
本项目主要保存一些自己平时写的博文Demo或者一些小实验


[![platform](https://img.shields.io/badge/platform-iOS-red.svg)]()
[![weibo](https://img.shields.io/badge/weibo-%40杭城小刘-green.svg)](http://weibo.com/3194053975/profile?rightmod=1&wvr=6&mod=personinfo&is_hot=1)
[![Updated](https://img.shields.io/badge/Updated-2017--10--12-green.svg)]()

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


### Demo2:模仿外卖App实现双列表联动功能。

#### 主要思路

* 左边的UITableView是只有1个section和n个row
* 右边的UITableView具有n个section（这里的section 个数恰好是左边UITableView的row数量），且每个section下的row由对应的数据源控制

#### 缺陷

* 观察了下，发现右侧滚动的时候左侧会上下选中，所以也就是只要让右侧滚动的时候，左侧的UITableView单方向选中，不要滚动就好，所以由于UITableView也是UIScrollview，所以在scrollViewDidScroll方法中判断右侧的UITableView是向上还是向下滚动，以此作为判断条件来让左侧的UITableView选中相应的行。

* 且之前是在scrollview代理方法中让左侧的tableview选中，这样子又会触发左侧tableview的选中事件，从而导致右侧的tablview滚动，造成不严谨的联动逻辑

## 效果图

* 如果需要查看详情请看[博文](http://www.jianshu.com/p/dab98fbe0736)或者下载代码运行查看效果。
* ![效果图](https://raw.githubusercontent.com/FantasticLBP/iOSKonwledge-Kit/master/assets/2017-09-24%2015_35_52.gif "效果图")

...

### 接下来的更新都会在我的博文中列出来，欢迎关注  [博文地址](https://fantasticlbp.github.io)

*各位同学觉得有帮助的欢迎给个star，我会继续优化代码。
如果有不懂的地方可以加入QQ交流群讨论：<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c9dc4ab0b2062e0004b3b2ed556da1ce898631742e15780297feb3465ad08eda">**515066271**</a>。这个QQ群讨论技术范围包括：iOS、H5混合开发、前端开发、PHP开发，欢迎大家讨论技术。
