//
//  ScrollableSegmentedControllTestViewController.swift
//  Aliya
//
//  Created by ldc on 2019/5/22.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import UIKit

class ScrollableSegmentedControllTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "滑动分段选择器"
        view.backgroundColor = UIColor.white
        scrollableSegmentedControl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.centerY.equalTo(self.snp.centerY)
            $0.height.equalTo(40)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.scrollableSegmentedControl.select(0)
        }
    }
    
    lazy var scrollableSegmentedControl: ScrollableSegmentedControl = {
        let titles = ["abc", "sdafa", "adflakd", "a", "adfaksdfla", "askjdfaldsfm"]
        let temp = ScrollableSegmentedControl.init(titles: titles)
        temp.backgroundColor = UIColor.cyan
        view.addSubview(temp)
        temp.indexDidChangeClosure = { index in
            print(index)
        }
        return temp
    }()
}

class ScrollableSegmentedControl: UICollectionView {
    
    var indexDidChangeClosure: ((_: Int) -> Void)?
    
    let titles: [String]
    let font = UIFont.systemFont(ofSize: 14)
    var textColor = UIColor.black
    var selectedTextColor = UIColor.red
    var cellHeight: CGFloat = 40
    
    init(frame: CGRect = .zero, titles: [String]) {
        self.titles = titles
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        //垂直滑动 列间隔 水平滑动  行间隔
        flowLayout.minimumInteritemSpacing = 5
        // 垂直滑动 行间隔 水平滑动 列间隔
        flowLayout.minimumLineSpacing = 5
        //以上两项需要设置为相同的值，不知道为什么
        flowLayout.estimatedItemSize = CGSize.init(width: 50, height: cellHeight)
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        showsHorizontalScrollIndicator = false
        register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "iden")
        self.delegate = self
        self.dataSource = self
    }
    
    func select(_ index: Int) -> Void {
        let indexPath = IndexPath.init(row: index, section: 0)
        selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellHeight = height
    }
}

extension ScrollableSegmentedControl: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iden", for: indexPath) as! TitleCollectionViewCell
        cell.edges = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
        cell.cellHeight = cellHeight
        cell.label.font = font
        cell.textColor = textColor
        cell.selectedTextColor = selectedTextColor
        cell.label.text = titles[indexPath.row]
        cell.backgroundColor = UIColor.magenta
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexDidChangeClosure?(indexPath.row)
    }
}

class TitleCollectionViewCell: UICollectionViewCell {
    
    var edges = UIEdgeInsets.zero
    var cellHeight: CGFloat = 40
    
    var textColor = UIColor.black {
        didSet { label.textColor = textColor }
    }
    
    var selectedTextColor = UIColor.red
    
    override var isSelected: Bool {
        
        didSet {
            label.textColor = isSelected ? selectedTextColor : textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = textColor
        contentView.addSubview(temp)
        temp.snp.makeConstraints {
            $0.height.equalTo(self.cellHeight)
            $0.top.equalToSuperview().offset(edges.top)
            $0.left.equalToSuperview().offset(edges.left)
            $0.right.equalToSuperview().offset(edges.right)
            $0.bottom.equalToSuperview().offset(edges.bottom)
        }
        return temp
    }()
}
