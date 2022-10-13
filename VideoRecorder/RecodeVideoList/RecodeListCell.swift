//
//  RecodeListCell.swift
//  VideoRecorder
//
//  Created by 홍다희 on 2022/10/11.
//

import UIKit
import Photos

final class RecodeListCell: UITableViewCell {

    static let reuseIdentifier = String(describing: RecodeListCell.self)

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .bottom // TODO: 두 열 중 길이가 짧은 열의 아래쪽으로 새로운 영상을 배치합니다.
        stackView.spacing = 8
        return stackView
    }()

    private let durationLabel: UILabel = {
        let inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let label = PaddingLabel(padding: inset)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemBackground
        label.backgroundColor = .label.withAlphaComponent(0.5)
        label.adjustsFontForContentSizeCategory = true
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return label
    }()

    private(set) var representedAssetIdentifier: String!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(containerStackView)
        contentView.addSubview(durationLabel)

        containerStackView.addArrangedSubview(thumbnailImageView)
        containerStackView.addArrangedSubview(labelStackView)

        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(dateLabel)

        let containerViewInset: CGFloat = 20
        let durationLabelInset: CGFloat = 4
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: containerViewInset),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerViewInset),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerViewInset),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -containerViewInset),

            thumbnailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 0.75),

            durationLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: durationLabelInset),
            durationLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -durationLabelInset),
        ])

        accessoryType = .disclosureIndicator
    }

    func configure(with asset: PHAsset) {
        representedAssetIdentifier = asset.localIdentifier
        
        titleLabel.text = representedAssetIdentifier
        durationLabel.text = asset.duration.displayTime
        dateLabel.text = asset.creationDate?.string()
    }
}