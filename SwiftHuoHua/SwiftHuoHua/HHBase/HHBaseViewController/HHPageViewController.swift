//
//  HHPageViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/22.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
//第三方分段控制器库
import HMSegmentedControl

//页面风格
enum HHPageStyle {
    case none
    case navigationBarSegment
    case topTabBar
}
class HHPageViewController: HHBaseViewController {

    var pageStyle: HHPageStyle!
    lazy var segment: HMSegmentedControl = {
        return HMSegmentedControl().then{
            $0.addTarget(self, action:#selector(changeIndex(segment:)),for:.valueChanged)
        }
    }()
    //transitionStyle 滚动样式，翻页样式两种
    //navigationOrientation 滑动方向
    lazy var pageVC: UIPageViewController = {
       return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }()
    //私有的只能写入数据的属性
    private(set) var vcs: [UIViewController]! //控制器数组
    private(set) var titles:[String]! //标题数组
    private var currentSelectIndex: Int = 0 //当前选中的位置，默认从0开始
    //便利构造函数
    
    convenience init(titles:[String] = [], vcs: [UIViewController] = [], pageStyle: HHPageStyle = .none) {
        self.init()
        self.titles=titles
        self.vcs=vcs
        self.pageStyle = pageStyle
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func changeIndex(segment: UISegmentedControl) {
        let index = segment.selectedSegmentIndex
        if currentSelectIndex != index {
            let target:[UIViewController] = [vcs[index]]
            //direction: 切换方向 forward:正向切换  reverse:反向切换
            let direction: UIPageViewController.NavigationDirection =
            currentSelectIndex > index ? .reverse : .forward
            pageVC.setViewControllers(target, direction: direction, animated: false) { [weak self] (finish) in
                self?.currentSelectIndex = index
            }
            
        }
        
    }

    override func configUI() {
        guard let vcs = vcs else {
            return
        }
        
        addChild(pageVC)
        view.addSubview(pageVC.view)
        
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.setViewControllers([vcs[currentSelectIndex]], direction: .forward, animated: false, completion: nil)
        
        switch pageStyle {
        case .none:
            pageVC.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .navigationBarSegment?:
            segment.backgroundColor = UIColor.clear
            //默认的字体颜色和大小
            segment.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.5),
                                           NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]
            segment.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black,
                                                   NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)]
            segment.selectionIndicatorLocation = .none
            
            navigationItem.titleView = segment
            segment.frame = CGRect(x: 0, y: 0, width: HHScreenWidth - 120, height: 40)
            
            pageVC.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .some(.topTabBar):
            segment.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexadecimalColor(hexadecimal: "0x262626"),
                                           NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)]
            segment.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: "0x262626"),
                                                   NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)]
            segment.selectionIndicatorLocation = .down
            segment.selectionIndicatorColor = UIColor.hexadecimalColor(hexadecimal: "0xFFD000")
            segment.selectionIndicatorHeight = 2
            segment.borderType = .bottom
            segment.borderColor = UIColor.lightGray
            segment.borderWidth = 0.5
            
            view.addSubview(segment)
            segment.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(40)
            }
            pageVC.view.snp.makeConstraints { (make) in
                make.top.equalTo(segment.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        default: break
        }
        guard let titles = titles else { return }
        segment.sectionTitles = titles
        currentSelectIndex = 0
        segment.selectedSegmentIndex = currentSelectIndex
    }
}

extension HHPageViewController:UIPageViewControllerDataSource,UIPageViewControllerDelegate
{
    // 返回当前控制器的前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController) else {
            return nil
        }
        let beforeIndex = index - 1
        guard beforeIndex >= 0 else {
            return nil
        }
        return vcs[beforeIndex]
    }
    // 返回当前控制器的后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController) else {
            return nil
        }
        let afterIndex = index + 1
        //添加判断防止数组越界
        guard afterIndex <= vcs.count - 1 else {
            return nil
        }
        return vcs[afterIndex]
    }
    // 滑动结束时的回调
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.last, let index = vcs.firstIndex(of: viewController) else {
            return
        }
        currentSelectIndex = index
        segment.setSelectedSegmentIndex(UInt(index), animated: true)
        guard titles != nil && pageStyle == .none else {
            return
        }
        navigationItem.title = titles[index]
    }
}
