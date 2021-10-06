//
//  MainSceneView.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

final class MainSceneView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26.0)
        label.text = "Counters"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func buildHierarchy() {
        addSubview(titleLabel)
        backgroundColor = .cyan
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
