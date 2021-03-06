//
//  LabelledView.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

/// A view that will show two labels aligned
class LabelledView: UIView {

    private lazy var titleLabel: BaseLabel = {
        let titleLabel = BaseLabel()
        titleLabel.textColor = .lightText
        titleLabel.textAlignment = .right
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private lazy var contentLabel: BaseLabel = {
        let contentLabel = BaseLabel()
        contentLabel.textAlignment = .right
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()

    var title: String? {
        get { return titleLabel.text }
        set(title) { titleLabel.text = title }
    }

    var content: String? {
        get { return contentLabel.text }
        set(content) { contentLabel.text = content }
    }

    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(contentLabel)

        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        contentLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        contentLabel.widthAnchor.constraint(equalToConstant: 101).isActive = true
    }
}
