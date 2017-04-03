import Foundation
import UIKit
import SpriteKit
import PlaygroundSupport



public class GameVC: UIViewController {
    
    var sceneView = SKView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    public override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for subView in self.view.subviews as [UIView] {
            subView.removeFromSuperview()
            //print("removing")
        }
        
        //print("inside")
        self.view.willRemoveSubview(sceneView)
        sceneView = SKView(frame: CGRect(x:0 , y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        let scene = GameScene()
        scene.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        sceneView.showsFPS = false
        sceneView.presentScene(scene)
        
        self.view.addSubview(sceneView)
        
    }
}

