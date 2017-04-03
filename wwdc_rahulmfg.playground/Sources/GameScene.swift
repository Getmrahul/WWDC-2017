import UIKit
import SpriteKit
import AVFoundation

extension SKSpriteNode {
    
    func aspectFillToSize(fillSize: CGSize) {
        
        if texture != nil {
            self.size = texture!.size()
            
            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width /  self.texture!.size().width
            
            let scaleRatio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio
            
            self.setScale(scaleRatio)
        }
    }
    
}

public class GameScene: SKScene {
    
    
    //      Var's
    
    var w: CGFloat = 0.0
    var h: CGFloat = 0.0
    var mainV = UIView()
    let ball = SKSpriteNode(imageNamed: "pokeball.png")
    let man = SKSpriteNode(imageNamed: "frame1.png")
    let boom = SKSpriteNode(imageNamed: "boom_frame1.png")
    let background = SKSpriteNode(imageNamed: "back.jpg")
    var touchMoved = false
    var touchedObj = false
    var synthesizer = AVSpeechSynthesizer()
    var activeTab = SKShapeNode()
    var lab_desc = SKNode()
    var lab_width = CGFloat()
    var lab_pos = CGPoint()
    var AudioPlayer: AVAudioPlayer!
    var themeMusic: SKAudioNode!
    
    //      endVar's
    
    
    //      Functions
    
    func addMultiLabel (remove: Bool, width: CGFloat, position: CGPoint, indexv: Int = 0) {
        let text1 = "Hello, this is Rahul from India. I'm 21 and studying Computer Science & Engineering. Want to be an Entrepreneur. I like to code and build products. So for have built few iOS and web apps. Not just that, I do bug hunting(web security) found security bugs in Apple, Amazon, Facebook, Google, Yahoo, United Airlines, MediaFire and received rewards for the same. So that's it about me. Check out the other tabs for more 👨‍💻"

        let text2 = "My skills are Web Development🕸, iOS App Development📱 & Web Application Security🐞. And in the process of learning more 👼."
        let text3 = "Here are the iOS apps I have built so far. Tagsdock: Hashtag keyboard for Instagram and Jongler: A Juggling Game. Both are available in the App Store."
        let text4 = "Why WWDC? Apple has given me a great opportunity by giving us the chance to build and launch iOS apps. I have earned few 💵💸 while studying with the apps I have built. So can't imagine how awesome it will be when I get into WWDC. Can't wait to be there. Hope you give this pokemon a WWDC Scholarship ticket 😉."
        let data = [text1, text2, text3, text4]
        
        if remove {
            self.lab_desc.removeFromParent()
        }
        
        let modTxt = data[indexv].replacingOccurrences(of: "\n", with: "")
        
        let utterance = AVSpeechUtterance(string: modTxt)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        utterance.rate = 0.42
        
        self.lab_desc = SKMultilineLabel(text: data[indexv], labelWidth: Int(self.lab_width), pos: self.lab_pos, fontName: "Avenir-Medium", fontSize: 18, fontColor: #colorLiteral(red: 0.1721832645, green: 0.1801395169, blue: 0.1741583528, alpha: 1), leading: 22, alignment: .left , shouldShowBorder: false)
        self.lab_desc.alpha = 0
        self.addChild(lab_desc)
        let changeText = SKAction.customAction(withDuration: 0.32, actionBlock: {
            (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.lab_desc.alpha = 1
        })
        
        self.lab_desc.run(changeText)
        //self.synthesizer.speak(utterance) uncomment ME!
        
    }
    
    func toolbar () {
        
        let tb_items = ["about", "skill", "apps", "wwdc"]
        
        let boxSize = self.frame.width/4
        
        var padX = boxSize/2
        
        for item in tb_items {
            let ext = "_n.png"
            
            let texture = SKTexture(imageNamed: item + ext)
            
            let node = SKSpriteNode(texture: texture)
            
            node.name = item
            
            node.size.width = 36//32
            node.size.height = 36
            
            node.position = CGPoint(x: padX, y: node.size.height)
            
            padX += boxSize
            
            self.addChild(node)
            
        }
        
        activeTab = SKShapeNode(rectOf: CGSize(width: boxSize - 10, height: 5))
        activeTab.fillColor = #colorLiteral(red: 0.4237218201, green: 0.8427357674, blue: 0.5671525598, alpha: 1)
        activeTab.position = CGPoint(x: boxSize/2, y: 8)
        self.addChild(activeTab)
        
    }
    
    
    func showRahul() {
        
        self.removeAllActions()
        //self.removeAllChildren()
        themeMusic.run(SKAction.stop())
        let path = Bundle.main.path(forResource: "tab", ofType: "wav")
        let appearSound = URL(fileURLWithPath: path!)
        
        do {
            try AudioPlayer = AVAudioPlayer(contentsOf: appearSound)
            AudioPlayer.setVolume(0.3, fadeDuration: 0)
            AudioPlayer.play()
        } catch {
            print(error)
        }
        
        let background = SKSpriteNode(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), size: CGSize(width: mainV.frame.width, height: mainV.frame.size.height))
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.alpha = 0.55
        
        let paddingTop = 0.1 * self.frame.height
        
        let popOut = SKShapeNode(rect: CGRect(x: 0, y: -20, width: self.frame.width, height: self.frame.height - paddingTop + 20), cornerRadius: 20)
        popOut.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let targetPos = popOut.position
        
        popOut.position = CGPoint(x: targetPos.x, y: 0 - (popOut.frame.height * 2))

        
        
        let moveUp = SKAction.move(to: targetPos, duration: 0.33)
        
        let m1 = SKTexture(imageNamed: "frame1.png")
        let m2 = SKTexture(imageNamed: "frame4.png")
        let m3 = SKTexture(imageNamed: "rahul.png")
        let m4 = SKTexture(imageNamed: "rahul1.png")
        
        man.position = CGPoint(x: self.frame.midX, y: popOut.frame.height - m1.size().height/2 - 50)
        
        
        
        let makeRahulJump = SKAction.animate(with: [m1, m2, m3, m4], timePerFrame: 0.2)
        
        let rahulAction = SKAction.repeatForever(makeRahulJump)
        
        
        let head = SKLabelNode(fontNamed: "Avenir-Medium")
        head.fontSize = 28
        head.text = "Gotcha 🎉"
        head.horizontalAlignmentMode = .center
        head.verticalAlignmentMode = .center
        head.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        head.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (paddingTop/2))
        
        
        
        self.lab_width = popOut.frame.size.width - (popOut.frame.size.width * 0.1)
        self.lab_pos = CGPoint(x: self.frame.midX, y: man.position.y - m1.size().height/2 - 40)
        
        
        self.addChild(background)
        self.addChild(popOut)
        
        
        popOut.run(moveUp, completion: {
            self.addChild(head)
            self.addChild(self.man)
            self.man.run(rahulAction)
            self.addMultiLabel(remove: false, width: self.lab_width, position: self.lab_pos)
            self.toolbar()
        })
        
        
        //GameVC().showDetail()
    }
    
