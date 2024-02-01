//
//  EditViewController.swift
//  notes
//
//  Created by Aleksandr Garipov on 01.02.2024.
//

import UIKit

final class EditViewController: UIViewController {
    
    //MARK: - Properties:
    
    let viewModel: EditViewModel
    
    //MARK: - UI Elements
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9024235606, green: 0.902423501, blue: 0.9024235606, alpha: 1)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите заголовок"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = #colorLiteral(red: 0.9024235606, green: 0.902423501, blue: 0.9024235606, alpha: 1)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - LifeCycle
    
    init(viewModel: EditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationItems()
        bind()
        setupToolbar()
        viewModel.viewWillAppear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func bind() {
        viewModel.$currentNoteModel.bind(action: { [weak self] note in
            self?.titleTextField.text = note?.title
            self?.noteTextView.text = note?.text
        })
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let boldButton = UIBarButtonItem(title: "Жирный", style: .plain, target: self, action: #selector(boldText))
        let italicButton = UIBarButtonItem(title: "Курсив", style: .plain, target: self, action: #selector(italicText))
        let fontButton = UIBarButtonItem(title: "Шрифт", style: .plain, target: self, action: #selector(changeFont))
        let imageButton = UIBarButtonItem(title: "Изображение", style: .plain, target: self, action: #selector(insertImage))

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([boldButton, flexSpace, italicButton, flexSpace, fontButton, flexSpace, imageButton], animated: false)
        noteTextView.inputAccessoryView = toolbar
    }
    
    private func setupUI() {
        title = "Заметка"
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(noteTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
        ])
    }
    
    //MARK: - Actions:
    
    @objc private func saveButtonPressed() {

    }
    
    @objc private func boldText() {
        // Логика для применения жирного стиля к тексту
    }

    @objc private func italicText() {
        // Логика для применения курсивного стиля к тексту
    }

    @objc private func changeFont() {
        // Логика для изменения шрифта
    }
    
    @objc private func insertImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {

        }
        picker.dismiss(animated: true, completion: nil)
    }
}
