//
//  WritingBackCustomView.swift
//  HandWriting
//
//  Created by mac on 17/8/29.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol WritingBackCustomDelegate {
    func startDrawing(graphicsContext: CGContext, text: String)
}

class WritingBackCustomView: UIView {

//    weak var graphicsContext: CGContext?
    var text: String = "萌"
    var writingBackDelegate: WritingBackCustomDelegate?
    
    var fontFamily = "zhongqi-Hanmo"
    var fontSize: Float = 299
    var fontColor: UIColor = UIColor.red
    var fontFillColor: UIColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        graphicsContext = UIGraphicsGetCurrentContext()
        print("init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFontFamliy(fontFamily: String){
        self.fontFamily = fontFamily
        //重绘界面
        self.setNeedsDisplay()
    }
    
    func setFontSize(fontSize: Float){
        self.fontSize = fontSize
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        print("draw")
        
        self.backgroundColor = UIColor.white
        //获取画布上下文
        let graphicsContext = UIGraphicsGetCurrentContext()
//        UIGraphicsGetImageFromCurrentImageContext函数可从当前上下文中获取一个UIImage对象。记住在你所有的绘图操作后别忘了调用UIGraphicsEndImageContext函数关闭图形上下文
//        graphicsContext = UIGraphicsGetImageFromCurrentImageContext()
        //绘制外部虚线
        drawOutsideBorder(graphicsContext: graphicsContext!)
        //3.绘制内部虚线
        drawInnerLines(graphicsContext: graphicsContext!)
        //绘制文字
        drawText(graphicsContext: graphicsContext!, string: self.text)
//        writingBackDelegate?.startDrawing(graphicsContext: graphicsContext!, text: self.text)
    }

    func drawOutsideBorder(graphicsContext: CGContext){
        graphicsContext.setLineWidth(4)
        graphicsContext.setStrokeColor(UIColor.red.cgColor)
        graphicsContext.setFillColor(UIColor.white.cgColor)
        //1.获取四个点坐标
        let leftTop = CGPoint(x: 0, y: 0)
        let leftBottom = CGPoint(x: 0, y: self.bounds.height)
        let rightTop = CGPoint(x: self.bounds.width, y: 0)
        let rightBottom = CGPoint(x: self.bounds.width, y: self.bounds.height)
        let path = UIBezierPath()
        path.move(to: leftTop)
        path.addLine(to: leftBottom)
        path.addLine(to: rightBottom)
        path.addLine(to: rightTop)
        path.addLine(to: leftTop)

        graphicsContext.addPath(path.cgPath)
        //2.绘制外边框
        graphicsContext.drawPath(using: .fillStroke)

    }
    
    func drawInnerLines(graphicsContext: CGContext){
        graphicsContext.setLineWidth(0.5)
        graphicsContext.setStrokeColor(UIColor.red.cgColor)
        graphicsContext.setFillColor(UIColor.white.cgColor)
        //设置虚线:phase:距离开始位置间隔    lengthhs:间隔大小设置
        graphicsContext.setLineDash(phase: 5, lengths: [5])

        //1.获取四个点坐标
        let leftTop = CGPoint(x: 0, y: 0)
        let leftBottom = CGPoint(x: 0, y: self.bounds.height)
        let rightTop = CGPoint(x: self.bounds.width, y: 0)
        let rightBottom = CGPoint(x: self.bounds.width, y: self.bounds.height)
        let topCenter = CGPoint(x: self.bounds.width/2, y: 0)
        let bottomCenter = CGPoint(x: self.bounds.width/2, y: self.bounds.height)
        let leftCenter = CGPoint(x: 0, y: self.bounds.height/2)
        let rightCenter = CGPoint(x: self.bounds.width, y: self.bounds.height/2)
        
        let path = UIBezierPath()
        path.move(to: leftTop)
        path.addLine(to: rightBottom)
        //左上对角线
        graphicsContext.addPath(path.cgPath)
        //右上对角线
        path.move(to: rightTop)
        path.addLine(to: leftBottom)
        graphicsContext.addPath(path.cgPath)
        //水平虚线
        path.move(to: topCenter)
        path.addLine(to: bottomCenter)
        graphicsContext.addPath(path.cgPath)
        //竖直虚线
        path.move(to: leftCenter)
        path.addLine(to: rightCenter)
        graphicsContext.addPath(path.cgPath)
        
        //2.绘制外边框
        graphicsContext.drawPath(using: .fillStroke)

    }
    
    func drawText(graphicsContext: CGContext, string: String){
        let graphicsContext = graphicsContext
        graphicsContext.setLineWidth(1)
        graphicsContext.setStrokeColor(fontColor.cgColor)
        graphicsContext.setFillColor(fontFillColor.cgColor)
        graphicsContext.setTextDrawingMode(.fillStroke)
        graphicsContext.setAllowsFontSmoothing(true)
        graphicsContext.setShouldSmoothFonts(true)
        graphicsContext.textMatrix = .identity
        //该坐标系是笛卡尔坐标系需要翻转成UIView中的坐标系：原点在左上角
        graphicsContext.translateBy(x: 0, y: bounds.size.height)
        graphicsContext.scaleBy(x: 1.0, y: -1.0)
        let path = CGMutablePath()
        path.addRect(bounds)
        let attrString = NSAttributedString(string: string)
        let mutStr = NSMutableAttributedString(attributedString: attrString)
        let range = NSRange(location: 0, length: 1)
        // UIFont, default Helvetica(Neue) 12
        //设置字体样式及大小
        let font = UIFont(name: fontFamily, size: CGFloat(fontSize))
        mutStr.addAttribute(NSFontAttributeName, value: font, range: range)
        // 5
        let framesetter = CTFramesetterCreateWithAttributedString(mutStr as CFAttributedString)
        // 6
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)
        // 7
        CTFrameDraw(frame, graphicsContext)
        
    }
    
    func setDrawText(text: String){
        self.text = text
//        self.draw(self.frame)
        //刷新界面
        self.setNeedsDisplay()
    }
    
}
