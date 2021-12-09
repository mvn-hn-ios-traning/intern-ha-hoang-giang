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
import Photos

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var avatarPicture: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var registerViewModel: RegisterViewModel!
    
    let tap = UITapGestureRecognizer()
    
    let imageSubject = BehaviorSubject<UIImage?>(value: nil)
    
    var style: ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = .darkGray
        return style
    }
    
    let imagePicker = UIImagePickerController()
    let status = PHPhotoLibrary.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToastManager.shared.style = style
        hideKeyboardWhenTappedAround()
        modelAvatar()
        tapEvent()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = RegisterViewModel.Input(backTrigger: backButton.rx.tap.asDriver(),
                                            imageTrigger: imageSubject.asDriver(onErrorJustReturn: nil),
                                            enteredFirstName: firstNameTF.rx.text.orEmpty.asDriver(),
                                            enteredLastName: lastNameTF.rx.text.orEmpty.asDriver(),
                                            enteredEmail: emailTextField.rx.text.orEmpty.asDriver(),
                                            enteredPassword: passwordTextField.rx.text.orEmpty.asDriver(),
                                            tappedRegister: registerButton.rx.tap.asDriver())
        
        let output = registerViewModel.transform(input: input)
        
        output.goBack.drive().disposed(by: disposeBag)
        
        output
            .enableRegister
            .drive(registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output
            .tappedRegister
            .bind(onNext: { [weak self] text in
                guard let self = self else { return }
                
                self.view.endEditing(true)
                self.displayAlertWhenClickSignup(text: text)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Setup Avatar
    func modelAvatar() {
        avatarPicture.layer.borderWidth = 1.0
        avatarPicture.layer.masksToBounds = true
        avatarPicture.layer.borderColor = UIColor.white.cgColor
        avatarPicture.layer.cornerRadius = avatarPicture.frame.size.width/2
        avatarPicture.clipsToBounds = true
    }
    
    func tapEvent() {
        self.avatarPicture.isUserInteractionEnabled = true
        self.avatarPicture.addGestureRecognizer(tap)
        
        tap.rx.event
        .subscribe(onNext: { [weak self] _ in
            self?.chooseAvatar()
        })
        .disposed(by: disposeBag)
    }
    
    func chooseAvatar() {
        let alert = UIAlertController(title: nil,
                                      message: "Choose options",
                                      preferredStyle: .actionSheet)
        
        let takeLibrary = UIAlertAction(title: "Photo Library",
                                        style: .default) { (_) in
                                            self.photoAuthorisationStatus()
        }
                                            
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(takeLibrary)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    // when user choose photo library
    func photoAuthorisationStatus() {
        switch self.status {
        case .authorized:
            self.photoLibrary()
        case .notDetermined:
            print("Permission not determined")
            PHPhotoLibrary.requestAuthorization({ status in
                if status == PHAuthorizationStatus.authorized {
                    self.photoLibrary()
                } else {
                    self.addAlertForSettings()
                }
            })
        case .restricted:
            print("Permission not determined")
            self.addAlertForSettings()
        case .denied:
            print("Permission not determined")
            self.addAlertForSettings()
        case .limited:
            break
        @unknown default:
            break
        }
    }
    
    // Go to photo libary
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            DispatchQueue.main.async {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    // popup alert when user dont allow access photo library
    func addAlertForSettings() {
        DispatchQueue.main.async {
            let photoUnavailableAlert = UIAlertController(title: "App does not have access to your photos",
                                                          message: nil,
                                                          preferredStyle: .alert)
            let settingAction = UIAlertAction(title: "Go to Setting",
                                              style: .destructive,
                                              handler: {(_) -> Void in
                                                let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
                                                if let url = settingsUrl {
                                                    UIApplication
                                                        .shared
                                                        .open(url as URL, options: [:], completionHandler: nil)
                                                }
            })
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel,
                                             handler: nil)
            photoUnavailableAlert.addAction(settingAction)
            photoUnavailableAlert.addAction(cancelAction)
            self.present(photoUnavailableAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: - When click Signup button
    func displayAlertWhenClickSignup(text: String) {
        let alert = UIAlertController(title: nil,
                                      message: text,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate
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
