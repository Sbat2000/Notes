//
//  NoteViewController.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NoteViewController: UIViewController {
    
    //MARK: - Properties:
    
    let viewModel: NoteViewModel
    
    //MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - LifeCycle
    
    init(viewModel: NoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationItems()
        bind()
        viewModel.viewWillAppear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func bind() {
        viewModel.$currentNoteModel.bind(action: { [weak self] note in
            self?.titleLabel.text = note?.title
            self?.noteTextView.attributedText = note?.text
        })
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    private func setupUI() {
        title = "Заметка"
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(noteTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            noteTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
        ])
    }
    
    //MARK: - Actions:
    
    @objc private func editButtonTapped() {
        viewModel.editButtonTapped()
    }
}
