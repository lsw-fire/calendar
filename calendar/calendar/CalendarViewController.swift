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
    @IBOutlet weak var lbLunarDate: UILabel!
    @IBOutlet weak var lbSolarTermDate: UILabel!
    
    @IBAction func btnToday(_ sender: AnyObject) {
        currentMonthDate = Date()
        source = getSource(currentMonthDate)
        cv.reloadData()
        loadTitle()
    }
    
    
    func goToDateSelectController()
    {
        let strDate = lbSelectedDateTime.text
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: strDate!)
        
        //        self.performSegueWithIdentifier("toDateSelectController", sender: self)
        let dateSelectController = self.storyboard!.instantiateViewController(withIdentifier: "DateSelectController") as! DateSelectController
        
        dateSelectController.selectedDate = date
        dateSelectController.dateSelectedAction = { date in
            self.currentMonthDate = date as Date
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
        
        //self.navigationController?.navigationBar.backItem?.title = " "
        
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = UIColor.white
        
        //给控件增加手势要打开这一项
        lbSelectedDateTime.isUserInteractionEnabled = true
        
        let gesture = LabelTapGestureRecognizer(target: self)
        
        gesture.onTouch = { touch in
            self.outOfLabel = false
            self.lbSelectedDateTime.backgroundColor = UIColor.lightGray
            self.lbSelectedDateTime.textColor = UIColor.white
        }
        gesture.onEnded = { touch in
            self.lbSelectedDateTime.backgroundColor = UIColor.white
            self.lbSelectedDateTime.textColor = UIColor.darkGray
            if !self.outOfLabel {
                self.goToDateSelectController()
            }
        }
        gesture.onMoved = { touch in
            let _transX =  touch.location(in: self.lbSelectedDateTime).x
            let _transY =  touch.location(in: self.lbSelectedDateTime).y
            
            let rect = self.lbSelectedDateTime.bounds
            
            if _transX < 0 || _transX > rect.width {
                self.lbSelectedDateTime.backgroundColor = UIColor.white
                self.lbSelectedDateTime.textColor = UIColor.darkGray
                self.outOfLabel = true
            }
            
            if _transY < 0 || _transY > rect.height {
                self.lbSelectedDateTime.backgroundColor = UIColor.white
                self.lbSelectedDateTime.textColor = UIColor.darkGray
                self.outOfLabel = true
            }
            
        }
        lbSelectedDateTime.addGestureRecognizer(gesture)
        
        loadTitle()
        //        lbSelectedDateTime.layer.borderColor = UIColor.lightGrayColor().CGColor
        //        lbSelectedDateTime.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        print(fromInterfaceOrientation.isLandscape)
        if fromInterfaceOrientation.isPortrait {
            
            //selectDateTopConstraint.constant = 10
        }
        else
        {
            //selectDateTopConstraint.constant = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
      

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
//        let backBarButtonItem = UIBarButtonItem()
//        backBarButtonItem.title = ""
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    func loadTitle()  {
        lbSelectedDateTime.text = currentMonthDate.toFormatString(dateFormat)
        let lunarST = LunarSolarTerm(paramDate: currentMonthDate)
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
        
        let lunarText = lunarST.lunarYearText+"年\n"+lunarST.lunarMonthText+"月"+lunarST.lunarDayText
        lbLunarDate.text = lunarText
        
        let solarTerm = lunarST.getSolarTerm(currentMonthDate.year, month: currentMonthDate.month)
        lbSolarTermDate.text = solarTerm.solarTerm1.name+" : "+solarTerm.solarTerm1.solarTermDate.toFormatString("d日-HH:mm")+"\n"+solarTerm.solarTerm2.name+" : "+solarTerm.solarTerm2.solarTermDate.toFormatString("d日-HH:mm")
    }
    
    var currentMonthDate : Date = Date()
    
    func reloadView() {
        
        let size = UIScreen.main.bounds
        
        var isPortrait = true
        if size.height < size.width {
            isPortrait = false
        }
        
        if isPortrait {
            //selectDateTopConstraint.constant = 30
        }
        else {
            //selectDateTopConstraint.constant = 10
        }
        
        source = getSource(currentMonthDate)
        
        let layout = MonthViewLayout()
        
        let rotateDirection = ApplicationResource.sharedInstance.getMonthViewRotateDirection()
        
        layout.scrollDirection = rotateDirection
        //layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        //在这给每一个item cell设置大小，因为在viewDidLoad方法时还得不到整体viewcollection的size，得到的是默认在stoarybord里的那个尺寸
        
        let itemWidth = cv.frame.size.width / CGFloat(7)
        layout.itemSize = CGSize(width: itemWidth, height: cv.frame.size.height / CGFloat(6))
        //layout.itemSize = CGSizeMake(itemWidth, itemWidth * CGFloat(6))
        
        cv.collectionViewLayout = layout
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        
        //初始化第几页
        if rotateDirection == .horizontal {
            cv.contentOffset.x = cv.frame.size.width
        }
        else
        {
            cv.contentOffset.y = cv.frame.size.height
        }
        
        //
        
        //        NSLog("height=%f", cv.frame.size.height)
        cvHeader.layer.sublayers = nil
        //cvHeader.subviews.map{ $0.removeFromSuperview()}
        let cvHeaderTitle :[String] = ["日","一","二","三","四","五","六"]
        var x = CGFloat(0);
        for i in 1...7 {
            let label = UILabel(frame: CGRect(x: x,y: 0,width: itemWidth,height: cvHeader.frame.size.height))
            
            label.text = cvHeaderTitle[i-1]
            label.textColor = UIColor.white
            //label.backgroundColor = UIColor.redColor()
            
            label.textAlignment = NSTextAlignment.center
            cvHeader.addSubview(label)
            
            cvHeader.backgroundColor = UIColor.orange
            x = itemWidth * CGFloat(i)
        }
        
        let layer = CALayer()
        let height = cv.frame.size.height + cvHeader.frame.size.height+0.5
        let width = cv.frame.size.width + 0.5
        layer.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: width, height: height)
        layer.borderColor = UIColor.orange.cgColor
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
    
    var source = Array<DayModel?>()
    
    func getSource(_ date: Date) -> Array<DayModel?>
    {
        let month = MonthSource(date:Date())
        var s = Array<DayModel?>()
        let pre = month.buildOneMonthSource(date.plusMonths(-1))
        let current = month.buildOneMonthSource(date)
        let next = month.buildOneMonthSource(date.plusMonths(1))
        
        s.append(contentsOf: pre)
        s.append(contentsOf: current)
        s.append(contentsOf: next)
        
        return s
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //定义展示的UICollectionViewCell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //NSLog("section=%d", section)
        return 42
    }
 
    //不知道为什么选中一天后会从新刷新一部分cell，用这个标识出是不是选中了某一天，如果选中了就不再去更新上一个选中的日子
    var onSelectOneDay = false
    //选中某一天
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        onSelectOneDay = true
        
        let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
        
        if let selected = source[indexPath.row + beginIndex]
        {
            
            let cell = collectionView.cellForItem(at: indexPath) as! DayColletionViewCell
            
            if cell != currentSelectedDayCell {
                
                if let beforeSelectedCell = currentSelectedDayCell {
                    beforeSelectedCell.lbDay.backgroundColor = UIColor.white
                    beforeSelectedCell.lbDay.textColor = dayTextColorNormal
                }
                
                if cell != currentTodayCell {
                    
                    //当前月的日期选中
                    cell.lbDay.textColor = UIColor.white
                    cell.lbDay.backgroundColor = UIColor.lightGray
                    //cell.lbDay.layer.cornerRadius = 5
                    
                    currentSelectedDayCell = cell
                }
                else
                {
                    currentSelectedDayCell = nil
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = dateFormatFromCell
                let currentTime = currentMonthDate.toFormatString(" HH:mm")
                
                let date = formatter.date(from: selected.formatDate + " " + currentTime)
                
                currentMonthDate = date!
                
                loadTitle()
            }
        }
    }
    
    @IBOutlet weak var selectDateTopConstraint: NSLayoutConstraint!
    
    let dayTextColorNormal = UIColor.black
    var currentSelectedDayCell: DayColletionViewCell! = nil
    var currentTodayCell: DayColletionViewCell! = nil
    //每个UICollectionView展示的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DayColletionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! DayColletionViewCell
        
        //print(cell.lbDay.text)
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.orange.cgColor
        
        let beginIndex = (indexPath as NSIndexPath).section == 0 ? 0 : (42 * indexPath.section)
        
        cell.lbDay.backgroundColor = UIColor.white
        let selectedDay = currentMonthDate.day
        
        if let model = source[indexPath.row + beginIndex] {
            cell.lbDay.text = String(model.day)
            
            
            cell.lbSixtyDay.attributedText = ColorText.getColorEraText(model.eraDay.c, terrestial: model.eraDay.t);        if model.isSolarTerm
            {
                cell.lbLunaryDay.text = model.solarTermText
                //cell.lbLunaryDay.backgroundColor = UIColor.orangeColor()
                cell.lbLunaryDay.textColor = UIColor.orange
            }
            else
            {
                cell.lbLunaryDay.text = model.lunarDay
                cell.lbLunaryDay.textColor = UIColor.gray
            }
            
            if(model.isToday)
            {
                //因为我一次绑定三页，如果section等于第1页的时候有currentToday就把第二页的格给设定值了
                //所以先要判断只有第二页的时候才能够出现today
                if indexPath.section == 1 {
                    currentTodayCell = cell
                }
                
                cell.lbDay.textColor = UIColor.white
                cell.lbDay.backgroundColor = UIColor.orange
                print(cell.lbDay.text)
            }
            else if(model.isSelected && !model.isToday && selectedDay == model.day)
            {
                if !onSelectOneDay {
                    currentSelectedDayCell = cell
                }
                
                cell.lbDay.textColor = UIColor.white
                cell.lbDay.backgroundColor = UIColor.lightGray
                //print(cell.lbDay.text)
            }
            else
            {
                cell.lbDay.backgroundColor = UIColor.white
                cell.lbDay.textColor = dayTextColorNormal
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    
    func calculateDateBasedOnScrollViewPosition(_ scrollView: UIScrollView) {
        
        let cvbounds = self.cv.bounds
        
        let rotateDirection = ApplicationResource.sharedInstance.getMonthViewRotateDirection()
        
        var page = Int(floor(self.cv.contentOffset.x / cvbounds.size.width))
        if rotateDirection != .horizontal
        {
            page = Int(floor(self.cv.contentOffset.y / cvbounds.size.height))
        }
        
        page = page > 0 ? page : 0
        
        if page == 2 {
            currentMonthDate = currentMonthDate.plusMonths(1)
            loadTitle()
            source = getSource(currentMonthDate)
            cv.reloadData()
            onSelectOneDay = false
        }
        if page == 0 {
            currentMonthDate = currentMonthDate.plusMonths(-1)
            loadTitle()
            source = getSource(currentMonthDate)
            cv.reloadData()
            onSelectOneDay = false
        }
        if rotateDirection == .horizontal {
            cv.contentOffset.x = cv.frame.size.width
        }
        else
        {
            cv.contentOffset.y = cv.frame.size.height
        }
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

