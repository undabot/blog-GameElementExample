//
//  StoreCell.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/14/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

class StoreCell: UITableViewCell {
    
    private var store: Store?
    
    private let storeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let scoreValueLabel = UILabel()
    private let playImageView = UIImageView()
    
    func setup(with store: Store) {
        self.store = store
        selectionStyle = .none
        addSubviews()
        addImageView()
        addTitleLabel()
        addScoreValueLabel()
        addPlayImageView()
    }
    
    private func addSubviews() {
        contentView.addSubview(storeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(scoreValueLabel)
        contentView.addSubview(playImageView)
    }
    
    private func addImageView() {
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
        storeImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            storeImageView.topAnchor.constraint(equalTo: topAnchor, constant: (frame.size.height-62)/2),
            storeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.size.height-62)/2),
            storeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            storeImageView.widthAnchor.constraint(equalToConstant: 62),
            storeImageView.heightAnchor.constraint(equalToConstant: 62)
            ])
        storeImageView.layer.masksToBounds = true
        storeImageView.layer.cornerRadius = 10
        storeImageView.backgroundColor = store?.backgroundColor
        storeImageView.image = store?.image
    }
    
    private func addTitleLabel() {
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        guard let storeName = store?.name else { return }
        let textString = NSMutableAttributedString(string: storeName, attributes: [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 20)!])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.29
        textString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: textRange)
        titleLabel.attributedText = textString
        titleLabel.sizeToFit()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.size.height/2-30),
            titleLabel.bottomAnchor.constraint(equalTo: scoreValueLabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16)
            ])
    }
    
    private func addScoreValueLabel() {
        scoreValueLabel.lineBreakMode = .byWordWrapping
        scoreValueLabel.numberOfLines = 0
        scoreValueLabel.textColor = .gray
        guard var cuponScore = store?.cuponScore,
            let maxCuponScore = store?.maxCuponScore
            else { return }
        if cuponScore >= maxCuponScore {
            cuponScore = maxCuponScore
            scoreValueLabel.textColor = UIColor(red: 247/255, green: 37/255, blue: 0/255, alpha: 1.0)
        }
        let textContent = "\(cuponScore)/\(maxCuponScore) points"
        let textString = NSMutableAttributedString(string: textContent, attributes: [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 17)!])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.15
        textString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: textRange)
        scoreValueLabel.attributedText = textString
        scoreValueLabel.sizeToFit()
        
        scoreValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.size.height/2-30)),
            scoreValueLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16),
            scoreValueLabel.trailingAnchor.constraint(equalTo: playImageView.leadingAnchor)
            ])
    }
    
    private func addPlayImageView() {
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            playImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            playImageView.widthAnchor.constraint(equalToConstant: 84),
            playImageView.heightAnchor.constraint(equalToConstant: 28)
            ])
        
        guard let cuponScore = store?.cuponScore,
            let maxCuponScore = store?.maxCuponScore
            else { return }
        if cuponScore >= maxCuponScore {
            playImageView.image = #imageLiteral(resourceName: "redeem_coupon")
        } else {
            playImageView.image = #imageLiteral(resourceName: "play_button")
        }
    }
}
