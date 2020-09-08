//
//  ViewController.swift
//  GenerateBarCode
//
//  Created by Amir Tawfik on 09/09/2020.
//  Copyright © 2020 Amir Tawfik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var inputTF: UITextField!
    @IBOutlet var codeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func generateBarCodeTapped(_ sender: UIButton) {
        codeImageView.image = generateBarCode(inputTF.text ?? "")
    }
    
    @IBAction func generateQRCodeTapped(_ sender: UIButton) {
        codeImageView.image = generateQRCode(inputTF.text ?? "")
    }
    
    @IBAction func shareTapped(_ sender: UIButton) {
        guard let image = codeImageView.image else { return }
        let activities = ["code image",image] as [Any]
        let ac = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        present(ac, animated: true, completion: nil)
    }
    
    func generateBarCode(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
 
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
     
    func generateQRCode(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

