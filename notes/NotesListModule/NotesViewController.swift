//
//  ViewController.swift
//  notes
//
//  Created by Aleksandr Garipov on 30.01.2024.
//

import UIKit

class NotesViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Properties
    
    var viewModel: NotesViewModel?
    
    weak var notesViewControllerCoordinator: NotesViewControllerCoordinator?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotesTableView()
        setupConstraints()
        bind()
        viewModel?.viewWillAppear()
    }
    
    //MARK: - Methods
    
    private func bind() {
        viewModel?.$numberOfNotes.bind(action: { [weak self] _ in
            self?.notesTableView.reloadData()
        })
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Notes"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.addSubview(notesTableView)
    }
    
    private func setupNotesTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        notesTableView.separatorStyle = .none
        notesTableView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            notesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
}

//MARK: - UITableViewDataSource

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfNotes ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("Unable to dequeue NoteTableViewCell")
        }
        cell.configure(with: "Заголовок \(indexPath.row)")
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
