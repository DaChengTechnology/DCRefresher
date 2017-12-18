# DCRefresher
UIScrollview Header and Footer refresher for UITableView on swift  
DCRefresher is used in UIUITableView to refresh and pull more functional modules  
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
