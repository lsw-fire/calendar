//
//  CalendarViewController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/3/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dateFormat = "yyyy年 M月 d日 HH:mm"
    let dateFormatFromCell = "yyyy-M-d HH:mm"
    
    @IBOutlet var cv: UICollectionView!
    @IBOutlet var cvHeader: UIView!
    @IBOutlet var lbSelectedDateTime: UILabel!
    
    func goToDateSelectController()
    {
        let strDate = lbSelectedDateTime.text
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.dateFromString(strDate!)
        
        //        self.performSegueWithIdentifier("toDateSelectController", sender: self)
        let dateSelectController = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectController") as! DateSelectController
        
        dateSelectController.selectedDate = date
        dateSelectController.dateSelectedAction = { date in
            self.currentMonthDate = date
            self.source = self.getSource(self.currentMonthDate)
            self.cv.reloadData()
            self.loadTitle()
        }
        self.navigationController?.pushViewController(dateSelectController, animated: true)
    }
    
    //var dayModel = DayModel(day: "2")
    
    var outOfLabel = false
    
    @IBOutlet weak var lbCYear: UILabel!
    @IBOutlet weak var lbCMonth: UILabel!
    @IBOutlet weak var lbCDay: UILabel!
    @IBOutlet weak var lbCTime: UILabel!
    
    @IBOutlet weak var lbTYear: UILabel!
    @IBOutlet weak var lbTMonth: UILabel!
    @IBOutlet weak var lbTDay: UILabel!
    @IBOutlet weak var lbTTime: UILabel!
    
    @IBOutlet weak var svTitle: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = UIColor.whiteColor()
        
        //给控件增加手势要打开这一项
        lbSelectedDateTime.userInteractionEnabled = true
        
        let gesture = LabelTapGestureRecognizer(target: self)
        
        gesture.onTouch = { touch in
            self.outOfLabel = false
            self.lbSelectedDateTime.backgroundColor = UIColor.lightGrayColor()
            self.lbSelectedDateTime.textColor = UIColor.whiteColor()
        }
        gesture.onEnded = { touch in
            self.lbSelectedDateTime.backgroundColor = UIColor.whiteColor()
            self.lbSelectedDateTime.textColor = UIColor.blackColor()
            if !self.outOfLabel {
                self.goToDateSelectController()
            }
        }
        gesture.onMoved = { touch in
            let _transX =  touch.locationInView(self.lbSelectedDateTime).x
            let _transY =  touch.locationInView(self.lbSelectedDateTime).y
            
            let rect = self.lbSelectedDateTime.bounds
            
            if _transX < 0 || _transX > rect.width {
                self.lbSelectedDateTime.backgroundColor = UIColor.whiteColor()
                self.lbSelectedDateTime.textColor = UIColor.blackColor()
                self.outOfLabel = true
            }
            
            if _transY < 0 || _transY > rect.height {
                self.lbSelectedDateTime.backgroundColor = UIColor.whiteColor()
                self.lbSelectedDateTime.textColor = UIColor.blackColor()
                self.outOfLabel = true
            }

        }
        lbSelectedDateTime.addGestureRecognizer(gesture)
        
        loadTitle()
        lbSelectedDateTime.layer.borderColor = UIColor.lightGrayColor().CGColor
        lbSelectedDateTime.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        print(fromInterfaceOrientation.isLandscape)
        if fromInterfaceOrientation.isPortrait {
            
            //selectDateTopConstraint.constant = 10
        }
        else
        {
            //selectDateTopConstraint.constant = 30
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func loadTitle()  {
        lbSelectedDateTime.text = currentMonthDate.toFormatString(dateFormat)
        let lunarST = LunarSolarTerm(date: currentMonthDate)
        let eraY = lunarST.getEraYearText()
        let eraM = lunarST.getEraMonthText()
        let eraD = lunarST.getEraDayText()
        let eraT = lunarST.getEraHourText()
        
        lbCYear.attributedText = ColorText.getColorEraText(eraY.c, terrestial: "")
        lbTYear.attributedText = ColorText.getColorEraText("", terrestial: eraY.t)
        
        lbCMonth.attributedText = ColorText.getColorEraText(eraM.c, terrestial: "")
        lbTMonth.attributedText = ColorText.getColorEraText("", terrestial: eraM.t)
        
        lbCDay.attributedText = ColorText.getColorEraText(eraD.c, terrestial: "")
        lbTDay.attributedText = ColorText.getColorEraText("", terrestial: eraD.t)
        
        lbCTime.attributedText = ColorText.getColorEraText(eraT.c, terrestial: "")
        lbTTime.attributedText = ColorText.getColorEraText("", terrestial: eraT.t)
        
    }
    
    var currentMonthDate : NSDate = NSDate()
    
    func reloadView() {
        
        let size = UIScreen.mainScreen().bounds
        
        var isPortrait = true
        if size.height < size.width {
            isPortrait = false
        }
        
        if isPortrait {
            selectDateTopConstraint.constant = 30
        }
        else {
            selectDateTopConstraint.constant = 10
        }
        
        source = getSource(currentMonthDate)
        
        let layout = MonthViewLayout()
        layout.scrollDirection = .Vertical
        //layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        //在这给每一个item cell设置大小，因为在viewDidLoad方法时还得不到整体viewcollection的size，得到的是默认在stoarybord里的那个尺寸
        
        let itemWidth = cv.frame.size.width / CGFloat(7)
        layout.itemSize = CGSizeMake(itemWidth, cv.frame.size.height / CGFloat(6))
        //layout.itemSize = CGSizeMake(itemWidth, itemWidth * CGFloat(6))
        
        cv.collectionViewLayout = layout
        cv.pagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        
        //初始化第几页
        cv.contentOffset.y = cv.frame.size.height
        // cv.contentOffset.x = cv.frame.size.width
        
        //        NSLog("height=%f", cv.frame.size.height)
        cvHeader.layer.sublayers = nil
        //cvHeader.subviews.map{ $0.removeFromSuperview()}
        let cvHeaderTitle :[String] = ["日","一","二","三","四","五","六"]
        var x = CGFloat(0);
        for i in 1...7 {
            let label = UILabel(frame: CGRectMake(x,0,itemWidth,cvHeader.frame.size.height))
            
            label.text = cvHeaderTitle[i-1]
            label.textColor = UIColor.whiteColor()
            //label.backgroundColor = UIColor.redColor()
            
            label.textAlignment = NSTextAlignment.Center
            cvHeader.addSubview(label)
            
            cvHeader.backgroundColor = UIColor.redColor()
            x = itemWidth * CGFloat(i)
        }
        
        let layer = CALayer()
        let height = cv.frame.size.height + cvHeader.frame.size.height + 8
        let width = cv.frame.size.width+10
        layer.frame = CGRectMake(CGFloat(0), CGFloat(0), width, height)
        layer.borderColor = UIColor.redColor().CGColor
        layer.borderWidth = 1
        
        cvHeader.layer.addSublayer(layer)

        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        
        reloadView()
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var source = Array<DayModel!>()
    
    func getSource(date: NSDate) -> Array<DayModel!>
    {
        let month = MonthSource()
        var s = Array<DayModel!>()
        let pre = month.buildOneMonthSource(date.plusMonths(-1))
        let current = month.buildOneMonthSource(date)
        let next = month.buildOneMonthSource(date.plusMonths(1))
        
        s.appendContentsOf(pre)
        s.appendContentsOf(current)
        s.appendContentsOf(next)
        
        return s
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //定义展示的UICollectionViewCell的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //NSLog("section=%d", section)
        return 42
    }
    
    //选中某一天
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell: DayColletionViewCell  = collectionView.cellForItemAtIndexPath(indexPath) as! DayColletionViewCell
       
        if cell != currentSelectedDayCell {
            
            if let beforeSelectedCell = currentSelectedDayCell {
                beforeSelectedCell.lbDay.backgroundColor = UIColor.whiteColor()
                beforeSelectedCell.lbDay.textColor = UIColor.blackColor()
            }
            
            let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
            
            let selected = source[indexPath.row + beginIndex]
            
            if cell != currentTodayCell {
                
                //当前月的日期选中
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.lightGrayColor()
                //cell.lbDay.layer.cornerRadius = 5
                
                currentSelectedDayCell = cell
            }
            else
            {
                currentSelectedDayCell = nil
            }
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = dateFormatFromCell
            let currentTime = currentMonthDate.toFormatString(" HH:mm")
            
            let date = formatter.dateFromString(selected.formatDate + " " + currentTime)
            
            currentMonthDate = date!
            
            loadTitle()
        }
    }
    
    @IBOutlet weak var selectDateTopConstraint: NSLayoutConstraint!
   
    
    var currentSelectedDayCell: DayColletionViewCell! = nil
    var currentTodayCell: DayColletionViewCell! = nil
    //每个UICollectionView展示的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: DayColletionViewCell  = collectionView.dequeueReusableCellWithReuseIdentifier("defaultCell", forIndexPath: indexPath) as! DayColletionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        
        let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
//        
//        let currentRow = indexPath.item/7
//        if currentRow < 5 {
//            cell.layer.addSublayer(createLayerBottomBorder(cell.frame.size.height-1))
//
        
        cell.lbDay.backgroundColor = UIColor.whiteColor()
        let selectedDay = currentMonthDate.day
        
        if let model = source[indexPath.row  + beginIndex] {
            cell.lbDay.text = String(model.day)
          
            
            cell.lbSixtyDay.attributedText = ColorText.getColorEraText(model.eraDay.c, terrestial: model.eraDay.t);        if model.isSolarTerm
            {
                cell.lbLunaryDay.text = model.solarTermText
                //cell.lbLunaryDay.backgroundColor = UIColor.orangeColor()
                cell.lbLunaryDay.textColor = UIColor.orangeColor()
            }
            else
            {
                cell.lbLunaryDay.text = model.lunarDay
                cell.lbLunaryDay.textColor = UIColor.grayColor()
            }
            
            if(model.isToday)
            {
                //因为我一次绑定三页，如果section等于第1页的时候有currentToday就把第二页的格给设定值了
                //所以先要判断只有第二页的时候才能够出现today
                if indexPath.section == 1 {
                    currentTodayCell = cell
                }
                
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.orangeColor()
                 print(cell.lbDay.text)
            }
            else if(model.isSelected && !model.isToday && selectedDay == model.day)
            {
                currentSelectedDayCell = cell
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.lightGrayColor()
                //print(cell.lbDay.text)
            }
            else
            {
                cell.lbDay.backgroundColor = UIColor.whiteColor()
                cell.lbDay.textColor = UIColor.darkGrayColor()
            }
            
        }
        else
        {
            cell.lbDay.text = ""
            cell.lbSixtyDay.text = ""
            cell.lbLunaryDay.text = ""
        }
        //NSLog("section index path=%d", indexPath.section)
        
        return cell;
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    
    func calculateDateBasedOnScrollViewPosition(scrollView: UIScrollView) {
        
        let cvbounds = self.cv.bounds
        
        //var page : Int = Int(floor(self.cv.contentOffset.x / cvbounds.size.width))
        var page : Int = Int(floor(self.cv.contentOffset.y / cvbounds.size.height))
        
        page = page > 0 ? page : 0
        
        if page == 2 {
            currentMonthDate = currentMonthDate.plusMonths(1)
            source = getSource(currentMonthDate)
            cv.reloadData()
            loadTitle()
        }
        if page == 0 {
            currentMonthDate = currentMonthDate.plusMonths(-1)
            source = getSource(currentMonthDate)
            cv.reloadData()
            loadTitle()
        }
        cv.contentOffset.y = cv.frame.size.height
        //cv.contentOffset.x = cv.frame.size.width
        
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

