//
//  CountersEmptyStateView.swift
//  Counters
//
//  Created by Râmede on 10/10/21.
//

import UIKit

final class CountersEmptyStateView: UITableViewCell {

    // MARK: - Private Properties
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var button = Button()

    // MARK: - Public Properties

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
}

// MARK: - Private Constants
private extension CountersEmptyStateView {
    enum Constants {
        enum MainView {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
            static let radius: CGFloat = 8
        }
        
        enum Space {
            static let top: CGFloat = UIScreen.main.bounds.height * 24 / 100
        }
    }
    
    enum Font {
        static let title = UIFont.systemFont(ofSize: 22, weight: .regular)
        static let description = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    enum Shadow {
        static let opacity: Float = 1
        static let radius: CGFloat = 16
        static let offset = CGSize(width: 0, height: 8)
        static let color = UIColor(white: 0, alpha: 0.1).cgColor
    }
}

// MARK: - Private Implementation
private extension CountersEmptyStateView {
    func setup() {
        backgroundColor = .clear
        setupTitleLabel()
        setupDescriptionLabel()
        setupButton()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.title)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor(named: "PrimaryText")
        titleLabel.text = "No counters yet"
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.description)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .systemGray
        descriptionLabel.text = "“When I started counting my blessings, my whole life turned around.” —Willie Nelson"
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        button.clipsToBounds = false
        button.layer.shadowRadius = Shadow.radius
        button.layer.shadowColor = Shadow.color
        button.layer.shadowOffset = Shadow.offset
        button.layer.shadowOpacity = Shadow.opacity
        button.setTitle("Create a counter", for: .normal)
    }

    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(button)
    }
        
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 165),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Space.top),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),

            descriptionLabel.widthAnchor.constraint(equalToConstant: 304),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),

            button.heightAnchor.constraint(equalToConstant: 35),
            button.widthAnchor.constraint(equalToConstant: 190),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

private extension CountersEmptyStateView {
    @objc func didPressButton() {
        print("## didPressButton ###########")
    }
}
