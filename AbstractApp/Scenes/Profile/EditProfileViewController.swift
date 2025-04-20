import UIKit

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(_ profile: ProfileModel)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: EditProfileDelegate?
    var profile: ProfileModel = ProfileModel(
        name: "",
        bio: "",
        email: "",
        phone: ""
    )
    
    // MARK: - IBOutlets
    @IBOutlet private weak var nameTextField: UITextField?
    @IBOutlet private weak var bioTextField: UITextField?
    @IBOutlet private weak var emailTextField: UITextField?
    @IBOutlet private weak var phoneTextField: UITextField?
    @IBOutlet private weak var saveButton: UIButton?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateFields()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Editar Perfil"
        
        // Configure text fields
        [nameTextField, bioTextField, emailTextField, phoneTextField].forEach { textField in
            textField?.layer.cornerRadius = 8
            textField?.layer.borderWidth = 1
            textField?.layer.borderColor = UIColor.systemGray5.cgColor
            textField?.delegate = self
            textField?.font = .systemFont(ofSize: 16)
            textField?.padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        // Set placeholders
        nameTextField?.placeholder = "Nome"
        bioTextField?.placeholder = "Bio"
        emailTextField?.placeholder = "Email"
        phoneTextField?.placeholder = "Telefone"
        
        // Set keyboard types
        emailTextField?.keyboardType = .emailAddress
        phoneTextField?.keyboardType = .phonePad
        
        // Configure save button
        saveButton?.layer.cornerRadius = 8
        saveButton?.backgroundColor = .systemBlue
        saveButton?.setTitleColor(.white, for: .normal)
        saveButton?.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        saveButton?.setTitle("Salvar", for: .normal)
    }
    
    private func populateFields() {
        nameTextField?.text = profile.name
        bioTextField?.text = profile.bio
        emailTextField?.text = profile.email
        phoneTextField?.text = profile.phone
    }
    
    // MARK: - Actions
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        let updatedProfile = ProfileModel(
            name: nameTextField?.text ?? "",
            bio: bioTextField?.text ?? "",
            email: emailTextField?.text ?? "",
            phone: phoneTextField?.text ?? ""
        )
        
        delegate?.didUpdateProfile(updatedProfile)
        
        // Tenta voltar usando o navigationController se disponível
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            // Se não estiver em um navigationController, tenta dismiss
            dismiss(animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextField Extension
extension UITextField {
    var padding: UIEdgeInsets {
        get { return UIEdgeInsets.zero }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue.left, height: frame.height))
            leftView = paddingView
            leftViewMode = .always
            
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue.right, height: frame.height))
            rightView = rightPaddingView
            rightViewMode = .always
        }
    }
}

