//
//  CopyBookDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import SVProgressHUD

private struct Config {
    static let numberOfColumns = 2
    static let cellWidth = 130
    static let cellHeight = 160
    static let headerHeight = 60
    static let footerHeight = 20
    static let cellMargin = 8
}
class CopyBookDetailViewController: HandWritingViewController, BothamCollectionViewController, CopyBookDetailUI {
    var data: [CopyBookDetail]? {
        didSet {
//            preparePageData()
        }
    }
    var itemControllers = NSMutableArray()
    
    func preparePageData() {
        if let datas = data {
            if datas.count > 0 {
                for item in datas {
                    let ivc = ImageViewController()
                    ivc.imageURL = URL(string: item.img_url)
                    itemControllers.add(ivc)
                }
            }
        }
    }
    
    var dataSource: CopyBookDetailCollectionViewDataSource!
//    var dataSource: BothamCollectionViewDataSource<CopyBookDetail,CopyBookDetailCollectionViewCell>
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
//        configureNavigationBar()
        configureCollectionView()
        super.viewDidLoad()
        
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor = UIColor.navigationBarColor
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
//    func configureHeader(_ copyBook: Common) {
//        dataSource.copyBookHeader = copyBook
//    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    private func configureCollectionView() {
        collectionView.registerNib(nibName: "CopyBookDetailCollectionViewCell", forCellReuseIdentifier: CopyBookDetailCollectionViewCell.reuseIdentifier)
        
        dataSource = CopyBookDetailCollectionViewDataSource()
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let topInset = navBarHeight + statusBarHeight
        collectionView.accessibilityLabel = "CopyBookDetailCollectionView"
        collectionView.contentInset = UIEdgeInsetsMake(-topInset, 0, 0, 0)
        collectionView.dataSource = dataSource
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: CGFloat(Config.headerHeight))
        layout.itemSize = CGSize(
            width: (view.frame.width - CGFloat(Config.cellMargin)*3)  / CGFloat(Config.numberOfColumns),
            height: CGFloat(Config.cellHeight))
        layout.minimumInteritemSpacing = CGFloat(Config.cellMargin)
        layout.minimumLineSpacing = CGFloat(Config.cellMargin)
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}
extension CopyBookDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取到已设置好数据的Cell
        let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) as? CopyBookDetailCollectionViewCell
        //取出数据
        if let imageURL = cell?.imageURL {
            debugPrint("imageURL = \(imageURL)")
            if collectionView.numberOfSections != 0 {
                debugPrint("count = \(collectionView.numberOfSections)")
                let totalCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: collectionView.numberOfSections)
                //跳转到图片展示界面
                let pivc = PageImageViewController()
                pivc.items = data
                //当前选中的图片
                pivc.selectIndex = indexPath.row
//                pivc.itemControllers = self.itemControllers
//                pivc.data = PageImageViewModel(imageURL: imageURL, indexPath: indexPath, totalCount: totalCount!)
//                self.navigationController?.push(viewController: pivc, animated: true)
                self.present(pivc, animated: true, completion: nil)
            }
        }
    }
    
    
}
