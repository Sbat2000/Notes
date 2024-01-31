//
//  NotesCell.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    
    static let identifier = "NoteTableViewCell"
    
    //MARK: - UI Elements
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func configure(with note: NoteModel) {
        titleLabel.text = note.title
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor)
        ])
    }
}
