import UIKit

class PostDetailViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalhes"
        setupUI()
    }
    
    private func setupUI() {
        guard let post = post else { return }

        // ImageView da imagem da postagem
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if let imageName = post.imageName {
            imageView.image = UIImage(named: imageName)
        } else {
            imageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        // Título
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = post.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        // Conteúdo
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.text = post.content
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textAlignment = .justified
        contentLabel.numberOfLines = 0
        
        // Data
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = dateFormatter.string(from: post.date)
        dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
        dateLabel.textColor = .secondaryLabel
        
        // Stack View para organizar os elementos
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, contentLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: post.imageName != nil ? 200 : 0)
        ])
    }
} 