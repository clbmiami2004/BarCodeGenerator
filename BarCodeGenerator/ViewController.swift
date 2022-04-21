//
//  ViewController.swift
//  BarCodeGenerator
//
//  Created by Christian Lorenzo on 2/22/21.
//

import UIKit
import Contacts
import CoreData

class ViewController: UIViewController {
    
    ///Properties:
    var str: String = ""
    var image: UIImage!
    var arrQrCodes: [QRCode]?
    var qRCodesarray = [UIImage]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    ///Outlets:
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var workNumberField: UITextField!
    @IBOutlet weak var cellNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var linkedInField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///Action Buttons:
    @IBAction func assignTextButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let company = companyField.text,
              let title = titleField.text,
              let workNumber = workNumberField.text,
              let cellNumber = cellNumberField.text,
              let email = emailField.text,
              let linkedIn = linkedInField.text,
              let address = addressField.text,
              let city = cityField.text,
              let state = stateField.text,
              let postal = postalCode.text,
              let country = countryField.text else {
            return
        }
        
        ///Test Code
        str = "BEGIN:VCARD \n" +
            "VERSION:2.1 \n" +
            "FN:\(firstName) \n" +
            "N:\(lastName);\(firstName) \n" +
            "TITLE:\(title) \n" +
            "TEL;CELL:\(cellNumber) \n" +
            "TEL;WORK;VOICE:\(workNumber) \n" +
            "EMAIL;WORK;INTERNET:\(email) \n" +
            "URL:\(linkedIn) \n" +
            "ADR;WORK:;;\(address);\(city);\(state);\(postal);\(country) \n" +
            "ORG:\(company) \n" +
            "END:VCARD"
        
        let myText = str
        
        //We can use this image for saving later
        image = generateQRCode(from: myText)
        imageViewOutlet.image = image
        
        saveInfo()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let qrCodeEntity = NSEntityDescription.insertNewObject(forEntityName: "QRCode", into: context) as! QRCode
        let png = self.imageViewOutlet.image?.pngData()
        image = imageViewOutlet.image
        qrCodeEntity.image = png
        CoreDataStack.coreDataStack.saveImage()
        qRCodesarray.append(image)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "QRCodeSaved") as! QrCodesSavedTableViewController
        vc.myQrCodesArray = qRCodesarray
        debugPrint("Initial QRCodes: \(qRCodesarray)")
        navigationController?.pushViewController(vc, animated: true)
//        let alertAction = UIAlertController(title: "Oops!", message: "Please complete the form and create a QRCode first!", preferredStyle: .alert)
//        present(alertAction, animated: true, completion: nil)
        
    }
    
    ///Methods:
    func generateQRCode(from string: String) -> UIImage? {
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
    
    //Function to show and to save info on device:
    func saveInfo() {
        if let data = str.data(using: .utf8) {
            do {
                let contacts = try CNContactVCardSerialization.contacts(with: data)
                let contact = contacts.first
                print("\(String(describing: contact?.familyName))")
            } catch {
                print("Error \(LocalizedError.self)")
            }
            
        }
        
    }
    
    ///Test Code
    //    var str = "BEGIN:VCARD \n" +
    //    "VERSION:2.1 \n" +
    //    "FN:\(fir) \n" +
    //    "N:Peter;John \n" +
    //    "TITLE:Admin \n" +
    //    "TEL;CELL:+91 431 524 2345 \n" +
    //    "TEL;WORK;VOICE:+91 436 542 8374 \n" +
    //    "EMAIL;WORK;INTERNET:John@ommail.in \n" +
    //    "URL:www.facebook.com \n" +
    //    "ADR;WORK:;;423 ofce sales Center;Newark;DE;3243;USA \n" +
    //    "ORG:xxx Private limited \n" +
    //    "END:VCARD"
    
    
    
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "goToQRCodes" {
    //            let destinationVC = segue.destination as! QrCodesSavedTableViewController
    //            destinationVC.myQrCodesArray = qRCodesarray
    //        }
    //    }
}
