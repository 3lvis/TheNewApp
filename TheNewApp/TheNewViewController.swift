import UIKit
import AVFoundation
import CoreGraphics

class TheNewViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var player: AVAudioPlayer?

    lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "fingers")!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    lazy var shineImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "shine")!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    lazy var makeNewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.setTitle("Make it new!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(self.makeNewAgain), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(shineImageView)
        view.addSubview(makeNewButton)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            shineImageView.topAnchor.constraint(equalTo: view.topAnchor),
            shineImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shineImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shineImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            makeNewButton.widthAnchor.constraint(equalToConstant: 240),
            makeNewButton.heightAnchor.constraint(equalToConstant: 50),
            makeNewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            makeNewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        makeOld()
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
        UIView.animate(withDuration: 2, animations: {
            self.imageView.alpha = 0
            self.shineImageView.alpha = 1
            self.makeNewButton.alpha = 0
        }) { (_) in
            self.shineImageView.alpha = 0
            self.makeOld()
        }
    }

    @objc func makeNewAgain() {
        let alert = UIAlertController(title: "Don’t lag behind!", message: "Make the app new again for the net new price of 10$.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No, I’ll stay lame", style: .destructive, handler: nil)
        let yesAction = UIAlertAction(title: "Yes, now!", style: .default) { _ in
            self.makeNew()
            self.playSound()
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        alert.preferredAction = yesAction
        present(alert, animated: true, completion: nil)
    }

    func playSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            let soundFilename = "chime"
            let url = Bundle.main.url(forResource: soundFilename, withExtension: "mp3")!
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        } catch let error as NSError {
            let controller = UIAlertController(title: NSLocalizedString("Oops, something went wrong", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
}
