//
//  ViewController.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    
    var page:String?
    var text:String?
    @IBOutlet weak var lbText: UITextField!
    @IBOutlet weak var lbPage: UITextField!
    @IBOutlet weak var btSearch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbText.delegate = self
        lbPage.delegate = self
        
        
        
        btSearch?.isUserInteractionEnabled = false
        btSearch?.alpha = 0.5
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

            if !text.isEmpty{
                btSearch?.isUserInteractionEnabled = true
                btSearch?.alpha = 1.0
            } else {
                btSearch?.isUserInteractionEnabled = false
                btSearch?.alpha = 0.5
            }
            return true
        }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
      }
    
        @objc func dismissKeyBoard() {
            self.view.endEditing(true)
        }
    
    @IBSegueAction func actionSencond(_ coder: NSCoder) -> UICollectionViewController? {
        
        page = lbPage.text
        text = lbText.text
        
        
        let controller = CollectionViewController(coder: coder)
        

        controller?.text = text
        controller?.page = page
        
        return controller
    }
    
    
    
}

