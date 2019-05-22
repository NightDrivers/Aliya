//
//  HomeViewController.swift
//  Aliya
//
//  Created by ldc on 2019/5/22.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import UIKit
import BaseKit

struct Item {
    
    var type: UIViewController.Type
    var title: String
}

class HomeViewController: UIViewController {
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "主页"
        initItems()
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func initItems() -> Void {
        
        var item: Item
        item = Item(type: ScrollableSegmentedControllTestViewController.self, title: "滑动多项选择器")
        items.append(item)
    }

    lazy var tableView: UITableView = {
        let temp = UITableView.init(frame: .zero, style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        view.addSubview(temp)
        return temp
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let iden = "iden"
        var cell = tableView.dequeueReusableCell(withIdentifier: iden)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: iden)
        }
        cell?.textLabel?.text = items[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        let i = item.type.init()
        navigationController?.pushViewController(i, animated: true)
    }
}
