//
//  RegisterViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var avatarPicture: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    let tap = UITapGestureRecognizer()
    
    let imageSubject = BehaviorSubject<UIImage?>(value: nil)
    
    var style: ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = .darkGray
        return style
    }
    
    var registerViewModel: RegisterViewModel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToastManager.shared.style = style
        
        tapEvent()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = RegisterViewModel.Input(imageTrigger: imageSubject.asDriver(onErrorJustReturn: nil),
                                            enteredFirstName: firstNameTF.rx.text.orEmpty.asDriver(),
                                            enteredLastName: lastNameTF.rx.text.orEmpty.asDriver(),
                                            enteredEmail: emailTextField.rx.text.orEmpty.asDriver(),
                                            enteredPassword: passwordTextField.rx.text.orEmpty.asDriver(),
                                            tappedRegister: registerButton.rx.tap.asDriver())
        
        let output = registerViewModel.transform(input: input)
        
        output
            .enableRegister
            .drive(registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output
            .tappedRegister
            .bind(onNext: { [weak self] text in
                guard let self = self else { return }
                
                self.view.endEditing(true)
                self.view.makeToast(text, position: .top)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Setup Avatar
    func tapEvent() {
        tap.rx.event
        .subscribe(onNext: { [weak self] _ in
            self?.chooseAvatar()
        })
        .disposed(by: disposeBag)
    }
    
    func chooseAvatar() {
        self.avatarPicture.isUserInteractionEnabled = true
        self.avatarPicture.addGestureRecognizer(tap)
        
        let alert = UIAlertController(title: nil,
                                      message: "Choose options",
                                      preferredStyle: .actionSheet)
        
        let takePhoto = UIAlertAction(title: "Take a photo",
                                      style: .default) { (_) in
                                        self.imagePicker.sourceType = .camera
                                        self.present(self.imagePicker,
                                                     animated: true,
                                                     completion: nil) }
        
        let takeLibrary = UIAlertAction(title: "Photo Library",
                                        style: .default) { (_) in
                                            self.imagePicker.sourceType = .photoLibrary
                                            self.imagePicker.delegate = self
                                            self.present(self.imagePicker,
                                                         animated: true,
                                                         completion: nil) }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(takePhoto)
        alert.addAction(takeLibrary)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarPicture.image = image
            self.imageSubject.onNext(image)
        }
        dismiss(animated: true, completion: nil)
    }
}
