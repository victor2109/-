//
//  XTLrcVC.swift
//  myPlayer
//
//  Created by victor on 16/11/24.
//  Copyright © 2016年 victor. All rights reserved.
//

import UIKit

class XTLrcVC: UITableViewController {
    
    /* 负责歌词进度 */
    var progressLrc : CGFloat = 0 {
        didSet {
            let indexPath = IndexPath(row: scrollRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as? XTLrcTableCell
            cell?.progress = progressLrc
        }
    }
    
    /* 负责滚动 */
    var scrollRow = 0 {
        didSet {
            
            if scrollRow == oldValue {
                return
            }
            /* 先刷新在 做运动 */
            let index = tableView.indexPathsForVisibleRows
            tableView.reloadRows(at: index!, with: .fade)
            
            let indexPath = IndexPath(row: scrollRow, section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    var lrcMs : [XTLrcModel] = [XTLrcModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.height / 2, left: 0, bottom: tableView.height / 2, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = XTLrcTableCell.cellWithTableView(tableView)
        if indexPath.row == scrollRow {
            cell.progress = progressLrc
        } else {
            cell.progress = 0
        }
        let model = lrcMs[indexPath.row]
        cell.lrcConent = model.conent
        return cell
    }

}

extension XTLrcVC {
    func setUpConfig() {
        tableView.separatorStyle = .none
    }
}
