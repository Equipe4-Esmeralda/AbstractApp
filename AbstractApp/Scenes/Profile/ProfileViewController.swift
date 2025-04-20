import UIKit

class ProfileViewController: UIViewController, EditProfileDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var bioLabel: UILabel?
    @IBOutlet private weak var emailLabel: UILabel?
    @IBOutlet private weak var phoneLabel: UILabel?
    @IBOutlet private weak var editButton: UIButton?
    
    // MARK: - Properties
    private var profile: ProfileModel = ProfileModel(
        name: "Nome do Usuário",
        bio: "Sua bio aqui",
        email: "email@exemplo.com",
        phone: "(00) 00000-0000"
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Perfil"
        
        // Configure labels
        [nameLabel, bioLabel, emailLabel, phoneLabel].forEach { label in
            label?.font = .systemFont(ofSize: 16)
            label?.textColor = .label
            label?.numberOfLines = 0
        }
        
        // Configure edit button
        editButton?.layer.cornerRadius = 8
        editButton?.backgroundColor = .systemBlue
        editButton?.setTitleColor(.white, for: .normal)
        editButton?.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        updateLabels()
    }
    
    private func updateLabels() {
        nameLabel?.text = "Nome: \(profile.name)"
        bioLabel?.text = "Bio: \(profile.bio)"
        emailLabel?.text = "Email: \(profile.email)"
        phoneLabel?.text = "Telefone: \(profile.phone)"
    }
    
    // MARK: - Actions
    @IBAction private func editButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "EditProfileSegue", sender: nil)
    }
    
    @IBAction func handleLogoff(_ sender: Any) {
        // Remove the logged flag from the store
        StoreManager.shared.remove(forKey: "logged")
        
        // Dismiss the current view controller to return to the login screen
        dismiss(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditProfileSegue" {
            if let editVC = segue.destination as? EditProfileViewController {
                editVC.profile = profile
                editVC.delegate = self
            }
        }
    }
    
    // MARK: - EditProfileDelegate
    func didUpdateProfile(_ profile: ProfileModel) {
        self.profile = profile
        updateLabels()
    }
}

