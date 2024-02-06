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
    private var isBoldTextEnabled = false {
        didSet {
            boldButton.tintColor = isBoldTextEnabled ? .systemBlue : .systemGray
        }
    }
    
    private var isItalicTextEnabled = false {
        didSet {
            italicButton.tintColor = isItalicTextEnabled ? .systemBlue : .systemGray
        }
    }
    
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
    
    //MARK: - ToolBar Buttons
    
    private lazy var boldButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Жирный", style: .plain, target: self, action: #selector(boldText))
        button.tintColor = isBoldTextEnabled ? .systemBlue : .systemGray
        return button
    }()
    
    private lazy var italicButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Курсив", style: .plain, target: self, action: #selector(italicText))
        button.tintColor = isBoldTextEnabled ? .systemBlue : .systemGray
        return button
    }()
    
    private lazy var imageButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Изображение", style: .plain, target: self, action: #selector(insertImage))
        return button
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
        noteTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func bind() {
        viewModel.$currentNoteModel.bind(action: { [weak self] note in
            self?.titleTextField.text = note?.title
            self?.noteTextView.attributedText = note?.text
        })
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([boldButton, flexSpace, italicButton, flexSpace, imageButton], animated: false)
        noteTextView.inputAccessoryView = toolbar
    }
    
    private func setupUI() {
        title = "Редактирование"
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
        viewModel.updateText(noteTextView.attributedText)
        viewModel.updateTitle(titleTextField.text ?? "")
        viewModel.saveButtonPressed()
    }
    
    @objc private func cancelButtonPressed() {
        viewModel.cancelButtonPressed()
    }
    
    @objc private func boldText() {
        isItalicTextEnabled = false
        let selectedRange = noteTextView.selectedRange
        
        guard selectedRange.length > 0 else {
            isBoldTextEnabled.toggle()
            return
        }
        
        let currentAttributes = noteTextView.attributedText.attributes(at: selectedRange.location, effectiveRange: nil)
        
        if let currentFont = currentAttributes[.font] as? UIFont {
            let systemFont = UIFont.systemFont(ofSize: 16)
            let boldSystemFont = UIFont.boldSystemFont(ofSize: 16)
            
            if currentFont == boldSystemFont {
                let normalAttributes: [NSAttributedString.Key: Any] = [.font: systemFont]
                noteTextView.textStorage.addAttributes(normalAttributes, range: selectedRange)
            } else {
                let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldSystemFont]
                noteTextView.textStorage.addAttributes(boldAttributes, range: selectedRange)
            }
        }
    }
    
    @objc private func italicText() {
        isBoldTextEnabled = false
        let selectedRange = noteTextView.selectedRange
        
        guard selectedRange.length > 0 else {
            isItalicTextEnabled.toggle()
            return
        }
        
        let currentAttributes = noteTextView.attributedText.attributes(at: selectedRange.location, effectiveRange: nil)
        
        if let currentFont = currentAttributes[.font] as? UIFont {
            let systemFont = UIFont.systemFont(ofSize: 16)
            let italicSystemFont = UIFont.italicSystemFont(ofSize: 16)
            
            if currentFont == italicSystemFont {
                let normalAttributes: [NSAttributedString.Key: Any] = [.font: systemFont]
                noteTextView.textStorage.addAttributes(normalAttributes, range: selectedRange)
            } else {
                let italicAttributes: [NSAttributedString.Key: Any] = [.font: italicSystemFont]
                noteTextView.textStorage.addAttributes(italicAttributes, range: selectedRange)
            }
        }
    }
    
    private func applyTextAttributes() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = UIFont.systemFont(ofSize: 16)
        
        if isBoldTextEnabled {
            attributes[.font] = UIFont.boldSystemFont(ofSize: 16)
        }
        
        if isItalicTextEnabled {
            attributes[.font] = UIFont.italicSystemFont(ofSize: 16)
        }
        
        noteTextView.typingAttributes = attributes
    }
    
    
    //TODO: - image insert
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
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        let targetWidth = noteTextView.bounds.width * 2 / 3
        guard let resizedImage = selectedImage.resized(toWidth: targetWidth) else { return }
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = resizedImage
        
        let imageString = NSMutableAttributedString(attachment: textAttachment)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedStringWithLineBreaks = NSMutableAttributedString(string: "\n")
        attributedStringWithLineBreaks.append(imageString)
        attributedStringWithLineBreaks.append(NSAttributedString(string: "\n"))
        
        attributedStringWithLineBreaks.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedStringWithLineBreaks.length))
        
        if noteTextView.selectedRange.location != NSNotFound {
            noteTextView.textStorage.insert(attributedStringWithLineBreaks, at: noteTextView.selectedRange.location)
        } else {
            noteTextView.textStorage.append(attributedStringWithLineBreaks)
        }
    }
}

//MARK: - UITextViewDelegate

extension EditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        applyTextAttributes()
        return true
    }
}
