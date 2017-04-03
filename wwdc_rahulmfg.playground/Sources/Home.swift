import Foundation
import UIKit
import AVFoundation

public class MasterVC: UIViewController {
    
    
    /*          Variables       */
    
    var label = UILabel()
    var sublabel = UILabel()
    var playBtn = UIButton()
    var synthesizer = AVSpeechSynthesizer()
    var soundPlayer = AVAudioPlayer()
    
    
    
    
    
    /*          Functions       */
    
    func startGame () {
        
        self.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        
        let path = Bundle.main.path(forResource: "btnclick", ofType: "wav")
        let appearSound = URL(fileURLWithPath: path!)
        
        do {
            try soundPlayer = AVAudioPlayer(contentsOf: appearSound)
            soundPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
        soundPlayer.play()
        //
        let game = GameVC()
        game.modalPresentationStyle = .custom
        game.modalTransitionStyle = .crossDissolve
        self.present(game, animated: true, completion: nil)
        
    }
    
    
    func intro () {
        
        // play sound
        let path = Bundle.main.path(forResource: "btnclick", ofType: "wav")
        let appearSound = URL(fileURLWithPath: path!)
        
        do {
            try soundPlayer = AVAudioPlayer(contentsOf: appearSound)
            soundPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
        soundPlayer.play()
        
        //      Clear Fields
        self.label.removeFromSuperview()
        self.sublabel.removeFromSuperview()
        self.playBtn.removeFromSuperview()
        
        // Load Modal
        let paddingTop = 0.1 * self.view.frame.height
        
        let popOut = UIView(frame: CGRect(x: 0, y: paddingTop, width: self.view.frame.width, height: self.view.frame.height - paddingTop + 20))
        
        popOut.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popOut.layer.cornerRadius = 20
        
        let targetPos = popOut.center
        
        popOut.center = CGPoint(x: self.view.frame.midX, y: popOut.frame.height * 2)
        
        
        //  Add Elements
        let img = UIImageView(image: UIImage(named: "frame1.png"))
        img.center = CGPoint(x: popOut.frame.midX, y: img.frame.size.height/2 + 30)
        
        let lab1 = UILabel()
        lab1.text = "Welcome"
        lab1.font = UIFont(name: "Avenir-Medium", size: 28)
        lab1.sizeToFit()
        lab1.textAlignment = .center
        lab1.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lab1.center = CGPoint(x: popOut.frame.midX, y: paddingTop/2)
        
        let lab_desc = UILabel()
        lab_desc.textColor =  #colorLiteral(red: 0.1721832645, green: 0.1801395169, blue: 0.1741583528, alpha: 1)
        lab_desc.text = "Meet Rahul, a wild pokemon which wants to get a WWDC scholarship this year. It has built few iOS apps & found a security bug in an Apple product. Try to catch it by throwing the pokeball on it and know more."
        
        let utterance = AVSpeechUtterance(string: "Welcome, \(lab_desc.text!)")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        //utterance.rate = 0.1
        
        
        
        
        lab_desc.textAlignment = .justified
        lab_desc.numberOfLines = 6
        lab_desc.frame.size.width = popOut.frame.size.width - (popOut.frame.size.width * 0.1)
        lab_desc.sizeToFit()
        lab_desc.center = CGPoint(x: popOut.frame.midX, y: img.frame.height + lab_desc.frame.size.height/2 + 70)
        lab_desc.alpha = 0
        
        let play = UIButton()
        play.setTitle("👉 Catch'em 👈", for: .normal)
        play.setTitleColor(#colorLiteral(red: 0.1721832645, green: 0.1801395169, blue: 0.1741583528, alpha: 1), for: .normal)
        play.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22)
        play.titleLabel?.textAlignment = .center
        play.addTarget(self, action: #selector(MasterVC.startGame), for: .touchUpInside)
        play.sizeToFit()
        play.center = CGPoint(x: popOut.frame.midX, y: popOut.frame.size.height - 120)
        play.alpha = 0
        
        
        // Add View
        self.view.addSubview(popOut)
        self.view.addSubview(lab1)
        
        popOut.addSubview(img)
        popOut.addSubview(lab_desc)
        popOut.addSubview(play)
        
        // Animations
        
        UIView.animate(withDuration: 0.43, animations: {
            popOut.center = targetPos
        }, completion: {
            (finished: Bool) in
            
            UIView.animate(withDuration: 0.5, animations: {
                lab_desc.alpha = 1
            }, completion: { (finished: Bool) in
                self.synthesizer.speak(utterance)
                UIView.animate(withDuration: 0.5, animations: {
                    play.alpha = 1
                })
            })
            
        })
        
        
    }
    
    /*          View Methods    */
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        label.text = "WWDC'17"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Avenir-Heavy", size: 35)
        label.textAlignment = .center
        
        sublabel.text = "Scholarship 🏆"
        sublabel.font = UIFont(name: "Avenir-Medium", size: 22)
        sublabel.textAlignment = .center
        sublabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sublabel.alpha = 0
        
        playBtn.setTitle("Get Started", for: .normal)
        playBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        playBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22)
        playBtn.titleLabel?.textAlignment = .center
        playBtn.addTarget(self, action: #selector(MasterVC.intro), for: .touchUpInside)
        
        
        self.view.addSubview(label)
        self.view.addSubview(sublabel)
        self.view.addSubview(playBtn)
        
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let w = self.view.frame.size.width
        let h = self.view.frame.size.height
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back.jpg")!)
        
        let backgroundImageView = UIImageView(image: UIImage(named: "back.jpg"))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        
        
        let cover = UIView(frame: view.frame)
        cover.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cover.layer.opacity = 0.55
        
        backgroundImageView.addSubview(cover)
        
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
        
        label.center = CGPoint(x: w/2, y: h/2)
        label.sizeToFit()
        
        sublabel.center = CGPoint(x: w/2, y: 150 + label.frame.size.height/2 + 22)
        sublabel.sizeToFit()
        
        playBtn.center = CGPoint(x: w/2, y: h - 100)
        playBtn.sizeToFit()
        playBtn.alpha = 0
        
    }

    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let path = Bundle.main.path(forResource: "appear", ofType: "mp3")
        let appearSound = URL(fileURLWithPath: path!)
        
        do {
           try soundPlayer = AVAudioPlayer(contentsOf: appearSound)
            soundPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
        UIView.animate(withDuration: 0.9, animations: {
            
            self.label.center.y = 150
            self.soundPlayer.play()
            
        }, completion: { (finished: Bool) in
            
            UIView.animate(withDuration: 0.9, animations: {
                self.sublabel.alpha = 1
                
            }, completion: { (finished: Bool) in
                
                UIView.animate(withDuration: 0.6, animations: {
                    self.playBtn.alpha = 1
                })
            })
        })
        
        
    }
}
