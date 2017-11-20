//
//  ServiceLocator.swift
//  HandWriting
//
//  Created by mac on 17/8/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import BothamUI

class ServiceLocator {
    
    static let sharedInstance = ServiceLocator()
    let navigatorContainer = BothamNavigatorContainer()
    
    private init() { }
    
    private func provideMainStoryboard() -> BothamStoryboard {
        return BothamStoryboard(name: "Main")
    }
    
    private func providePageHomeWireframe() -> PageHomeWireframe {
        return PageHomeWireframe()
    }
    
    //MARK: -HomeTabWireframe
    private func provideDailyWireframe() -> DailyWireframe {
        return DailyWireframe()
    }
    private func provideCopyBookWireframe() -> CopyBookWireframe {
        return CopyBookWireframe()
    }
    private func provideLectureWireframe() -> LectureWireframe {
        return LectureWireframe()
    }
    private func provideSightWireframe() -> SightWireframe {
        return SightWireframe()
    }
    private func provideFamousWireframe() -> FamousWireframe {
        return FamousWireframe()
    }
    private func provideStudyWireframe() -> StudyWireframe {
        return StudyWireframe()
    }
    
    private func provideWritingWireframe() -> WritingWireframe {
        return WritingWireframe()
    }
    private func provideVideoWireframe() -> VideoWireframe {
        return VideoWireframe()
    }
    private func provideUserWireframe() -> UserWireframe {
        return UserWireframe()
    }
    private func provideRecordWireframe() -> RecordWireframe {
        return RecordWireframe()
    }
    private func provideDownloadWireframe() -> DownloadWireframe {
        return DownloadWireframe()
    }

    //MARK 设置导航标题栏
//    func provideHomeNavigator() -> HomeNavigationController? {
//        return navigatorContainer.resolve()
//    }
    func provideHomePageNavigator() -> HomePageViewNavigationController? {
        return navigatorContainer.resolve()
    }
    
    func provideDailyNavigator() -> DailyNavigationController? {
        return navigatorContainer.resolve()
    }
   
    func provideWritingNavigator() -> WritingNavigationController? {
        return navigatorContainer.resolve()
    }
    
    func provideVideoNavigator() -> VideoNavigationController? {
        return navigatorContainer.resolve()
    }
    
    func provideUserNavigator() -> UserNavigationController? {
        return navigatorContainer.resolve()
    }
    
    func provideRecordNavigator() -> RecordNavigationController? {
        return navigatorContainer.resolve()
    }
    
    func provideRootTabBarController() -> UITabBarController {
        let viewController: UITabBarController = provideMainStoryboard().instantiateViewController("RootTabBarController")
        return viewController
    }

    func provideHomePageViewNavigationController() -> HomePageViewNavigationController {
        let viewController = provideHomePageViewViewController()
        return HomePageViewNavigationController(rootViewController: viewController)
    }
    //注册HomeTab bar导航栏
    func provideDailyNavigationController() -> DailyNavigationController {
        let viewController = provideDailyViewController()
        return DailyNavigationController(rootViewController: viewController)
    }
    func provideSightNavigationController() -> SightNavigationController {
        let viewController = provideSightViewController()
        return SightNavigationController(rootViewController: viewController)
    }
    func provideFamousNavigationController() -> FamousNavigationController {
        let viewController = provideFamousViewController()
        return FamousNavigationController(rootViewController: viewController)
    }
    func provideStudyNavigationController() -> StudyNavigationController {
        let viewController = provideStudyViewController()
        return StudyNavigationController(rootViewController: viewController)
    }
    func provideCopyBookNavigationController() -> CopyBookNavigationController {
        let viewController = provideCopyBookViewController()
        return CopyBookNavigationController(rootViewController: viewController)
    }
    func provideLectureNavigationController() -> LectureNavigationController {
        let viewController = provideLectureViewController()
        return LectureNavigationController(rootViewController: viewController)
    }
    func provideRecordNavigationController() -> RecordNavigationController {
        let viewController = provideRecordViewController()
        return RecordNavigationController(rootViewController: viewController)
    }
    func provideDownloadNavigationController() -> DownloadNavigationController {
        let viewController = provideDownloadViewController()
        return DownloadNavigationController(rootViewController: viewController)
    }
    
    func provideWritingNavigationController() -> WritingNavigationController {
        let viewController = provideWritingViewController()
        return WritingNavigationController(rootViewController: viewController)
    }
    func provideVideoNavigationController() -> VideoNavigationController {
        let viewController = provideVideoViewController()
        return VideoNavigationController(rootViewController: viewController)
    }
    func provideUserNavigationController() -> UserNavigationController {
        let viewController = provideUserViewController()
        return UserNavigationController(rootViewController: viewController)
    }
    
