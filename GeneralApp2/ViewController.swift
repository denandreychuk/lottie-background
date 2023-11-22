import UIKit
import AVFoundation
import Lottie

class ViewController: UIViewController {
    
    private let player = AVQueuePlayer()
    
    private var timer: Timer?
    
    private lazy var animationView = {
        let view = LottieAnimationView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            print("Running...")
        })
        
        player.replaceCurrentItem(with: AVPlayerItem(url: Bundle.main.url(forResource: "sample", withExtension: "mp3")!))
        player.play()
        
        view.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        animationView.animation = .named("test")
        playAnimation()
    }
    
    private func playAnimation() {
        self.animationView.play { completed in
            print("Animation completed: \(completed)")
            self.playAnimation()
        }
    }
}
