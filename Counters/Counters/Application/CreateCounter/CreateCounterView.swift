//
//  CreateCounterView.swift
//  Counters
//
//  Created by Râmede on 09/10/21.
//

import UIKit

final class CreateCounterView: UIView {
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupHierarchy() {
        backgroundColor = .cyan
    }
    
    private func setupConstraints() {
    }
    
}