    func captureIt(ballPos: CGPoint, Success: Bool) {
        
        let makeBallSmall = SKAction.customAction(withDuration: 0.5, actionBlock: {
            (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.ball.size = CGSize(width: 30, height: 30)
        })
        
        let ballFall = SKAction.moveTo(y: ballPos.y - 20, duration: 0.3)
        
        let ballDone = SKAction.group([ballFall, makeBallSmall])
        
        if Success {
            self.man.removeAllActions()
            self.man.removeFromParent()
            let b1 = SKTexture(imageNamed: "boom_frame1.png")
            let b2 = SKTexture(imageNamed: "boom_frame2.png")
            let b3 = SKTexture(imageNamed: "boom_frame3.png")
            
            let makeBoom = SKAction.animate(with: [b1, b2, b3], timePerFrame: 0.2)
            
            let boomSpin = SKAction.repeat(makeBoom, count: 2)
            
            
            boom.position = man.position
            
            self.addChild(self.boom)
            let path = Bundle.main.path(forResource: "gotcha", ofType: "wav")
            let appearSound = URL(fileURLWithPath: path!)
            
            do {
                try AudioPlayer = AVAudioPlayer(contentsOf: appearSound)
                AudioPlayer.prepareToPlay()
            } catch {
                print(error)
            }
            
            AudioPlayer.play()
            self.boom.run(boomSpin, completion: {
                self.boom.removeFromParent()
                self.ball.run(ballDone, completion: {
                    //print("it's over")
                    self.showRahul()
                })
            })
        } else {
            AudioPlayer.stop()
            
            
            
            let ballHide = SKAction.customAction(withDuration: 0.2, actionBlock: {
                (node: SKNode!, elapsedTime: CGFloat) -> Void in
                self.ball.alpha = 0
            })
            
            let moveBall = SKAction.move(to: CGPoint(x: self.frame.midX, y: 90), duration: 0)
            
            let ballShow = SKAction.customAction(withDuration: 0.2, actionBlock: {
                (node: SKNode!, elapsedTime: CGFloat) -> Void in
                self.ball.alpha = 1
            })
            
            let sizeInc = SKAction.customAction(withDuration: 0.1, actionBlock: {
                (node: SKNode!, elapsedTime: CGFloat) -> Void in
                self.ball.size.width = 90
                self.ball.size.height = 90
            })
            
            
            
            let ballAction = SKAction.sequence([ballDone, ballHide, moveBall, ballShow, sizeInc])
            
            ball.run(ballAction)
        }
        
    }
    
    func throwBall(to swipeEnd: CGPoint) {
        
        
        //Check for left or right or straight A.K.A LRS
        
        var lrs = ""
        
        let centerX = self.frame.midX
        
        if swipeEnd.x > (centerX + (man.frame.size.width / 4)) {
            lrs = "r"
        } else if swipeEnd.x < (centerX - (man.frame.size.width / 4)) {
            lrs = "l"
        } else {
            lrs = "s"
        }
        
        
        //endLRS_Check
        
        //ThrowSpeed Check
        
        let center_line = (ball.position.y + man.position.y) / 2
        
        var tSpeed = ""
        
        let minpt = ball.position.y + (ball.size.height/2) + 20
        
        if swipeEnd.y < minpt {
            tSpeed = "l"
        } else if swipeEnd.y > center_line + 38 {
            tSpeed = "h"
        } else {
            tSpeed = "c"
        }
        
        /*let startline = SKShapeNode(rect: CGRect(x: 0, y: minpt, width: self.frame.size.width, height: 20))
        startline.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        let endline = SKShapeNode(rect: CGRect(x: 0, y: center_line + 20, width: self.frame.size.width, height: 20 ))
        
        endline.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        self.addChild(startline)
        self.addChild(endline)*/
        
        var destination = CGPoint(x: self.frame.midX, y: self.frame.midY + 85)
        
        var gotIt = true
        //print(tSpeed)
        if tSpeed != "c" || lrs != "s" {
            gotIt = false
            
            // change X & Y of destination
            
            if tSpeed == "l" {
                destination.y = center_line
            } else if tSpeed == "h" {
                destination.y = (man.frame.midY + (man.frame.size.height/2) + 20)
            }
            
            if lrs == "l" {
                destination.x = self.frame.midX/2
            } else if lrs == "r" {
                destination.x = (self.frame.midX + self.frame.width)/2
            }
        }
        
        //endThrowSpeed_Check
        
        
        
        let mov = SKAction.move(to: destination, duration: 0.2)
        //SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY + 90), duration: 0.2)
        let wa = SKAction.wait(forDuration: 0.22)
        let si = SKAction.customAction(withDuration: 1.5, actionBlock: {
            (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.ball.size = CGSize(width: 50, height: 50)
        })
        
        let ballm = SKAction.sequence([wa, si])
        
        let fin = SKAction.group([mov, ballm])
        
        let path = Bundle.main.path(forResource: "throw", ofType: "wav")
        let appearSound = URL(fileURLWithPath: path!)
        
        do {
            try AudioPlayer = AVAudioPlayer(contentsOf: appearSound)
            AudioPlayer.play()
        } catch {
            print(error)
        }
        
        ball.run(fin, completion: {
            self.captureIt(ballPos: self.ball.position, Success: gotIt)
        })
        
        
        
    }
    
    //      endFunctions
    
    public override func didMove(to view: SKView) {
        
        w = view.frame.size.width
        h = view.frame.size.height
        background.aspectFillToSize(fillSize: view.frame.size)
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        let path = Bundle.main.path(forResource: "battle", ofType: "mp3")
        let backg = URL(fileURLWithPath: path!)
         themeMusic = SKAudioNode(url: backg)
         themeMusic.autoplayLooped = true
        /*
        do {
            try AudioPlayer = AVAudioPlayer(contentsOf: appearSound)
            AudioPlayer.setVolume(0.5, fadeDuration: 0)
            AudioPlayer.numberOfLoops = 4
            AudioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        AudioPlayer.play()*/
        
        mainV = view as UIView
        
        man.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 30)
        
        let f1 = SKTexture(imageNamed: "frame1.png")
        
        let f2 = SKTexture(imageNamed: "frame4.png")
        
        let Jump = SKAction.animate(with: [f1, f2], timePerFrame: 0.5)
        
        let makeJump = SKAction.repeatForever(Jump)
        
        man.run(makeJump)
        
        ball.name = "pokeball"
        ball.size.width = 90
        ball.size.height = 90
        ball.position = CGPoint(x: self.frame.midX, y: 90)
        
        self.addChild(background)
        self.addChild(themeMusic)
        themeMusic.run(SKAction.changeVolume(to: 0.3, duration: 0))
        self.addChild(man)
        self.addChild(ball)
        
    
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedObj = false
        for touch in touches {
            
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                
                if name == "pokeball"
                {
                    touchedObj = true
                } else if let indexv = ["about", "skill", "apps", "wwdc"].index(of: name)  {
                    if indexv >= 0 {
                        let colors = [#colorLiteral(red: 0.4237218201, green: 0.8427357674, blue: 0.5671525598, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9942446351, green: 0.9658157229, blue: 0.1925332844, alpha: 1)]
                        
                        let tpos = touchedNode.position.x
                        let action = SKAction.moveTo(x: tpos, duration: 0.25)
                        let action2 = SKAction.customAction(withDuration: 0.32, actionBlock: {
                            (node: SKNode!, elapsedTime: CGFloat) -> Void in
                            self.activeTab.fillColor = colors[indexv]
                            
                        })
                        let soundeffect = SKAction.playSoundFileNamed("tab.wav", waitForCompletion: false)
                        addMultiLabel(remove: true, width: lab_width, position: lab_pos, indexv: indexv)
                        let anim = SKAction.group([action, soundeffect, action2])
                        self.activeTab.run(anim)
                    }
                    
                }
            }
        }
        
        touchMoved = false
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMoved = true
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchMoved && touchedObj{
            var touch = CGPoint(x: 0, y: 0)
            
            for point in touches {
                touch = point.location(in: self)
            }
            
            let min = ball.position.y + (ball.size.height/2) + 5
            
            if touch.y > min {
                throwBall(to: touch)
            }
            
        }
        
    }
}

