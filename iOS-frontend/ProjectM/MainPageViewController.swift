//
//  MainPageViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 10/28/21.
//

import Foundation
import AVFoundation // Access camera
import UIKit

class MainPageViewController: UIViewController {
    
    private let captureSession = AVCaptureSession()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addCameraInput()
        // Do any additional setup after loading the view.
    }

    
    private func addCameraInput() {
        let device = AVCaptureDevice.default(for: .video)!
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }

}
