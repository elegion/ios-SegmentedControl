//
//  SegmentedControlItem.swift
//  SegmentedControl
//
//  Created by Николай Кагала on 14/03/2017.
//  Copyright © 2017 Николай Кагала. All rights reserved.
//

import UIKit

enum SegmentedControlItemWidth {
    case fixed(CGFloat)
    case fitToContent
}

enum SegmentedControlItemHeight {
    case fixed(CGFloat)
}

struct SegmentedControlItemSize {
    var width: SegmentedControlItemWidth = .fitToContent
    var height: SegmentedControlItemHeight = .fixed(44)
}

struct SegmentedControlItemAttributes {
    var backgroundColor: UIColor = .clear
    var normalTitleColor: UIColor = .gray
    var selectedTitleColor: UIColor = .black
    var highlightedTitleColor: UIColor = .lightGray
    var titleFont: UIFont = .systemFont(ofSize: 12)
    var size = SegmentedControlItemSize()
    var margins: CGFloat = 10
}

class SegmentedControlItem: UIView {
    
    //MARK: - Properties
    
    private(set) var title: String
    private(set) var titleButton = UIButton()
    private var attributes: SegmentedControlItemAttributes
    
    //MARK: - Initialization
    
    init(title: String, attributes: SegmentedControlItemAttributes = SegmentedControlItemAttributes()) {
        self.title = title
        self.attributes = attributes
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleButton)
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleButton.setTitleColor(attributes.normalTitleColor, for: .normal)
        titleButton.setTitleColor(attributes.highlightedTitleColor, for: .highlighted)
        titleButton.setTitleColor(attributes.selectedTitleColor, for: .selected)
        titleButton.titleLabel!.font = attributes.titleFont
        titleButton.setTitle(title, for: .normal)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.bindEdgesToSuperview(orientation: .vertical)
        titleButton.bindEdgesToSuperview(padding: attributes.margins, orientation: .horizontal)
        titleButton.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        titleButton.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        titleButton.isSelected = selected
    }
    
    func setHighlighted(_ highlighted: Bool, animated: Bool) {
        titleButton.isHighlighted = highlighted
    }
    
    override var intrinsicContentSize: CGSize {
        let width: CGFloat
        let height: CGFloat
        switch attributes.size.width {
        case .fixed(let fixedWidth): width = fixedWidth
        case .fitToContent: width = titleButton.sizeThatFits(bounds.size).width + attributes.margins * 2
        }
        switch attributes.size.height {
        case .fixed(let fixedHeight): height = fixedHeight
        }
        return CGSize(width: width, height: height)
    }
}