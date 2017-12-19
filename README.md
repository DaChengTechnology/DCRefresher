# DCRefresher
UIScrollview Header and Footer refresher for UITableView on swift  
DCRefresher is used in UIUITableView to refresh and pull more functional modules  
## installation   
### Requirements
ios 11  
swift 4.0
### Cocospod  
            pod 'DCRefresher'
## use
if you want to add a header for UITableView, you can do it  
```
tableView.dc_header = DCDefualtHeader(closure: {
            // to do you want on in Refreshing state
        })//swift
```
setting header auto alpha
```
tableView.dc_header?.isAutomaticallyChangeAlpha = true
```
setting begin refresh before at slided to a postion  
The distance is the distance from the top(if it is `dc_footer`, It's the distance from the bottom)
```
tableView.dc_header?.setMidRefresh(refresh: true, distance: 200)
```
You can set the header or footer state use it.
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
## DIY
If you need DIY header or footer,you can create a class inherit 'DCNormalHeader' or 'DCNormalFooter'. and override the 'onNormal','onWillRefresh','onRefreshing','onRefreshed','onNoMore' function.  
### Note: 
remember run the super functiion
### Method
clear()-clear all subviews
### Attribute
```
var oldState:DCRefresherState?//last state
```
