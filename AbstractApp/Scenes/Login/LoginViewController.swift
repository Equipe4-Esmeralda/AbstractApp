//
//  ViewController.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 21/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    @IBOutlet weak var switchLogin: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController carrega e pronta para o uso")
        loginTextField.delegate = self
        paswordTextField.delegate = self
        button.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchLogin.isOn = StoreManager.shared.exists(forKey: "logged")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if switchLogin.isOn {
            presentProfile()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTextField.resignFirstResponder()
        paswordTextField.resignFirstResponder()
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        if let login = loginTextField.text, let password = paswordTextField.text {
            if (!login.isEmpty && !password.isEmpty) {
                presentProfile()
            }
        }
    }
    
    @IBAction func hanleInfo(_ sender: Any) {
        presentAbout()
    }
    
    @IBAction func handleSwitch(_ sender: Any) {
        if (switchLogin.isOn) {
            StoreManager.shared.save("true", forKey: "logged")
        } else {
            StoreManager.shared.remove(forKey: "logged")
        }
    }
    
    func presentProfile() {
        let profileViewController = storyboard?.instantiateViewController(identifier: "tabBar")
        profileViewController?.modalPresentationStyle = .fullScreen
        profileViewController?.modalTransitionStyle = .coverVertical
        self.present(profileViewController!, animated: true)
    }
    
    func presentAbout() {
        let viewController = AboutViewController(nibName: "About", bundle: nil)
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View sera removida em breve")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View já não é mais visível ao usuário")
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -140
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        paswordTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == paswordTextField {
            // Monta o texto atualizado simulando a digitação em tempo real
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                button.isEnabled = updatedText.count >= 4
            }
        }
        
        return true
    }
}
