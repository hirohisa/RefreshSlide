//
//  TableViewController.swift
//  RefreshSlide
//
//  Created by Hirohisa Kawasaki on 2015/02/11.
//  Copyright (c) 2015年 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

public class TableViewController: UITableViewController {

    public enum State {
        case Appearance
        case Disappearance
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func refresh() {
        self.slideCells(.Disappearance)
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.endRefresh()
        })
    }

    public func endRefresh() {
        self.refreshControl?.endRefreshing()
        self.slideCells(.Appearance)
    }

    func _reloadData(state: State) {
        var x = CGFloat(0.0)
        var alpha = CGFloat(0.0)

        switch state {
        case .Appearance:
            x = -CGRectGetWidth(self.tableView.frame)
        case .Disappearance:
            alpha = 1
        }

        self.tableView.reloadData()
        let tableViewCells = self.tableView.visibleCells() as [UITableViewCell]
        for tableViewCell in tableViewCells {
            let y = CGRectGetMinY(tableViewCell.frame)
            let width = CGRectGetWidth(tableViewCell.frame)
            let height = CGRectGetHeight(tableViewCell.frame)

            tableViewCell.alpha = alpha
            tableViewCell.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }

    public func slideCells(state: State) {
        self._slideCells(state)
    }

    func _slideCells(state: State) {
        self._reloadData(state)
        let tableViewCells = self.tableView.visibleCells() as [UITableViewCell]
        var timeinterval = 0.01
        for tableViewCell in tableViewCells {
            let delay = timeinterval * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                self._slideCell(tableViewCell, state: state)
            })
            timeinterval += 0.1
        }
    }

    func _slideCell(tableViewCell: UITableViewCell, state: State) {
        var x = CGFloat(0.0)
        var alpha = CGFloat(0.0)
        switch state {
        case .Appearance:
            alpha = 1
        case .Disappearance:
            x = CGRectGetMaxX(self.tableView.frame)
        }

        let y = CGRectGetMinY(tableViewCell.frame)
        let width = CGRectGetWidth(tableViewCell.frame)
        let height = CGRectGetHeight(tableViewCell.frame)
        UIView.animateWithDuration(1.0, animations: { _ in
            tableViewCell.alpha = alpha
            tableViewCell.frame = CGRect(x: x, y: y, width: width, height: height)
        })
    }

}