    //MARK: -HomeTabDataSource
    private func provideDailyTableViewDataSource() -> BothamTableViewDataSource<Common, DailyTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideCopyBookTableViewDataSource() -> BothamTableViewDataSource<Common, CopyBookTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideLectureTableViewDataSource() -> BothamTableViewDataSource<Common, LectureTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideSightTableViewDataSource() -> BothamTableViewDataSource<Common, SightTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideFamousTableViewDataSource() -> BothamTableViewDataSource<Common, FamousTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideStudyTableViewDataSource() -> BothamTableViewDataSource<Common, StudyTableViewCell> {
        return BothamTableViewDataSource()
    }
    
    
    private func provideWritingTableViewDataSource() -> BothamTableViewDataSource<Writing, WritingTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideVideoTableViewDataSource() -> BothamTableViewDataSource<Video, VideoTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideUserTableViewDataSource() -> BothamTableViewDataSource<User, UserTableViewCell> {
        return BothamTableViewDataSource()
    }
//    private func provideRecordTableViewDataSource() -> BothamTableViewDataSource<Record, RecordTableViewCell> {
//        return BothamTableViewDataSource()
//    }
    private func provideWritingDetailViewDataSource() -> BothamTableViewDataSource<WritingDetail, WritingDetailTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideAccountTableViewDataSource() -> BothamTableViewDataSource<Account, AccountTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideRecordTableViewDataSource() -> BothamTableViewDataSource<Record, RecordTableViewCell> {
        return BothamTableViewDataSource()
    }
    private func provideDownloadTableViewDataSource() -> BothamTableViewDataSource<Download, DownloadTableViewCell> {
        return BothamTableViewDataSource()
    }
    
