//
//  ViewController.swift
//  QQProfileProject
//
//  Created by zhifu360 on 2019/5/16.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: IsSystemVersion11 ? -StatusBarHeight : 0, width: ScreenSize.width, height: ScreenSize.height + (IsSystemVersion11 ? StatusBarHeight : 0)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: BaseTableReuseIdentifier)
        //设置内容偏移
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    ///topImageView
    lazy var topImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "2.jpg"))
        imgView.frame = CGRect(x: 0, y: -200, width: ScreenSize.width, height: 200)
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        imgView.tag = 101
        return imgView
    }()
    
    ///navigationBar
    lazy var navigationBar: CustomNavigationBar = {
        let bar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: StatusBarHeight+NavigationBarHeight))
        bar.alpha = 0
        bar.backgroundColor = RandomColor
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }

    func setPage() {
        view.addSubview(tableView)
        tableView.addSubview(topImageView)
        view.addSubview(navigationBar)
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "第\(indexPath.row)行"
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y + (200 + StatusBarHeight)
        
        //修改导航栏透明度
        if offSetY >= StatusBarHeight + NavigationBarHeight {
            navigationBar.alpha = 1
        } else {
            navigationBar.alpha = (offSetY < 0 ? 0 : offSetY) / (StatusBarHeight + NavigationBarHeight)
        }
        
        if scrollView.contentOffset.y < -200 {
            //获取头部UIImageView
            var rect = tableView.viewWithTag(101)!.frame
            //固定图片顶部位置
            rect.origin.y = scrollView.contentOffset.y
            //修改图片高度
            rect.size.height = -scrollView.contentOffset.y
            tableView.viewWithTag(101)!.frame = rect
        }
        
    }
    
}

