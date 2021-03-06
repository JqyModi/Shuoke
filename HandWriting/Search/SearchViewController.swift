//
//  SearchViewController.swift
//  HandWriting
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.delegate = self
            tableView.dataSource = self
//            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: StoryBoard.SearchCell)
            tableView.tableFooterView = UIView()
            //设置表格自动行高
            tableView.estimatedRowHeight = tableView.rowHeight //storyboard中的高度：估计值
            tableView.rowHeight = UITableViewAutomaticDimension //将高度估计值换为计算后的真实值
            
//            tableView.backgroundColor = UIColor.randomColor()
        }
    }
    
    var searchController: UISearchController? {
        didSet {
            searchController?.delegate = self
            //设置搜索结果显示
            searchController?.searchResultsUpdater = self
            tableView.tableHeaderView = searchController?.searchBar
            searchController?.searchBar.placeholder = "请输入视频、讲义、碑帖名称"
            searchController?.searchBar.searchBarStyle = .prominent
            searchController?.searchBar.backgroundColor = UIColor.init(white: 1, alpha: 0.93)
            //觉得searchBar是否可以跟随父控制器滚动显示
            self.definesPresentationContext = true
            searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
            searchController?.searchBar.delegate = self
            searchController?.dimsBackgroundDuringPresentation = false
            
        }
    }
    
    struct StoryBoard {
        static let SearchCell = "SearchCell"
    }
    
    //Model
    var searchResults: [SearchModel]? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {

        self.tableView.reloadData()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     更改导航栏颜色
     */
    func naviStyle(viewController: UINavigationController, color: UIColor){
        viewController.navigationBar.tintColor = color
        viewController.navigationBar.barTintColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchResultsController：nil表示当前显示搜索结果的控制器就是当前控制器
        searchController = UISearchController.init(searchResultsController: nil)
        //改变导航栏颜色
        naviStyle(viewController: self.navigationController!, color: UIColor.Tabbar1Color)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIScrollViewDelegate {
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.SearchCell) as! SearchTableViewCell
        if  cell == nil {
            cell = SearchTableViewCell(style: .default, reuseIdentifier: StoryBoard.SearchCell)
        }
        //获取数据
        let row = indexPath.row
        let data = searchResults![row]
        cell.searchModel = data
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        tapToViewController(indexPath: indexPath)
    }
    
    func tapToViewController(indexPath: IndexPath) {
        let row = indexPath.row
        let item = searchResults![row]
        let model = item.model
        
        var detailData = NSMutableDictionary()
        switch model {
        case "read":   //阅读
            detailData.removeAllObjects()
            detailData.setValue(1, forKey: "pid")
            detailData.setValue(item.id, forKey: "id")
            detailData.setValue(item.title, forKey: "title")
            detailData.setValue(item.model, forKey: "model")
            break;
        case "beitie":  //碑帖
            detailData.removeAllObjects()
            detailData.setValue(item.id, forKey: "id")
            detailData.setValue(item.title, forKey: "title")
            detailData.setValue(item.model, forKey: "model")
            break;
        case "note":    //讲义
            detailData.removeAllObjects()
            detailData.setValue(item.path, forKey: "video")
            detailData.setValue(item.title, forKey: "title")
            detailData.setValue(item.model, forKey: "model")
            break;
        case "video_play":    //视频
            detailData.removeAllObjects()
            let video = Video(name: item.title, img_url: item.imgUrls, img_url_s: item.imgUrls, video_url: item.path)
            detailData.setValue(item.model, forKey: "model")
            detailData.setValue(video, forKey: "video")
            detailData.setValue(self, forKey: "searchVC")
            break;
        case "peixun":    //培训
            break;
        default:
            debugPrint("*****")
            break;
        }
        
        //获取待跳转的VC
        //获取数据
        let service = ServiceLocator.sharedInstance
        var vc: UIViewController?
        if let model = detailData["model"] as? String {
            switch model {
            case "read":   //阅读
                vc = service.provideStudyDetailViewController(detailData: detailData)
                break;
            case "beitie":  //碑帖
                vc = service.provideCopyBookDetailViewController(detailData: detailData)
                break;
            case "note":    //讲义
                vc = service.provideLectureDetailViewController(detailData: detailData)
                break;
            case "video_play":    //视频
                let video = detailData.value(forKey: "video") as? Video
                vc = service.provideVideoDetailViewController(item: video!)
                break;
            case "peixun":    //培训
                break;
            default:
                debugPrint("*****")
                break;
            }
            
            if model != "video_play" {
                self.navigationController?.push(viewController: vc!, animated: true)
            }else {
                self.navigationController?.viewControllers[0].present(vc!, animated: true, completion: nil)
            }
            
        }
    }
    
    //MARK:- UISearchBarDelegate
    //MARK:- UISearchControllerDelegate
    
    //MARK:- UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //获取输入框文字进行搜索
        let searchText = searchController.searchBar.text
        let page = 1
        getSearchResults(searchText: searchText!,page: page){ [weak self] (results) in
            if results.count > 0 {
                self?.searchResults = results
            }else {
                self?.searchResults?.removeAll()
                self?.searchResults = nil
                self?.updateUI()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //关闭searchController防止遮罩挡住操作
        searchController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        //隐藏键盘
        self.searchController?.searchBar.resignFirstResponder()
        
        //改变状态栏颜色
        
    }
    
}
