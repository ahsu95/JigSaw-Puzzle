//
//  ViewController.swift
//  JigsawPuzzle
//
//  Created by hsu on 10/21/17.
//  Copyright © 2017 Andrew Hsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate{

    //conenctions for the storyboard
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var leftRocket: UIImageView!
    @IBOutlet var rightRocket: UIImageView!
    @IBOutlet var winLabel: UIImageView!
    
    //puzzle image vars
    //shall be created in in the viewDidLoac() instead of in the storyboard
    var puzzleimage1 : UIImageView!
    var puzzleimage2 : UIImageView!
    var puzzleimage3 : UIImageView!
    var puzzleimage4 : UIImageView!
    var puzzleimage5 : UIImageView!
    var puzzleimage6 : UIImageView!
    var puzzleimage7 : UIImageView!
    var puzzleimage8 : UIImageView!
    var puzzleimage9 : UIImageView!
    var puzzleimage10 : UIImageView!
    var puzzleimage11 : UIImageView!
    var puzzleimage12 : UIImageView!
    var counter: Int = 0
    
    //vals that are used to check if the puzzle piece are in place
    var val1 : CGFloat = 0.0
    var val2 : CGFloat = 0.0
    var val3 : CGFloat = 0.0
    var val4 : CGFloat = 0.0
    var val5 : CGFloat = 0.0
    var val6 : CGFloat = 0.0
    var val7 : CGFloat = 0.0
    var val8 : CGFloat = 0.0
    var val9 : CGFloat = 0.0
    var val10 : CGFloat = 0.0
    var val11 : CGFloat = 0.0
    var val12 : CGFloat = 0.0
    var newTranslation : CGPoint = CGPoint(x: 0.0, y: 0.0)
    let clickAsset = NSDataAsset(name: "clickSound")
    let applaudAsset = NSDataAsset(name: "applaudSound")
    var player : AVAudioPlayer?
    var imageArray : [UIImage] = []
    
    var puzzleData = [String]()
    var dict_piecesData = [String: AnyObject]()
    var timer = Timer()
    var timeCount = 0.0
    var isRunning = false
    
    
    /*
     A geometric translation moves every point of our UIImageView object by the same amount
     in a given direction when it is panned (dragged) from one location to another.
     We store the (x, y) coordinates of the last translation of imageViewj into an
     instance variable lastTranslationj, where j=1,2,3,4
     
     CGPoint is a structure that contains the (x, y) coordinate values.
     */
    
    var lastTranslation1 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation2 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation3 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation4 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation5 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation6 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation7 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation8 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation9 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation10 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation11 = CGPoint(x: 0.0, y: 0.0)
    var lastTranslation12 = CGPoint(x: 0.0, y: 0.0)


    @IBOutlet var puzzleImage: UIImageView!
    @IBOutlet var backgroundRect: UIImageView!
    @IBOutlet var newGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawRectangle()
        //self.rightRocket.center.x = 0
        self.rightRocket.center.y = 600
        self.leftRocket.center.y = 600
        
        timeLabel.text = "Timer: 00:00:00"
        //topLabel.text = ""
        self.bottomLabel.isHidden = true
        self.leftRocket.isHidden = true
