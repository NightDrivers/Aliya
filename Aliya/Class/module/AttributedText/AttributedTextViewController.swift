//
//  AttributtedTextViewController.swift
//  Aliya
//
//  Created by ldc on 2019/5/23.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import UIKit

class AttributtedTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let attributedString = NSMutableAttributedString.init(string: "南派三叔原名徐磊，浙江嘉善人，曾就读于嘉善二中，毕业于浙江树人大学[16]  。曾做过广告美工、软件编程、国际贸易等诸多行业。[17]  因为小时年弱多病，所以尝试用写作的方式构建自己想象中的世界，常常以身边人如家人与同学作为原型进\n行创作。[18]  在一篇《盗墓笔记》的番外里，南派三叔写道，5岁的自己，窝在外婆怀里时，听到了人生里第一个和尸体有关的故事，讲的是村中大户院子底下挖出的血尸，从此对地底下的神秘世界产生了浓厚的想象。[18]  2006年他开始在网上进行文学创作，写下第一篇《七星鲁王宫》，受到网友热捧，有了自己的固定书粉，粉丝们追着他催更，于是开始白天上班，晚上更文，一有空暇，随处打开电脑就可以文思泉涌。[18]  他的连载地从贴吧转移到起点中文网，半年后，正式整理成书，《盗墓笔记：七星鲁王宫》就是《盗墓笔记》系列的第一本成书。[18")
        
        attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.cyan], range: NSRange.init(location: 0, length: attributedString.length))
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        //首行缩进点数 正数
        paragraph.firstLineHeadIndent = 30
        //首部缩进点数 正数
        paragraph.headIndent = 10
        //正数代表与左边框的距离，负数或0代表与右边框的距离
        paragraph.tailIndent = -10
        //行间隔点数
        paragraph.lineSpacing = 2
        //添加到段落结尾的空间
        paragraph.paragraphSpacing = 10
        //添加到段落开头的空间
        paragraph.paragraphSpacingBefore = 10
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraph], range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle:1], range: NSRange.init(location: 0, length: attributedString.length))
        label.attributedText = attributedString
    }
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.backgroundColor = UIColor.black
        view.addSubview(temp)
        temp.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.height.equalTo(200)
            $0.left.right.equalToSuperview()
        }
        return temp
    }()
}
