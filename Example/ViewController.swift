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

    var refreshed = false
    var colors = [UIColor]()
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colors = [
            UIColor(hex: 0xE5D7EE),
            UIColor(hex: 0xD5E0F1),
            UIColor(hex: 0xC8EFEA),
            UIColor(hex: 0xEEF5D3),
            UIColor(hex: 0xF9DFD5)
        ]
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func refresh() {
        self.slideCells(.Disappearance)
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.endRefresh()
        })
    }

    override func endRefresh() {
        self.refreshControl?.endRefreshing()
        refreshed = true
        self.slideCells(.Appearance)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        cell.imageView?.image = UIImage(named: "icon")

        var index = indexPath.row
        if refreshed {
            index += 3
        }
        let i = index%colors.count
        cell.imageView?.backgroundColor = colors[i]
        cell.textLabel?.textColor = UIColor.grayColor()
        cell.textLabel?.text = "\(indexPath.row): --------------------------"

        return cell
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}