//        UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [.repeat ],
//                       animations: ({ self.rightRocket.center.y = self.view.frame.height / 4}), completion: nil)
        self.rightRocket.isHidden = true
 
        self.winLabel.isHidden = true
        puzzleimage1 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage2 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage3 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage4 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage5 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage6 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage7 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage8 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage9 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage10 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage11 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        puzzleimage12 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        
        var piecesFileArray: NSDictionary?
    
        
        if let filePath = Bundle.main.path(forResource: "puzzlePieceCenterCoordinates", ofType: "plist") {
             piecesFileArray = NSDictionary(contentsOfFile: filePath)
        }
        
        if let piecesPlistFile = piecesFileArray {
            
            // Typecast the created dictionary of type NSDictionary as Dictionary type
            // and assign it to the class property
            dict_piecesData = piecesPlistFile as! Dictionary
            //print(dict_piecesData)
            //print(dict_piecesData["puzzleImage1"]!)
            
            /*
             allKeys returns a new array containing the dictionary’s keys as of type AnyObject.
             Therefore, typecast the AnyObject type keys to be of type String.
             The keys in the array are *unordered*; therefore, they need to be sorted.
             */
            puzzleData = piecesPlistFile.allKeys as! [String]
            //print(puzzleData)
            
        }
        else
        {
            print("Can't find puzzlePieceCenterCoordinates.plist")
        }
    }

    /*
     * New game function tapped
     */
    @IBAction func newGameTapped(_ sender: UIButton) {
        
        /*
         *Initial setup of new game screen
         */
        timeCount = 0.0
        puzzleImage.image = nil
        self.topLabel.isHidden = true
        self.bottomLabel.isHidden = true
        self.leftRocket.isHidden = true
        self.rightRocket.isHidden = true
        self.winLabel.isHidden = true
        newTranslation = CGPoint(x: 0.0, y:0.0)
        
        
        if !isRunning{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }
        isRunning = true

        

        // Do any additional setup after loading the view, typically from a nib.
        /*
         The canvas rectangle consists of a grid with 4 columns and 3 rows.
         Divide the canvas width by 4 to determine the width of the UIImageView to show a puzzle piece.
         Divide the canvas height by 3 to determine the height of the UIImageView to show a puzzle piece.
         Set the Content Mode to center.
         */
        
        //puzzleimage1 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 603 / 4, height: 453 / 3))
        val1 = 0.0
//        lastTranslation1.x = 0.0
//        lastTranslation1.y = 0.0
        puzzleimage1.center.x = CGFloat(100 + arc4random_uniform(200))
        puzzleimage1.center.y = CGFloat(100 + arc4random_uniform(200))
        puzzleimage1.image = UIImage(named: "puzzleImage1.png")
        puzzleimage1.contentMode = UIViewContentMode.center
        puzzleimage1.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage1)
        //------------------------------ Image View 1 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 1
        let panRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning1(_:)))
        
        // Add Panning (Dragging) Gesture Recognizer to Image View 1
        puzzleimage1.addGestureRecognizer(panRecognizer1)
        
        val2 = 0.0
