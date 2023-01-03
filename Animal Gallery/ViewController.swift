//
//  ViewController.swift
//  Animal Gallery
//
//  Created by new on 3/1/23.
//

import UIKit

class ViewController: UIViewController {
    
    let gallery = [#imageLiteral(resourceName: "dune.jpeg"), #imageLiteral(resourceName: "heroImage.jpeg"), #imageLiteral(resourceName: "image0.jpg"), #imageLiteral(resourceName: "image1.jpg" ), #imageLiteral(resourceName: "image6.jpg"), #imageLiteral(resourceName: "image3.jpg"), #imageLiteral(resourceName: "image5.jpg"), #imageLiteral(resourceName: "image2")]

    @IBOutlet weak var trashImageView: UIImageView!
    
    var nextIndex = 0
    var currentPicture: UIImageView?
    let originalSize:CGFloat = 300
    var isActive = false
    var activeSize: CGFloat {
        return originalSize + 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showNextPicture()
    }
    
    func showNextPicture() {
        if let newPicture = createPicture(){
            currentPicture = newPicture
            showPicture(newPicture)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            newPicture.addGestureRecognizer(tap)
            
        } else {
            nextIndex = 0
            showNextPicture()
        }
    }
    
    @objc func handleTap() {
        isActive = !isActive
        
        if isActive {
            activateCurrentPicture()
        } else {
            deactivateCurrentPicture()
        }
    }
    
    func activateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.activeSize, height: self.activeSize)
            self.currentPicture?.layer.shadowOpacity = 0.5
            self.currentPicture?.layer.borderColor = UIColor.green.cgColor
        }
        
    }
    
    func deactivateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.originalSize, height: self.originalSize)
            self.currentPicture?.layer.shadowOpacity = 0
            self.currentPicture?.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    

    func createPicture() -> UIImageView? {
        guard nextIndex < gallery.count else { return nil }
        let imageView = UIImageView(image: gallery[nextIndex])
        imageView.frame = CGRect(x: self.view.frame.width, y: self.view.center.y - (originalSize / 2), width: originalSize, height: originalSize)
        imageView.isUserInteractionEnabled = true
        
//        Shadow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 10
        
//        Frame
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        nextIndex += 1
        return imageView
    }
    
    func showPicture(_ imageView: UIImageView) {
        self.view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.4) {
            imageView.center = self.view.center
        }
    }
    
}

