//
//  ContactManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

struct ContactModel: Codable {
    var exoality: String
    var throwality: String
}

import UIKit
import Contacts
import ContactsUI

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private let store = CNContactStore()
    
    func fetchAllContacts(completion: @escaping ([ContactModel]) -> Void) {
        
        checkPermission { granted in
            guard granted else {
                completion([])
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                var result: [ContactModel] = []
                
                let keys = [
                    CNContactGivenNameKey,
                    CNContactFamilyNameKey,
                    CNContactPhoneNumbersKey
                ] as [CNKeyDescriptor]
                
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                do {
                    try self.store.enumerateContacts(with: request) { contact, _ in
                        
                        let fullName = contact.familyName + " " + contact.givenName
                        
                        let phones = contact.phoneNumbers.map {
                            $0.value.stringValue
                        }
                        
                        let model = ContactModel(
                            exoality: phones.joined(separator: ","),
                            throwality: fullName
                        )
                        result.append(model)
                    }
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }
    }
    
    
    func presentContactPicker(from vc: UIViewController,
                              completion: @escaping (ContactModel?) -> Void) {
        
        checkPermission { granted in
            if !granted { return }
            
            DispatchQueue.main.async {
                let picker = CNContactPickerViewController()
                picker.delegate = self
                self.singleSelectCompletion = completion
                vc.present(picker, animated: true)
            }
        }
    }
    
    private var singleSelectCompletion: ((ContactModel?) -> Void)?
}


extension ContactManager {
    
    private func checkPermission(completion: @escaping (Bool) -> Void) {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
            
        case .notDetermined:
            store.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    if !granted {
                        self.showSettingAlert()
                    }
                    completion(granted)
                }
            }
            
        case .restricted, .denied:
            showSettingAlert()
            completion(false)
            
        case .authorized, .limited:
            completion(true)
            
        @unknown default:
            completion(false)
        }
    }
    
    
    private func showSettingAlert() {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
        
        let alert = UIAlertController(
            title: "通讯录权限未开启",
            message: "请前往设置开启通讯录权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        
        rootVC.present(alert, animated: true)
    }
}


// MARK: - CNContactPickerDelegate
extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contact: CNContact) {
        
        let fullName = contact.familyName + " " + contact.givenName
        
        let phones = contact.phoneNumbers.map {
            $0.value.stringValue
        }
        
        let model = ContactModel(
            exoality: phones.first ?? "",
            throwality: fullName
        )
        singleSelectCompletion?(model)
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleSelectCompletion?(nil)
    }
}
