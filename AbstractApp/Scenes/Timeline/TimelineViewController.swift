import UIKit

enum LoadingState {
    case loading
    case loaded
    case error
}

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorView = UIView()
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    
    private var posts: [Post] = []
    private var loadingState: LoadingState = .loading
    
    private var firstAttempt = true
    
    // Public method to update posts
    func updatePosts(_ newPosts: [Post]) {
        self.posts = newPosts
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Timeline"
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)

        setupTableView()
        setupLoadingIndicator()
        setupErrorView()
        
        fetchPosts()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.text = "Erro ao carregar a timeline."
        errorLabel.textAlignment = .center
        retryButton.setTitle("Tentar Novamente", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        errorView.addSubview(errorLabel)
        errorView.addSubview(retryButton)
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: errorView.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor)
        ])
        
        errorView.isHidden = true
    }
    
    private func fetchPosts() {
        setLoadingState(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Simula erro na primeira tentativa e pede para recarregar
            if self.firstAttempt {
                self.firstAttempt = false
                self.setLoadingState(.error)
                return
            }
            
            // Dados dos posts
            self.posts = [

                Post(title: "O Despertar do Cavaleiro",
                         content: "O Cavaleiro emerge de um sono profundo, sem memórias claras, em um reino quebrado e silencioso: Hallownest. Apesar de sua aparência frágil, ele carrega em si uma força ancestral, traços do Vazio e um destino conectado diretamente ao futuro do reino. Conforme explora cavernas, cidades soterradas e sonhos fragmentados, o Cavaleiro enfrenta horrores antigos e descobre segredos do reino e de seu nascimento.",
                         date: Date(),
                         imageName: "Knight"),
                    
                Post(title: "O Fardo do Hollow Knight",
                         content: "Criado como um receptáculo puro e sem mente para conter a infecção que se alastrava pelo reino, o Hollow Knight é o trágico herói de Hallownest. Escolhido pelo Rei Pálido, ele foi treinado e aprisionado em um ritual que visava selar a Radiância. Com o tempo, no entanto, emoções reprimidas começaram a emergir, enfraquecendo seu selo e liberando novamente a Corrupção. Sua história é marcada por dor, dever e solidão.",
                         date: Date(),
                         imageName: "Hollow Knight"),
                    
                Post(title: "Cloth e Sua Última Dança",
                         content: "Vinda de uma terra distante, Cloth viaja até Hallownest em busca de glória e propósito. Apesar de seu comportamento tímido e desajeitado, ela abriga uma coragem crescente. Sua jornada culmina em um ato de bravura no Reino Submerso, onde ela enfrenta o temido Traitor Lord ao lado do Cavaleiro. Cloth dança sua última dança com honra, tornando-se uma lenda silenciosa entre os destemidos.",
                         date: Date(),
                         imageName: "Cloth"),
                    
                Post(title: "A Canção Inocente de Myla",
                         content: "Myla é uma escavadora alegre que canta enquanto trabalha, alheia ao horror que lentamente consome Hallownest. Sua música doce ecoa nas minas infectadas, representando a esperança e a inocência em um mundo mergulhado no desespero. Mas mesmo a luz mais pura pode ser corrompida — e o destino de Myla é um lembrete melancólico da tragédia que se abateu sobre o reino.",
                         date: Date(),
                         imageName: "Myla"),
                    
                Post(title: "Bretta e os Sonhos Românticos",
                         content: "Bretta é uma jovem que vive isolada, nutrindo fantasias idealizadas de romance e heroísmo. Após ser resgatada pelo Cavaleiro, ela desenvolve uma paixão intensa por ele, apenas para depois transferir sua devoção para o egocêntrico Zote, influenciada pelas peças de teatro sobre sua grandeza. Bretta personifica o escapismo romântico e o poder dos sonhos, mesmo os mais ilusórios.",
                         date: Date(),
                         imageName: "Bretta"),
                    
                Post(title: "Hornet, Guardiã da Agulha",
                         content: "Ágil, feroz e envolta em mistério, Hornet é a filha do Rei Pálido com Herrah, a Besta. Como protetora do Reino Profundo, ela vigia os caminhos que levam ao Coração de Hallownest. Seus confrontos com o Cavaleiro são testes, não apenas de força, mas de propósito. Determinada a evitar os erros do passado, Hornet caminha entre destino e escolha, preparando-se para seu próprio papel no renascimento ou destruição do reino.",
                         date: Date(),
                         imageName: "Hornet"),
                    
                Post(title: "O Silêncio de Menderbug",
                         content: "Menderbug é um zelador tímido que vive nas sombras, reparando placas e pontes sem jamais desejar ser notado. Suas ações são quase invisíveis, mas essenciais para manter a frágil estrutura do reino. Um diário escondido revela um ser sensível e dedicado, que mesmo diante do caos, mantém sua missão de restaurar Hallownest. Um símbolo de humildade e persistência.",
                         date: Date(),
                         imageName: "Menderbug"),
                    
                Post(title: "O Ferreiro de Pregos",
                         content: "O ferreiro é um artesão consumido pela busca da perfeição. Dedicou sua vida a forjar pregos, as lâminas dos guerreiros de Hallownest, e sonha criar a obra-prima definitiva. Porém, essa obsessão o leva a um limite perigoso, onde a arte se mistura com autodestruição. Sua história é um retrato da tensão entre criação e sacrifício.",
                         date: Date(),
                         imageName: "Nailsmith"),
                    
                Post(title: "Buscador de Relíquias",
                         content: "Lemm é um estudioso solitário que coleta artefatos do passado, tentando reconstruir a história de Hallownest através de fragmentos esquecidos. Ele despreza a superstição, preferindo a lógica e o valor histórico dos itens antigos. Em meio às ruínas, Lemm mantém viva a chama da memória, ainda que o mundo tenha esquecido quase tudo.",
                         date: Date(),
                         imageName: "Relic_Seeker"),
                    
                Post(title: "A Sabedoria da Seer",
                         content: "Líder do povo das Mariposas, a Vidente vive reclusa no Sonho, guiando almas perdidas e oferecendo visões a quem coleta Essência. Ela é a última de sua linhagem e carrega uma profunda tristeza pelo que foi perdido. Através dela, o Cavaleiro acessa lembranças há muito enterradas e confronta as forças que ainda assombram o reino. Sua sabedoria conecta o mundo físico ao espiritual.",
                         date: Date(),
                         imageName: "Seer"),
                    
                Post(title: "Sly, o Mestre das Agulhas",
                         content: "Escondido atrás da fachada de um simples mercador, Sly é na verdade um dos Mestre da arte da espada. Seu passado como guerreiro é revelado apenas aos dignos, e sua habilidade com armas é lendária. Ao reencontrar seu propósito, Sly ressurge como mentor e comerciante de técnicas de batalha, oferecendo poder àqueles que buscam proteger o reino.",
                         date: Date(),
                         imageName: "Sly"),
                    
                Post(title: "As Muitas Histórias de Zote",
                         content: "Zote é um viajante arrogante que se autoproclama um herói invencível, portando sua arma Findadora de Vidas. Suas falas são repletas de autoelogios, mas suas ações frequentemente resultam em desastre. Apesar de sua fraqueza, Zote é central em diversas interações cômicas e até oníricas, onde suas versões multiplicadas representam o delírio de sua autoestima. Zote é a paródia do herói, mas com uma estranha persistência admirável.",
                         date: Date(),
                         imageName: "Zote")
            ]
            
            self.setLoadingState(.loaded)
        }
    }
    
    func setLoadingState(_ state: LoadingState) {
        loadingState = state
        
        loadingIndicator.stopAnimating()
        errorView.isHidden = true
        tableView.isHidden = true
        
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
        case .loaded:
            tableView.reloadData()
            tableView.isHidden = false
        case .error:
            errorView.isHidden = false
        }
    }
    
    @objc private func retryTapped() {
        fetchPosts()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row]
        let detailVC = PostDetailViewController()
        detailVC.post = selectedPost
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
}

