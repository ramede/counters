//
//  CountersTableViewCell.swift
//  Counters
//
//  Created by Râmede on 06/10/21.
//

import UIKit

class CountersTableViewCell: UITableViewCell {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26.0)
        label.text = "Counters Cell"
        return label
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        buildHierarchy()
        buildConstraints()
        setupGestures()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupGestures() {
    }
    
    @objc
    private func dismissAction() {
    }

    @objc
    private func saveImageAction() {
    }

}
