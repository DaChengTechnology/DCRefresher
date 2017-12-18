//
//  ViewController.swift
//  DCRefresherTest
//
//  Created by dacheng on 2017/12/16.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import UIKit
import DCRefresher

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var arr:[String] = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "DCTestTableViewCell", bundle: nil), forCellReuseIdentifier: "Test")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dc_header = DCDefualtHeader(closure: {
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
                self.tableView.dc_header?.setState(state: .refreshed)
            })
        })
        tableView.dc_footer = DCDefualtFooter(closure: {
            for _ in 1...20 {
                self.arr.append("测试数据")
            }
            let offset = self.tableView.contentOffset
            self.tableView.reloadData()
            self.tableView.dc_footer?.setState(state: .refreshed)
            //self.tableView.setContentOffset(offset, animated: false)
        })
        generateData()
    }
    
    func generateData() {
        for i in 1...20 {
            arr.append("测试数据\(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test") as! DCTestTableViewCell
        cell.mytext.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

