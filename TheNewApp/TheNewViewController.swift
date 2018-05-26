import UIKit

class TheNewViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "old")!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    lazy var makeNewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.setTitle("Make it new!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(self.makeNewAgain), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNewButton.alpha = 1

        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(makeNewButton)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            makeNewButton.widthAnchor.constraint(equalToConstant: 240),
            makeNewButton.heightAnchor.constraint(equalToConstant: 50),
            makeNewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            makeNewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //makeOld()
    }

    func makeOld() {
        UIView.animate(withDuration: 7, animations: {
            self.imageView.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
            self.makeNewButton.alpha = 1
            })
        }
    }

    func makeNew() {
        UIView.animate(withDuration: 3, animations: {
            self.imageView.alpha = 0
            self.makeNewButton.alpha = 0
        }) { (_) in
            self.makeOld()
        }
    }

    @objc func makeNewAgain() {
        let alert = UIAlertController(title: "Are you sure?", message: "Being on top of things has a price so making it new has a price too. Make it new for just 10$!", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes!", style: .default) { _ in
            self.makeNew()
        }
        let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        alert.preferredAction = yesAction
        present(alert, animated: true, completion: nil)
    }
}
