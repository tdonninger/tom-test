//
//  MenuVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

struct MenuRows {
    var name: String
    var handler: (() -> (Void))?
    var badge: Int = 0
    var iconName: String
    
    init(name: String, iconName: String = "", handler: (() -> (Void))?, badge: Int = 0) {
        self.name = name
        self.handler = handler
        self.badge = badge
        self.iconName = iconName
    }
}

struct MenuSection {
    var name: String
    var menus = [MenuRows]()
    
    init(name: String){
        self.name = name
    }
}

class MenuVC: UITableViewController {

    //MARK: Variables
    var results = [MenuSection]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = tr("common.menu")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        setupSectionsAndRows()
        
        tableView.backgroundColor = UIColor.smiileExtraLightGrey
        tableView.separatorColor = UIColor.lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.cellIdentifier())
        //Avoid empty cells
        tableView.tableFooterView = UIView()
    }
    
    func setupSectionsAndRows() {        
        var section1 = MenuSection(name: tr("menu.section.1"))
        
        section1.menus.append(MenuRows(name: tr("menu.profile"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.profile"))
        }))
        section1.menus.append(MenuRows(name: tr("menu.settings"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.settings"))
        }))
        section1.menus.append(MenuRows(name: tr("menu.location"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.location"))
        }))
        
        var section2 = MenuSection(name: tr("menu.section.2"))
        section2.menus.append(MenuRows(name: tr("menu.neighbour.life"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.neighbour.life"))
        }))
        section2.menus.append(MenuRows(name: tr("menu.neighbour"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.neighbour"))
        }))
        section2.menus.append(MenuRows(name: tr("menu.news"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.news"))
        }))
        
        var section3 = MenuSection(name: tr("menu.section.3"))
        section3.menus.append(MenuRows(name: tr("menu.help"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.help"))
        }))
        section3.menus.append(MenuRows(name: tr("menu.invite"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.invite"))
        }))
        section3.menus.append(MenuRows(name: tr("menu.logout"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.logout"))
        }))
        section3.menus.append(MenuRows(name: tr("menu.delete.account"), iconName: "icon-", handler: { () -> (Void) in
            // Todo
            print(tr("menu.delete.account"))
        }))
        
        results = [section1, section2, section3]
    }
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return results[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.smiileBlue

        let label = UILabel()
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.right.equalTo(ScreenWidth).inset(Theme.MarginDefault)
        }
        label.setFont(UIFont.systemFont(ofSize: 22), color: UIColor.white)
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results[section].menus.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuCell.height()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellIdentifier()) as! MenuCell
        
        let menu = results[indexPath.section].menus[indexPath.row]
        cell.textLabel?.text = menu.name
        cell.imageView?.image = UIImage(named: menu.iconName)
        
        if menu.badge > 0 {
            cell.notificationsLabel.text = "\(menu.badge)"
            cell.notificationsLabel.superview!.isHidden = false
        }
        else {
            cell.notificationsLabel.superview!.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.results[indexPath.section].menus[indexPath.row].handler?()
    }
}
