//
//  MonthController.swift
//  calendar
//
//  Created by Li Shi Wei on 8/31/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class MonthController: UIViewController , UIScrollViewDelegate{

    var _lView: UIView!
    var _mView: UIView!
    var _rView: UIView!
    
    enum ScrollState : Int{
        case current = 0
        case toLeft = 1
        case toRight = 2
    }

    let VELOCITY_STANDAD : CGFloat = 0.6
    var scrollState = ScrollState.current
    var scrollBeginOffset : CGFloat = 0
  
    
    @IBOutlet var _scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
      reloadView()
        
        _scrollView.delegate = self
        
        
        
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
        
        
        _lView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        _lView.backgroundColor = UIColor.red
        _scrollView.addSubview(_lView)
        
        _mView = UIView.init(frame: CGRect(x: width, y: 0, width: width, height: height))
        _mView.backgroundColor = UIColor.yellow
        _scrollView.addSubview(_mView)
        
        _rView = UIView.init(frame: CGRect(x: width*2, y: 0, width: width, height: height))
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