    func provideHomePageViewViewController() -> HomeViewPagerController {
        let viewController: HomeViewPagerController = provideMainStoryboard().instantiateViewController()
        //暂时不需要
        let presenter = HomeViewpagerPresenter(wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - HomeTab
    func provideDailyViewController() -> DailyViewController {
        let viewController: DailyViewController = provideMainStoryboard().instantiateViewController()
        let presenter = DailyPresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideDailyTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideCopyBookViewController() -> CopyBookViewController {
        let viewController: CopyBookViewController = provideMainStoryboard().instantiateViewController()
        let presenter = CopyBookPresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideCopyBookTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideLectureViewController() -> LectureViewController {
        let viewController: LectureViewController = provideMainStoryboard().instantiateViewController()
        let presenter = LecturePresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideLectureTableViewDataSource()
        viewController.dataSource = dataSource
        //下拉刷新
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //上拉加载
//        viewController.loadToRefreshHandler = BothamLoadToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideSightViewController() -> SightViewController {
        let viewController: SightViewController = provideMainStoryboard().instantiateViewController()
        let presenter = SightPresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideSightTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideFamousViewController() -> FamousViewController {
        let viewController: FamousViewController = provideMainStoryboard().instantiateViewController()
        let presenter = FamousPresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideFamousTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideStudyViewController() -> StudyViewController {
        let viewController: StudyViewController = provideMainStoryboard().instantiateViewController()
        let presenter = StudyPresenter(ui: viewController, wireframe: providePageHomeWireframe())
        viewController.presenter = presenter
        let dataSource = provideStudyTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    
    
    func provideWritingViewController() -> WritingViewController {
        let viewController: WritingViewController = provideMainStoryboard().instantiateViewController()
        let presenter = WritingPresenter(ui: viewController, wireframe: provideWritingWireframe())
        viewController.presenter = presenter
        let dataSource = provideWritingTableViewDataSource()
        viewController.dataSource = dataSource
        //刷新
//        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideVideoViewController() -> VideoViewController {
        let viewController: VideoViewController = provideMainStoryboard().instantiateViewController()
        let presenter = VideoPresenter(ui: viewController, wireframe: provideVideoWireframe())
        //设置代理事件
        viewController.loadCategoryDelegate = presenter.self
        viewController.presenter = presenter
        let dataSource = provideVideoTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate1 = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    
    func provideRecordViewController() -> RecordViewController1 {
        let viewController: RecordViewController1 = provideMainStoryboard().instantiateViewController()
        let presenter = RecordPresenter(ui: viewController, wireframe: provideRecordWireframe())
        viewController.presenter = presenter
        let dataSource = provideRecordTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    
    func provideDownloadViewController() -> DownloadViewController {
        let viewController: DownloadViewController = provideMainStoryboard().instantiateViewController()
        let presenter = DownloadPresenter(ui: viewController, wireframe: provideDownloadWireframe())
        viewController.presenter = presenter
        let dataSource = provideDownloadTableViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //使导航生效： 点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    
    func provideUserViewController() -> UserViewController {
        let viewController: UserViewController = provideMainStoryboard().instantiateViewController()
        let wireframe = provideUserWireframe()
        //设置头像点击事件委托
        wireframe.delegate = viewController.self
        let presenter = UserPresenter(ui: viewController, wireframe: wireframe)
        viewController.presenter = presenter
        let dataSource = provideUserTableViewDataSource()
        viewController.dataSource = dataSource
        //使导航生效： 点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        //设置用户中心头部布局详情页点击事件
        viewController.showDetailDelegate = presenter.self
//        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        return viewController
        
        /*
         var viewController: UserViewController?
         if viewController == nil{
         viewController = provideMainStoryboard().instantiateViewController()
         let wireframe = provideUserWireframe()
         //设置头像点击事件委托
         wireframe.delegate = viewController.self
         let presenter = UserPresenter(ui: viewController!, wireframe: wireframe)
         viewController!.presenter = presenter
         let dataSource = provideUserTableViewDataSource()
         viewController!.dataSource = dataSource
         //使导航生效： 点击事件
         viewController!.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
         //设置用户中心头部布局详情页点击事件
         viewController!.showDetailDelegate = presenter.self
         //        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
         }
         return viewController!
         */
 
    }

    
    //MARK: - WritingDetail
    func provideWritingDetailViewController(_ writingName: String) -> WritingDetailViewController {
        let viewController: WritingDetailViewController = provideMainStoryboard().instantiateViewController("WritingDetailViewController")
        let presenter = provideWritingDetailPresenter(viewController, writingName: writingName)
        //设置代理
        presenter.writingDetailPresenterDelegate = viewController.self
        viewController.presenter = presenter
        let dataSource = provideWritingDetailViewDataSource()
        viewController.dataSource = dataSource
        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
        //item点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideWritingDetailPresenter(_ ui: WritingDetailUI, writingName: String) -> WritingDetailPresenter {
        return WritingDetailPresenter(ui: ui, writingName: writingName)
    }
    
    //MARK: - WritingStart
    func provideWritingStartViewController(_ data: NSMutableDictionary) -> WritingStartViewController {
        let viewController: WritingStartViewController = WritingStartViewController(data: data)
        return viewController
    }
//    func provideWritingStartPresenter(_ ui: WritingDetailUI, writingName: String) -> WritingDetailPresenter {
//        return WritingDetailPresenter(ui: ui, writingName: writingName)
//    }
    
    //MARK: - DailyDetail
    func provideDailyDetailViewController(detailData: NSMutableDictionary) -> DailyDetailViewController {
        let viewController: DailyDetailViewController = provideMainStoryboard().instantiateViewController("DailyDetailViewController")
        let presenter = provideDailyDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideDailyDetailPresenter(_ ui: DailyDetailUI, detailData: NSMutableDictionary) -> DailyDetailPresenter {
        return DailyDetailPresenter(ui: ui, detailData: detailData)
    }
    //MARK: - SightDetail
    func provideSightDetailViewController(detailData: NSMutableDictionary) -> SightDetailViewController {
        let viewController: SightDetailViewController = provideMainStoryboard().instantiateViewController("SightDetailViewController")
        let presenter = provideSightDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideSightDetailPresenter(_ ui: SightDetailUI, detailData: NSMutableDictionary) -> SightDetailPresenter {
        return SightDetailPresenter(ui: ui, detailData: detailData)
    }
    
    //MARK: - FamousDetail
    func provideFamousDetailViewController(detailData: NSMutableDictionary) -> FamousDetailViewController {
        let viewController: FamousDetailViewController = provideMainStoryboard().instantiateViewController("FamousDetailViewController")
        let presenter = provideFamousDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideFamousDetailPresenter(_ ui: FamousDetailUI, detailData: NSMutableDictionary) -> FamousDetailPresenter {
        return FamousDetailPresenter(ui: ui, detailData: detailData)
    }
    
    //MARK: - StudyDetail
    func provideStudyDetailViewController(detailData: NSMutableDictionary) -> StudyDetailViewController {
        let viewController: StudyDetailViewController = provideMainStoryboard().instantiateViewController("StudyDetailViewController")
        let presenter = provideStudyDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideStudyDetailPresenter(_ ui: StudyDetailUI, detailData: NSMutableDictionary) -> StudyDetailPresenter {
        return StudyDetailPresenter(ui: ui, detailData: detailData)
    }
    
    //MARK: - CopyBookDetail
    func provideCopyBookDetailViewController(detailData: NSMutableDictionary) -> CopyBookDetailViewController {
        let viewController: CopyBookDetailViewController = provideMainStoryboard().instantiateViewController("CopyBookDetailViewController")
        let presenter = provideCopyBookDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideCopyBookDetailPresenter(_ ui: CopyBookDetailUI, detailData: NSMutableDictionary) -> CopyBookDetailPresenter {
        return CopyBookDetailPresenter(ui: ui, detailData: detailData)
    }
    
    //MARK: - LectureDetail
    func provideLectureDetailViewController(detailData: NSMutableDictionary) -> LectureDetailViewController {
        let viewController: LectureDetailViewController = provideMainStoryboard().instantiateViewController("LectureDetailViewController")
        let presenter = provideLectureDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideLectureDetailPresenter(_ ui: LectureDetailUI, detailData: NSMutableDictionary) -> LectureDetailPresenter {
        return LectureDetailPresenter(ui: ui, detailData: detailData)
    }
    
    //MARK: - VideoDetail 原生视频播放
    /*
    func provideVideoDetailViewController(item: Video) -> AVPlayerViewController {
        let player = AVPlayer()
        let videoUrl = BASEURL + item.video_url
        var playItem = AVPlayerItem(url: URL(string: videoUrl)!)
        playItem = AVPlayerItem(asset: AVAsset(url: URL(string: videoUrl)!))
        player.replaceCurrentItem(with: playItem)
        player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspect
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = true
        playerViewController.modalTransitionStyle = .flipHorizontal
        return playerViewController
    }
    */
    
    //MARK: - VideoDetail ZFPlayer框架库播放
    func provideVideoDetailViewController(item: Video) -> VideoDetailViewController {
        let viewController: VideoDetailViewController = VideoDetailViewController()
        let presenter = provideVideoDetailPresenter(viewController, item: item)
        viewController.presenter = presenter
        return viewController
    }
    func provideVideoDetailPresenter(_ ui: VideoDetailUI, item: Video) -> VideoDetailPresenter {
        return VideoDetailPresenter(ui: ui, item: item)
    }
    
    
    //MARK: - AccountView
    func provideAccountViewController(item: User) -> AccountViewController {
        let viewController: AccountViewController = provideMainStoryboard().instantiateViewController("AccountViewController")
        let presenter = provideAccountPresenter(viewController, item: item)
        viewController.presenter = presenter
        //设置刷新界面委托 
        viewController.refreshItemDelegate = presenter.self
        let dataSource = provideAccountTableViewDataSource()
//        dataSource.
        viewController.dataSource = dataSource
        //item点击事件
        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return viewController
    }
    func provideAccountPresenter(_ ui: AccountUI, item: User) -> AccountPresenter {
        return AccountPresenter(ui: ui, item: item)
    }
    
    //MARK: - RecordView
//    func provideRecordViewController(item: User) -> RecordViewController1 {
//        let viewController: RecordViewController1 = provideMainStoryboard().instantiateViewController("RecordViewController1")
////        let viewController = RecordViewController1()
//        let presenter = provideRecordPresenter(viewController, item: item)
//        viewController.presenter = presenter
//        let dataSource = provideRecordTableViewDataSource()
//        viewController.dataSource = dataSource
//        //item点击事件
//        viewController.delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
//        //下拉刷新
//        viewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)
//        return viewController
//    }
//    func provideRecordPresenter(_ ui: RecordUI, item: User) -> RecordPresenter {
//        return RecordPresenter(ui: ui, item: item)
//    }
    
    //MARK: - DownloadDetail
    /*
    func provideDownloadDetailViewController(detailData: NSMutableDictionary) -> DownloadDetailViewController {
        let viewController: LectureDetailViewController = provideMainStoryboard().instantiateViewController("LectureDetailViewController")
        let presenter = provideLectureDetailPresenter(viewController, detailData: detailData)
        viewController.presenter = presenter
        return viewController
    }
    func provideLectureDetailPresenter(_ ui: LectureDetailUI, detailData: NSMutableDictionary) -> LectureDetailPresenter {
        return LectureDetailPresenter(ui: ui, detailData: detailData)
    }
     */
}
