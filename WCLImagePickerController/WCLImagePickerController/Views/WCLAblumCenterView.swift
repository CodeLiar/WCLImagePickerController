//
//  WCLAblumCenterView.swift
//  WCLImagePickrController-swift
//
// **************************************************
// *                                  _____         *
// *         __  _  __     ___        \   /         *
// *         \ \/ \/ /    / __\       /  /          *
// *          \  _  /    | (__       /  /           *
// *           \/ \/      \___/     /  /__          *
// *                               /_____/          *
// *                                                *
// **************************************************
//  Github  :https://github.com/631106979
//  HomePage:https://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//
//
// @class WCLAblumCenterView
// @abstract 图片选择器nav上的titleView
// @discussion 图片选择器nav上的titleView
//

import UIKit

internal class WCLAblumCenterView: UIControl {

    var centerTitle:String? {
        didSet {
            titleLabel.text = centerTitle
        }
    }
    
    var selectBlock:((Bool) ->Void)?
    
    var isSelect = false {
        didSet {
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowImageView.layer.transform = CATransform3DRotate(self.arrowImageView.layer.transform,  CGFloat(Double.pi), 1.0, 0.0, 0.0)
            }) 
            selectBlockAction()
        }
    }
    
    private let arrowImageView = UIImageView.init(image: WCLImagePickerOptions.pickerArrow)
    private let titleLabel = UILabel()
    
    //MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = UIColor.white
        addSubview(arrowImageView)
        addSubview(titleLabel)
        let height = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: frame.height);
        addConstraint(height)
        
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: frame.width)
        addConstraint(width)
        //添加约束
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: -11.0))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint.init(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint.init(item: arrowImageView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1.0, constant: 7.0))
        addTarget(self, action: #selector(tapAction(_:)), for: .touchUpInside)
    }
    
    @objc func tapAction(_ btn: UIControl) {
        isSelect = !isSelect
        selectBlockAction()
    }
    
    
    func selectBlockAction() {
        if selectBlock != nil {
            selectBlock!(isSelect)
        }
    }
    
    //MARK: Initial Methods
    convenience init(frame: CGRect, selectBlock:@escaping (Bool) ->Void) {
        self.init(frame: frame)
        self.selectBlock = selectBlock
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
