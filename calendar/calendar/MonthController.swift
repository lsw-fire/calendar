//
//  MonthController.swift
//  calendar
//
//  Created by Li Shi Wei on 8/31/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import CoreGraphics

class MonthController: UIViewController , UIScrollViewDelegate{

    var _lView: UIView!
    var _mView: UIView!
    var _rView: UIView!
    
    @IBOutlet weak var btnTest: UIButton!
    @IBAction func btnTestClick(_ sender: AnyObject, forEvent event: UIEvent) {
        
        //let btn = sender as! UIView
        let touch = event.touches(for: btnTest)?.first
        let point = touch?.location(in: btnTest)
        
        if (slLeft.path?.contains(point!))!{
            
           
            slLeft.fillColor = UIColor.gray.cgColor
            slLeft.strokeColor = UIColor.white.cgColor
            
            slRight.fillColor = UIColor.white.cgColor
            slRight.strokeColor = UIColor.gray.cgColor
            
            //print("left-lsw"+(point?.x.description)!)
            
            
            
            let urlStr = "OpenMemberMaintain://param?date=" + Date().toFormatString("yyyy-MM-dd-HH:mm")
            
            let customUrl = URL(string: urlStr)
            
            if UIApplication.shared.canOpenURL(customUrl!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(customUrl!, options: [:], completionHandler: {
                        (success) in
                        print("open url")
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
            
        }else if (slRight.path?.contains(point!))!{
            
            slRight.fillColor = UIColor.gray.cgColor
            slRight.strokeColor = UIColor.white.cgColor
            
            slLeft.fillColor = UIColor.white.cgColor
            slLeft.strokeColor = UIColor.gray.cgColor
            
            //print("right-lsw"+(point?.x.description)!)
        }
        else
        {
            //print(point?.x)
        }
    }
    enum ScrollState : Int{
        case current = 0
        case toLeft = 1
        case toRight = 2
    }

    let VELOCITY_STANDAD : CGFloat = 0.6
    var scrollState = ScrollState.current
    var scrollBeginOffset : CGFloat = 0
  
    
    @IBOutlet var _scrollView: UIScrollView!
    
    let slLeft = CAShapeLayer()
    let slRight = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      
      reloadView()
        
        _scrollView.delegate = self
        
        DispatchQueue.main.async {
            let xHalf = self.btnTest.frame.width/2
            let xFull = self.btnTest.frame.width
            
            let yHalf = self.btnTest.frame.height/2
            let yFull = self.btnTest.frame.height
            
            let bezierPath = UIBezierPath()
            
            bezierPath.move(to: CGPoint(x: 0, y: 0))
            bezierPath.addLine(to: CGPoint(x: xHalf, y: 0))
            bezierPath.addLine(to: CGPoint(x: xHalf + 10, y: yHalf))
            bezierPath.addLine(to: CGPoint(x: xHalf, y: yFull))
            bezierPath.addLine(to: CGPoint(x: 0, y: yFull))
            bezierPath.close()
            bezierPath.stroke()
            
            let bezierPathRight = UIBezierPath()
            bezierPathRight.move(to: CGPoint(x: xHalf+1, y: 0))
            bezierPathRight.addLine(to: CGPoint(x: xFull-1, y: 0))
            bezierPathRight.addLine(to: CGPoint(x: xFull-1, y: yFull))
            bezierPathRight.addLine(to: CGPoint(x: xHalf+1, y: yFull))
            bezierPathRight.addLine(to: CGPoint(x: xHalf+11, y:yHalf))
            bezierPathRight.close()
            bezierPathRight.stroke()
            
            self.slLeft.frame = self.btnTest.bounds
            self.slLeft.path = bezierPath.cgPath
            self.slLeft.fillColor = UIColor.white.cgColor
            self.slLeft.strokeColor = UIColor.gray.cgColor
            self.slLeft.lineWidth = 1
            //        btnTest.layer.masksToBounds = true
            //        btnTest.layer.mask = sl
            
            self.btnTest.layer.addSublayer(self.slLeft)
            
            self.slRight.frame = self.btnTest.bounds
            self.slRight.path = bezierPathRight.cgPath
            self.slRight.fillColor = UIColor.gray.cgColor
            self.slRight.strokeColor = UIColor.white.cgColor
            self.slRight.lineWidth = 1
            //        btnTest.layer.masksToBounds = true
            //        btnTest.layer.mask = sl
            
            self.btnTest.layer.addSublayer(self.slRight)
        }

        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollBeginOffset = scrollView.contentOffset.x
        self.scrollState = .current
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var point = targetContentOffset.pointee
        
        if(velocity.x > VELOCITY_STANDAD)
        {
            self.scrollState = .toRight
        }
        
        if(velocity.x < -VELOCITY_STANDAD){
            self.scrollState = .toLeft
        }
        
        let scrollDistance = self.scrollBeginOffset - scrollView.contentOffset.x
        let standardDistance = _scrollView.frame.size.width/3
        
        if scrollDistance < -standardDistance {
            self.scrollState = .toRight
        }
        
        if scrollDistance > standardDistance
        {
            self.scrollState = .toLeft
        }
        
        if(self.scrollState == .toLeft)
        {
            _scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
            point.x = 0
        }
        
        if(self.scrollState == .toRight)
        {
            _scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width * 2, y: 0), animated: true)
            
            point.x = scrollView.frame.size.width * 2
        }
        
        targetContentOffset.pointee = point
    }
    
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        _scrollView.userInteractionEnabled = false
//    }
//    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.x == 0)
        {
            _scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        }
        else if(scrollView.contentOffset.x == scrollView.frame.size.width)
        {
        
        }
        else if(scrollView.contentOffset.x == scrollView.frame.size.width * 2)
        {
            _scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        }
        
        //scrollView.userInteractionEnabled = true;
    }
//
    func reloadView() {
        
        let width = _scrollView.frame.size.width
        let height = _scrollView.frame.size.height

        
        _scrollView.contentSize = CGSize(width: 3 * width, height: 0)
        _scrollView.contentOffset = CGPoint(x: width, y: 0)
        
        
        _lView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        _lView.backgroundColor = UIColor.red
        _scrollView.addSubview(_lView)
        
        _mView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
        _mView.backgroundColor = UIColor.yellow
        _scrollView.addSubview(_mView)
        
        _rView = UIView(frame: CGRect(x: width*2, y: 0, width: width, height: height))
        _rView.backgroundColor = UIColor.blue
        _scrollView.addSubview(_rView)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
