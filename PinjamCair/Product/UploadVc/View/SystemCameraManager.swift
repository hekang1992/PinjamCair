//
//  SystemCameraManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
internal import AVFoundation

class SystemCameraManager: NSObject {
    
    private var imagePicker: UIImagePickerController?
    private var completion: ((Data?) -> Void)?
    
    private let maxByteSize = 500
    
    func openCamera(from viewController: UIViewController,
                    cameraPosition: AVCaptureDevice.Position = .back,
                    completion: @escaping (Data?) -> Void) {
        
        self.completion = completion
        
        checkCameraPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    self.presentCamera(from: viewController,
                                       position: cameraPosition)
                } else {
                    self.showPermissionAlert(from: viewController)
                }
            }
        }
    }
}

extension SystemCameraManager {
    
    private func checkCameraPermission(_ completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
            
        case .denied, .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    private func showPermissionAlert(from vc: UIViewController) {
        let alert = UIAlertController(
            title: "无法使用相机",
            message: "请在设置中开启相机权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消",
                                      style: .cancel))
        
        alert.addAction(UIAlertAction(title: "去设置",
                                      style: .default,
                                      handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        
        vc.present(alert, animated: true)
    }
}

extension SystemCameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentCamera(from vc: UIViewController,
                               position: AVCaptureDevice.Position) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion?(nil)
            return
        }
        
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.cameraDevice = (position == .front) ? .front : .rear
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = false
        
        vc.present(imagePicker!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            completion?(nil)
            return
        }
        
        let compressedImage = compressImage(image)
        completion?(compressedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
    }
}

extension SystemCameraManager {
    
    private func compressImage(_ image: UIImage) -> Data? {
        var compression: CGFloat = 0.8
        let minCompression: CGFloat = 0.1
        
        guard var imageData = image.jpegData(compressionQuality: compression) else { return nil }
        
        while imageData.count > maxByteSize && compression > minCompression {
            compression -= 0.1
            if let newData = image.jpegData(compressionQuality: compression) {
                imageData = newData
            }
        }
        return imageData
    }
    
}