//        lastTranslation2.x = 0.0
//        lastTranslation2.y = 0.0
        puzzleimage2.center.x = CGFloat(200	 + arc4random_uniform(500))
        puzzleimage2.center.y = CGFloat(200 + arc4random_uniform(500))
        puzzleimage2.image = UIImage(named: "puzzleImage2.png")
        puzzleimage2.contentMode = UIViewContentMode.center
        puzzleimage2.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage2)
        //------------------------------ Image View 2 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 2
        let panRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning2(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 2
        puzzleimage2.addGestureRecognizer(panRecognizer2)

        val3 = 0.0
//        lastTranslation3.x = 0.0
//        lastTranslation3.y = 0.0
        puzzleimage3.center.x = CGFloat(100 + arc4random_uniform(200))
        puzzleimage3.center.y = CGFloat(100 + arc4random_uniform(500))
        puzzleimage3.image = UIImage(named: "puzzleImage3.png")
        puzzleimage3.contentMode = UIViewContentMode.center
        puzzleimage3.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage3)
        //------------------------------ Image View 3 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 3
        let panRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning3(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 3
        puzzleimage3.addGestureRecognizer(panRecognizer3)
        
        val4 = 0.0
//        lastTranslation4.x = 0.0
//        lastTranslation4.y = 0.0
        puzzleimage4.center.x = CGFloat(100 + arc4random_uniform(400))
        puzzleimage4.center.y = CGFloat(100 + arc4random_uniform(500))
        puzzleimage4.image = UIImage(named: "puzzleImage4.png")
        puzzleimage4.contentMode = UIViewContentMode.center
        puzzleimage4.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage4)
        //------------------------------ Image View 3 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 4
        let panRecognizer4 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning4(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 4
        puzzleimage4.addGestureRecognizer(panRecognizer4)
        
        val5 = 0.0
//        lastTranslation5.x = 0.0
//        lastTranslation5.y = 0.0
        puzzleimage5.center.x = CGFloat(400 + arc4random_uniform(400))
        puzzleimage5.center.y = CGFloat(400 + arc4random_uniform(300))
        puzzleimage5.image = UIImage(named: "puzzleImage5.png")
        puzzleimage5.contentMode = UIViewContentMode.center
        puzzleimage5.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage5)
        //------------------------------ Image View 5 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 5
        let panRecognizer5 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning5(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 5
        puzzleimage5.addGestureRecognizer(panRecognizer5)

        val6 = 0.0
//        lastTranslation6.x = 0.0
//        lastTranslation6.y = 0.0
        puzzleimage6.center.x = CGFloat(100 + arc4random_uniform(400))
        puzzleimage6.center.y = CGFloat(200 + arc4random_uniform(400))
        puzzleimage6.image = UIImage(named: "puzzleImage6.png")
        puzzleimage6.contentMode = UIViewContentMode.center
        puzzleimage6.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage6)
        //------------------------------ Image View 6 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 6
        let panRecognizer6 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning6(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 6
        puzzleimage6.addGestureRecognizer(panRecognizer6)

        val7 = 0.0
//        lastTranslation7.x = 0.0
//        lastTranslation7.y = 0.0
        puzzleimage7.center.x = CGFloat(500 + arc4random_uniform(200))
        puzzleimage7.center.y = CGFloat(300 + arc4random_uniform(200))
        puzzleimage7.image = UIImage(named: "puzzleImage7.png")
        puzzleimage7.contentMode = UIViewContentMode.center
        puzzleimage7.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage7)
        //------------------------------ Image View 7 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 7
        let panRecognizer7 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning7(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 7
        puzzleimage7.addGestureRecognizer(panRecognizer7)

        val8 = 0.0
//        lastTranslation8.x = 0.0
//        lastTranslation8.y = 0.0
        puzzleimage8.center.x = CGFloat(500 + arc4random_uniform(500))
        puzzleimage8.center.y = CGFloat(500 + arc4random_uniform(500))
        puzzleimage8.image = UIImage(named: "puzzleImage8.png")
        puzzleimage8.contentMode = UIViewContentMode.center
        puzzleimage8.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage8)
        //------------------------------ Image View 8 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 8
        let panRecognizer8 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning8(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 8
        puzzleimage8.addGestureRecognizer(panRecognizer8)

        val9 = 0.0
//        lastTranslation9.x = 0.0
//        lastTranslation9.y = 0.0
        puzzleimage9.center.x = CGFloat(300 + arc4random_uniform(500))
        puzzleimage9.center.y = CGFloat(300 + arc4random_uniform(500))
        puzzleimage9.image = UIImage(named: "puzzleImage9.png")
        puzzleimage9.contentMode = UIViewContentMode.center
        puzzleimage9.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage9)
        //------------------------------ Image View 9 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 9
        let panRecognizer9 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning9(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 9
        puzzleimage9.addGestureRecognizer(panRecognizer9)

        val10 = 0.0
//        lastTranslation10.x = 0.0
//        lastTranslation10.y = 0.0
        puzzleimage10.center.x = CGFloat(100 + arc4random_uniform(400))
        puzzleimage10.center.y = CGFloat(100 + arc4random_uniform(400))
        puzzleimage10.image = UIImage(named: "puzzleImage10.png")
        puzzleimage10.contentMode = UIViewContentMode.center
        puzzleimage10.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage10)
        //------------------------------ Image View 10 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 10
        let panRecognizer10 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning10(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 10
        puzzleimage10.addGestureRecognizer(panRecognizer10)
//
        val11 = 0.0
//        lastTranslation11.x = 0.0
//        lastTranslation11.y = 0.0
        puzzleimage11.center.x = CGFloat(100 + arc4random_uniform(500))
        puzzleimage11.center.y = CGFloat(100 + arc4random_uniform(500))
        puzzleimage11.image = UIImage(named: "puzzleImage11.png")
        puzzleimage11.contentMode = UIViewContentMode.center
        puzzleimage11.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage11)
        //------------------------------ Image View 11 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 11
        let panRecognizer11 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning11(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 11
        puzzleimage11.addGestureRecognizer(panRecognizer11)
//
        val12 = 0.0
//        lastTranslation12.x = 0.0
//        lastTranslation12.y = 0.0
        puzzleimage12.center.x = CGFloat(100 + arc4random_uniform(500))
        puzzleimage12.center.y = CGFloat(100 + arc4random_uniform(500))
        puzzleimage12.image = UIImage(named: "puzzleImage12.png")
        puzzleimage12.contentMode = UIViewContentMode.center
        puzzleimage12.isUserInteractionEnabled = true
        self.view.addSubview(puzzleimage12)
        //------------------------------ Image View 12 --------------------------------------
        // Create Panning (Dragging) Gesture Recognizer for Image View 12
        let panRecognizer12 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanning12(_:)))

        // Add Panning (Dragging) Gesture Recognizer to Image View 12
        puzzleimage12.addGestureRecognizer(panRecognizer12)
 
    }
    
    @objc func updateTimer(){
        timeCount += 1
        //let hours = Int(timeCount)/3600
        //let minutes = Int(timeCount) / 60 % 60
        //let seconds = Int(timeCount) % 60
        //timeLabel.text = String(format: "%0:%0:%0:%0.1f", timeCount)
        timeLabel.text = timeString(time: TimeInterval(timeCount))
        
    }
    
    func timeString(time:TimeInterval) -> String {
       // let ms = Int(timeCount) % 1 * 1000
        let hours = Int(timeCount)/3600
        let minutes = Int(timeCount) / 60 /*% 60*/
        let seconds = Int(timeCount) /*% 60*/
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
//    func playSound(nameOfAudioFile: String){
//        var audioPlayer: AVAudioPlayer?
//        if let sound = NSDataAsset(name: nameOfAudioFile){
//            do{
//                try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//                try! AVAudioSession.sharedInstance().setActive(true)
//                try audioPlayer = AVAudioPlayer(data: sound.data, fileTypeHint: ".wav")
//                audioPlayer!.play()
//            } catch {
//                print("error initializing AVAudioPlayer")
//            }
//        }
//    }
    
    /*
     -------------------------------------------
     MARK: - Panning (Dragging) Handling Methods
     -------------------------------------------
     */
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 1  *
     ********************************************************/
    @objc func handlePanning1(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage1"] as! [Int]
        newTranslation = recognizer.translation(in: puzzleimage1)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation1.x + newTranslation.x, y: lastTranslation1.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation1.x += newTranslation.x
            lastTranslation1.y += newTranslation.y
        }
        
        checkPosition1(image: puzzleimage1, center: center)
        checkWin()
    }
    
    
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 2  *
     ********************************************************/
    @objc func handlePanning2(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage2"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage2)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation2.x + newTranslation.x, y: lastTranslation2.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation2.x += newTranslation.x
            lastTranslation2.y += newTranslation.y
        }
        
        checkPosition2(image: puzzleimage2, center: center)
        
    }

    
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 3  *
     ********************************************************/
    @objc func handlePanning3(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage3"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage3)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation3.x + newTranslation.x, y: lastTranslation3.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation3.x += newTranslation.x
            lastTranslation3.y += newTranslation.y
        }
        
        checkPosition3(image: puzzleimage3, center: center)
        
    }

    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 4  *
     ********************************************************/
    @objc func handlePanning4(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage4"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage4)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation4.x + newTranslation.x, y: lastTranslation4.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation4.x += newTranslation.x
            lastTranslation4.y += newTranslation.y
        }
        
        checkPosition4(image: puzzleimage4, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 5  *
     ********************************************************/
    @objc func handlePanning5(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage5"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage5)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation5.x + newTranslation.x, y: lastTranslation5.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation5.x += newTranslation.x
            lastTranslation5.y += newTranslation.y
        }
        
        checkPosition5(image: puzzleimage5, center: center)
       
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning6(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage6"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage6)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation6.x + newTranslation.x, y: lastTranslation6.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation6.x += newTranslation.x
            lastTranslation6.y += newTranslation.y
        }
        
        checkPosition6(image: puzzleimage6, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning7(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage7"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage7)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation7.x + newTranslation.x, y: lastTranslation7.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation7.x += newTranslation.x
            lastTranslation7.y += newTranslation.y
        }
        
        checkPosition7(image: puzzleimage7, center: center)
       
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning8(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage8"] as! [Int]
        
        newTranslation = recognizer.translation(in: puzzleimage8)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation8.x + newTranslation.x, y: lastTranslation8.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation8.x += newTranslation.x
            lastTranslation8.y += newTranslation.y
        }
        
        checkPosition8(image: puzzleimage8, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning9(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage9"] as! [Int]
        
        let newTranslation = recognizer.translation(in: puzzleimage9)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation9.x + newTranslation.x, y: lastTranslation9.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation9.x += newTranslation.x
            lastTranslation9.y += newTranslation.y
        }
        
        checkPosition9(image: puzzleimage9, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning10(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage10"] as! [Int]
        
        let newTranslation = recognizer.translation(in: puzzleimage10)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation10.x + newTranslation.x, y: lastTranslation10.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation10.x += newTranslation.x
            lastTranslation10.y += newTranslation.y
        }
        
        checkPosition10(image: puzzleimage10, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning11(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage11"] as! [Int]
        
        let newTranslation = recognizer.translation(in: puzzleimage11)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation11.x + newTranslation.x, y: lastTranslation11.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation11.x += newTranslation.x
            lastTranslation11.y += newTranslation.y
        }
        
        checkPosition11(image: puzzleimage11, center: center)
        
    }
    
    /*********************************************************
     *  Handle Panning (Dragging) Gesture  for Image View 6  *
     ********************************************************/
    @objc func handlePanning12(_ recognizer: UIPanGestureRecognizer) {
        let center = dict_piecesData["puzzleImage12"] as! [Int]
        
        let newTranslation = recognizer.translation(in: puzzleimage12)
        
        recognizer.view?.transform = CGAffineTransform(translationX: lastTranslation12.x + newTranslation.x, y: lastTranslation12.y + newTranslation.y)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            lastTranslation12.x += newTranslation.x
            lastTranslation12.y += newTranslation.y
        }
        
        checkPosition12(image: puzzleimage12, center: center)
        
    }
	
    func checkPosition1(image: UIImageView, center: [Int]){
        //let origin : CGPoint = puzzleimage1.frame.origin
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation1.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation1.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            image.center.x = CGFloat(center[0]) - lastTranslation1.x
            image.center.y = CGFloat(center[1]) - lastTranslation1.y
            val1 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        //print("Current x:\(origin.x) Current y:\(origin.y)")


        checkWin()
    }
    
    func checkPosition2(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation2.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation2.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation2.x
            image.center.y = CGFloat(center[1]) - lastTranslation2.y
            val2 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
  
  
    func checkPosition3(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation3.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation3.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation3.x
            image.center.y = CGFloat(center[1]) - lastTranslation3.y
            val3 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
       checkWin()
    }
    
    func checkPosition4(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation4.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation4.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation4.x
            image.center.y = CGFloat(center[1]) - lastTranslation4.y
            val4 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition5(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation5.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation5.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation5.x
            image.center.y = CGFloat(center[1]) - lastTranslation5.y
            val5 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition6(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation6.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation6.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation6.x
            image.center.y = CGFloat(center[1]) - lastTranslation6.y
            val6 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition7(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation7.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation7.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation7.x
            image.center.y = CGFloat(center[1]) - lastTranslation7.y
            val7 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition8(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation8.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation8.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation8.x
            image.center.y = CGFloat(center[1]) - lastTranslation8.y
            val8 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    func checkPosition9(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation9.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation9.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation9.x
            image.center.y = CGFloat(center[1]) - lastTranslation9.y
            val9 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition10(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation10.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation10.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation10.x
            image.center.y = CGFloat(center[1]) - lastTranslation10.y
            val10 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition11(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation11.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation11.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation11.x
            image.center.y = CGFloat(center[1]) - lastTranslation11.y
            val11 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }
    
    func checkPosition12(image: UIImageView, center: [Int]){
        //let imageX = image.center.x
        //let imageY = image.center.y
        //print("This is the xCoord: \(imageX)")
        //print("This is the yCoord: \(imageY)")
        let distance: Double = sqrt(pow((Double(image.center.x + lastTranslation12.x) - Double(center[0])),2) + pow((Double(image.center.y + lastTranslation12.y) - Double(center[1])),2))
        //if the distance is within range, set image to new location.
        if distance <= 20{
            //print("Distance between points is:\(distance)")
            image.center.x = CGFloat(center[0]) - lastTranslation12.x
            image.center.y = CGFloat(center[1]) - lastTranslation12.y
            val12 = CGFloat(center[0])
            do {
                player = try AVAudioPlayer(data: (clickAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        checkWin()
    }

    
    //Check if puzzle is assembled
    func checkWin(){
        //UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: { self.rightRocket.alpha = 1.0}, completion: nil)
        //print("counter:\(counter)")
        if val1 == 291 &&
            val2 == 442 &&
            val3 == 578 &&
            val4 == 727 &&
            val5 == 287 &&
            val6 == 445 &&
            val7 == 586 &&
            val8 == 726 &&
            val9 == 292 &&
            val10 == 452 &&
            val11 == 582 &&
            val12 == 723
        {
            //isRunning = false
            timer.invalidate()
            isRunning = false
            self.bottomLabel.isHidden = false
            self.leftRocket.isHidden = false
            self.rightRocket.isHidden = false
            UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [.repeat ],
                           animations: ({ self.rightRocket.center.y = self.view.frame.height / 4}), completion: nil)
            UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [.repeat ],
                           animations: ({ self.leftRocket.center.y = self.view.frame.height / 4}), completion: nil)
//            leftRocket.animationDuration = 1.0
//            leftRocket.startAnimating()
//            self.rightRocket.animationImages = [
//                UIImage(named: "rocketFlyingUp.png")!,
//                UIImage(named: "rocketFlyingUp.png")!,
//                UIImage(named: "rocketFlyingUp.png")!,
//                UIImage(named: "rocketFlyingUp.png")!,
//                UIImage(named: "rocketFlyingUp.png")!
//            ]
//            self.rightRocket.animationDuration = 1.0
            self.rightRocket.startAnimating()
            self.winLabel.isHidden = false
            self.view.bringSubview(toFront: self.winLabel)
            puzzleimage1.isUserInteractionEnabled = false
            puzzleimage2.isUserInteractionEnabled = false
            puzzleimage3.isUserInteractionEnabled = false
            puzzleimage4.isUserInteractionEnabled = false
            puzzleimage5.isUserInteractionEnabled = false
            puzzleimage6.isUserInteractionEnabled = false
            puzzleimage7.isUserInteractionEnabled = false
            puzzleimage8.isUserInteractionEnabled = false
            puzzleimage9.isUserInteractionEnabled = false
            puzzleimage10.isUserInteractionEnabled = false
            puzzleimage11.isUserInteractionEnabled = false
            puzzleimage12.isUserInteractionEnabled = false
            do {
                player = try AVAudioPlayer(data: (applaudAsset?.data)!, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            //print("Time:\(timeCount)")
            if timeCount < 20{
                bottomLabel.text = "You did Outstanding"
            } else if timeCount >= 20 && timeCount < 40{
                bottomLabel.text = "You did Excellent"
            } else if timeCount >= 41 && timeCount < 120{
                bottomLabel.text = "You did Good"
            } else if timeCount >= 121 && timeCount < 180{
                bottomLabel.text = "You did Satisfactory"
            } else if timeCount >= 181 {
                bottomLabel.text = "You did Slow"
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ---------------------
     MARK: - Create Canvas
     ---------------------
     */
    
    // This method creates a rectangular canvas centered on the screen to hold the puzzle
    // pieces when they are all put together (i.e., when the puzzle is solved).
    
    func drawRectangle() {
        
        // Set the size of the canvas to be created to width=603 and height=453
        let canvasSize = CGSize(width: 603, height: 453)
        
        // Set the properties of the graphics context to be created
        let bounds = CGRect(origin: CGPoint.zero, size: canvasSize)
        let opaque = false
        let scale: CGFloat = 0
        
        // Create a bitmap-based graphics context with the specified properties
        UIGraphicsBeginImageContextWithOptions(canvasSize, opaque, scale)
        
        // Set the current graphics context returned to context
        let context = UIGraphicsGetCurrentContext()
        
        // Set the current stroke color in the graphics context, using a Quartz color
        context?.setStrokeColor(UIColor.black.cgColor)
        
        // Set the line width for the graphics context to 3 points
        context?.setLineWidth(3.0)
        
        // Paint a rectangular path
        context?.stroke(bounds)
        
        context?.beginPath()
        context?.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        context?.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        context?.strokePath()
        
        // Return an image based on the contents of the current bitmap-based graphics context
        let contextImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Remove the current bitmap-based graphics context from the top of the stack
        UIGraphicsEndImageContext()
        
        /*
         Create a UIImageView object in Storyboard with x=210, y=158, width=603, height=453
         Create an outlet for it as: @IBOutlet var backgroundRect: UIImageView!
         
         Set the UIImageView object's image to the image created based on the contents of
         the current bitmap-based graphics context.
         */
        backgroundRect.image = contextImage
    }

}

