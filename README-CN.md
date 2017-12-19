# DCRefresher
DCRefresher是基于UIScrllView用于UITableView等控件的上拉下拉刷新器
## 安装
### 环境需求
ios 11  
swift 4.0
### Cocosspod
```
 pod 'DCRefresher'
```
## 使用
给UItableView添加一个header
```
tableView.dc_header = DCDefualtHeader(closure: {
            // to do you want on in Refreshing state
        })//swift
```
设置自动透明度
```
tableView.dc_header?.isAutomaticallyChangeAlpha = true
```
设置不到底刷新  
distance表示当前位置与顶部的距离（如果是'dc_footer'就表示与底部的距离）
```
tableView.dc_header?.setMidRefresh(refresh: true, distance: 200)
```
设置heaader或者footer的状态
```
tableView.dc_header?.setState(state: .refreshed)
public enum DCRefresherState {
    ///普通状态(nomal state)
    case normal
    ///将要刷新(will refresh state)
    case willRefresh
    ///正在刷新(refreshing state)
    case refreshing
    ///刷新完成(refreshed state)
    case refreshed
    ///没有更多(no more state)
    case noMore
}
```
## 自定义
如果你需要自定义你可以继承'DCNormalHeader'或者'DCNormalFooter'并且要重写这五个方法'onNormal','onWillRefresh','onRefreshing','onRefreshed','onNoMore'
### 注意
要执行父类方法哦
### 所用函数
clear()清空内部所有控件
### 内部属性
```
var oldState:DCRefresherState?//last state
```
