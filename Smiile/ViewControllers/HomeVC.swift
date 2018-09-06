//
//  HomeVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    //MARK: Variables
    fileprivate var contentOffsetDictionary: Dictionary<AnyHashable, AnyObject>!
    fileprivate var currentCellDictionary: Dictionary<AnyHashable, Int>!
    
    fileprivate var sections = [SmiileSection]() {
        didSet { self.tableView.reloadData() }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = tr("common.home")
        
        contentOffsetDictionary = Dictionary<NSObject, AnyObject>()
        currentCellDictionary = Dictionary<NSObject, Int>()
        
        SectionService.getFakeSections { (error, sections) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else if let sections = sections {
                self.sections = sections
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let search bar visible when arriving on the screen
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.smiileExtraLightGrey
        
        updateNavBar()
        configureTableView()
    }
    
    func updateNavBar() {
        // SearchBar new in iOS 11 :)
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = tr("common.search")
        // todo : implement another VC to filter result, don't forget the Scope Bar to filter the results
        //search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-profile"), style: .done, target: self, action: #selector(showProfile))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.smiileExtraLightGrey
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.cellIdentifier())
        tableView.register(HomeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HomeTableViewHeader.headerIdentifier())
        tableView.tableFooterView = UIView()
    }
    
    @objc func showProfile() {
        self.present(ProfileVC(), animated: true, completion: nil)
    }
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].numberOfElements == 0 {
            return 0
        }
        return NewsCollectionViewCell.contentSize().height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.cellIdentifier()) as! HomeCell
        cell.collectionView.contentInset = UIEdgeInsets(top: 0, left: Theme.MarginBig, bottom: 0, right: Theme.MarginBig)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let collectionCell = cell as! HomeCell
        collectionCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.section)
        
        collectionCell.collectionView.delegate = self
        collectionCell.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        let index = collectionCell.collectionView.tag
        let value = contentOffsetDictionary[index]
        let horizontalOffset = value != nil ? CGFloat(value!.floatValue) : -Theme.MarginBig
        collectionCell.collectionView.setContentOffset(CGPoint(x: horizontalOffset, y: 0), animated: false)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].numberOfElements == 0 {
            return 0
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeader.headerIdentifier()) as! HomeTableViewHeader
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? HomeTableViewHeader else { return }
        let currentSection = sections[section]
        headerView.setHeaderTitle(currentSection.name)
        headerView.delegate = self
        headerView.tag = section
    }
    
    //MARK: UIScrollViewDelegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? HomeCollectionView else { return }
        let currentCell = Int(round(scrollView.contentOffset.x / NewsCollectionViewCell.contentSize().width))
        currentCellDictionary[collectionView.tag] = currentCell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? HomeCollectionView else { return }
        
        let width = scrollView.contentSize.width
        let cells = collectionView.numberOfItems(inSection: 0)
        var currentCell = Int(round(targetContentOffset.pointee.x/(width/CGFloat(cells))))
        
        let value = currentCellDictionary[collectionView.tag]
        if value != nil && value == currentCell && cells > currentCell {
            currentCell = velocity.x > 0 ? currentCell+1 : currentCell-1
        }
        
        targetContentOffset.pointee.x = CGFloat(currentCell)*(width/CGFloat(cells)) - Theme.MarginBig
        contentOffsetDictionary[collectionView.tag] = targetContentOffset.pointee.x as AnyObject
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.sections[collectionView.tag].type == SectionType.news {
            return NewsCollectionViewCell.contentSize()
        }
        return AdvertsCollectionViewCell.contentSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[collectionView.tag].numberOfElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.sections[collectionView.tag]
        
        if section.type == SectionType.news {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.cellIdentifier(), for: indexPath) as! NewsCollectionViewCell
            cell.news = section.newsAtIndex(indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertsCollectionViewCell.cellIdentifier(), for: indexPath) as! AdvertsCollectionViewCell
            cell.adverts = section.advertsAtIndex(indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let section = self.sections[collectionView.tag]
//        let controllerToPush: UIViewController!
//        if section.type == SectionType.news {
//            guard let news = self.sections[collectionView.tag].newsAtIndex(indexPath.row) else { return }
//            controllerToPush = NewsDetailVC(news)
//        } else {
//            guard let adverts = self.sections[collectionView.tag].advertsAtIndex(indexPath.row) else { return }
//            controllerToPush = AdvertsDetailVC(adverts)
//        }
//        navigationController?.pushViewController(viewController: controllerVC, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let smiileSection = sections[collectionView.tag]
        let displayedCellIndex = indexPath.row
        
        // Infinite scroll, request 5 elements
        if displayedCellIndex == smiileSection.numberOfElements - 3 {
            
            //            guard let smiileSectionId = smiileSection.id else { return }
            //            let newPage = smiileSection.currentPage + 1
            //            SectionService.section(smiileSectionId, type: smiileSection.type?.rawValue ?? "", perPage: 5, page: newPage, completion: { (error, section) in
            //
            //                DispatchQueue.main.async {
            //                    guard let section = section else { return }
            //                    smiileSection.currentPage = newPage
            //
            //                    if smiileSection.type == SectionType.news {
            //                        guard let news = section.news, news.count != 0 else { return }
            //                        smiileSection.appendNews(news)
            //                    } else {
            //                        guard let adverts = section.adverts, adverts.count != 0 else { return }
            //                        smiileSection.appendAdverts(adverts)
            //                    collectionView.reloadData()
            //                }
            //            })
        }
    }
}

//MARK: HomeTableHeaderViewDelegate
extension HomeVC: HomeTableHeaderViewDelegate {
    func didTapHeaderViewAtSection(_ section: Int) {
//        let controllerToPush: UIViewController!
//        let smiileSection = sections[collectionView.tag]
//        if smiileSection.type == news {
//            controllerToPush = NewsVC(smiileSection.news)
//        } else {
//            controllerToPush = AdvertsVC(smiileSection.adverts)
//        }
//        navigationController?.pushViewController(viewController: controllerVC, completion: nil)
    }
}
