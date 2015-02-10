//
//  ViewController.swift
//  Example
//
//  Created by Hirohisa Kawasaki on 2015/02/11.
//  Copyright (c) 2015年 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import RefreshSlide

class ViewController: RefreshSlide.TableViewController {

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.grayColor()

        return cell
    }

}

