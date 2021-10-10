//
//  CountersEmptyStateTableViewCell.swift
//  Counters
//
//  Created by Râmede on 10/10/21.
//

import UIKit

final class CountersEmptyStateTableViewCell: UITableViewCell {

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
private extension CountersEmptyStateTableViewCell {
    enum Constants {
        enum Title {
            static let width: CGFloat = 165
            static let bottom: CGFloat = -20
        }
        
        enum Description {
            static let width: CGFloat = UIScreen.main.bounds.width * 79 / 100
            static let bottom: CGFloat = -20
        }
        
        enum Button {
            static let height: CGFloat = 35
            static let width: CGFloat = 190
        }
        
        enum Space {
            static let top: CGFloat = UIScreen.main.bounds.height * 22 / 100
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
private extension CountersEmptyStateTableViewCell {
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
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.Title.width),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Space.top),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: Constants.Title.bottom),

            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.Description.width),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: Constants.Description.bottom),

            button.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            button.widthAnchor.constraint(equalToConstant: Constants.Button.width),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

private extension CountersEmptyStateTableViewCell {
    @objc func didPressButton() {
        print("## didPressButton ###########")
    }
}
