//
//  ImageViewController.swift
//  HandWriting
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol ImageViewControllerDelegate {
    func tapImageView()
}

class ImageViewController: UIViewController {
    
    var delegate: ImageViewControllerDelegate?
    
    var imageURL: URL? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        self.imageViewContainer = UIView()
        self.imageViewContainer?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        //添加ScrollView
        scrollView = UIScrollView(frame: (imageViewContainer?.frame)!)
        scrollView?.addSubview(imageView)
        imageViewContainer?.addSubview(scrollView!)
        self.view.addSubview(imageViewContainer!)
        
//        imageViewContainer?.backgroundColor = UIColor.red
        updateImage()
    }
    func updateImage(){
        if let url = self.imageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in //防止指针自身引用
                if let imageData = NSData(contentsOf: url as URL) {
                    if let image = UIImage(data: imageData as Data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                            //调整image大小
                            self?.makeRoomForImage()
                        }
                    }
                }
            }
        }
    }
    var imageView = UIImageView()
    var imageViewContainer: UIView? {
        didSet {
//            imageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3)
            imageView.backgroundColor = UIColor.orange
            //添加点击手势
            addGesture()
        }
    }
    
    var scrollView: UIScrollView? {
        didSet {
            //设置ScrollView的contentSize：否则无效
            scrollView?.contentSize = imageView.frame.size
            //支持缩放
            scrollView?.delegate = self
            scrollView?.minimumZoomScale = 0.5
            scrollView?.maximumZoomScale = 1.0
        }
    }
    
    func addGesture() {
        //单击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewController.tapImageView))
        //图片默认不允许跟用户交互
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        //缩放手势
        let spanGesture = UIPinchGestureRecognizer(target: self, action: #selector(ImageViewController.pinchImageView(gesture:)))
//        imageView.addGestureRecognizer(spanGesture)
        //拖拽手势
        
        //旋转手势
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(ImageViewController.rotationImageView(gesture:)))
    }
    
    func tapImageView() {
        //发送消息
        self.delegate?.tapImageView()
    }
    
    var scale: CGFloat = 0.90 {
        didSet {
            //改变时需要重新绘制
            updateImageSize()
        }
    }
    
    func updateImageSize() {
        imageView.size = CGSize(width: imageView.size.width * scale, height: imageView.size.height * scale)
    }
    
    func pinchImageView(gesture: UIPinchGestureRecognizer) {
//        let state = gesture.state
        //判断手势是否处于改变状态
        if gesture.state == .changed {
            scale *= gesture.scale
            //重置scale保留当前缩放比率
            if scale < 0.2 {
                scale = 0.2
            }else if scale > 2.5 {
                scale = 2.5
            }
            gesture.scale = 1
        }
        //缩放完成居中显示图片
        showImageViewToCenter()
    }
    
    /**
     *  Desc: 以动画方式将图片居中
     *  Param:
     */
    func showImageViewToCenter() {
        let x = (SCREEN_WIDTH-imageView.size.width)/2
        let y = (SCREEN_HEIGHT-imageView.size.height)/2
        let w = imageView.size.width
        let h = imageView.size.height
        
        UIView.animate(withDuration: 0.6) {
            self.imageView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
    }
    
    func rotationImageView(gesture: UIRotationGestureRecognizer) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景为黑色
        self.view.backgroundColor = UIColor.black
        updateUI()
    }
    //调整图片大小
    func makeRoomForImage(){
        var extraHeight: CGFloat = 0
        if (imageView.image?.aspectRatio)! > CGFloat(0) {
            if let width = imageView.superview?.frame.size.width {
                let height = width / (imageView.image?.aspectRatio)!
                extraHeight = height - imageView.frame.height
                //居中
                imageView.frame = CGRect(x: 0, y: (SCREEN_HEIGHT - height-NavigationBarHeight-StatusBarHeight)/2, width: width, height: height)
            }
        }else{
            extraHeight = -imageView.frame.height
            imageView.frame = CGRect.zero
        }
        preferredContentSize = CGSize(width: preferredContentSize.width, height: preferredContentSize.height + extraHeight)
    }
}
//扩展实现UIScrollView的缩放方法
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        self.showImageViewToCenter()
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        debugPrint("func --> \(#function) : line --> \(#line)")
    }
}

extension UIImage {
    //获取宽高比
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
