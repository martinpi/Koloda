//
//  BackgroundAnimationViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda
import pop

private let numberOfCards: Int = 28
private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 1
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

private let cardTransitions: Dictionary = [ 0 : [ 2, 1 ],
                                            1 : [ 3, 4 ],
                                            2 : [ 6, 5 ],
                                            3 : [ 8, 25 ],
                                            4 : [ 7, 20 ],
                                            5 : [ 1, 3 ],
                                            6 : [ 5, 1 ],
                                            7 : [ 17, 18 ],
                                            8 : [ 9, 25 ],
                                            9 : [ 10, 24 ],
                                            10 : [ 11, 19 ],
                                            11 : [ 12, 19 ],
                                            12 : [ 13, 21 ],
                                            13 : [ 14, 22 ],
                                            14 : [ 23,15 ],
                                            15 : [ 26, 16 ],
                                            16 : [ 25, 27 ],
                                            17 : [ 0, 0 ],
                                            18 : [ 0, 0 ],
                                            19 : [ 0, 0 ],
                                            20 : [ 0, 0 ],
                                            21 : [ 0, 0 ],
                                            22 : [ 0, 0 ],
                                            23 : [ 0, 0 ],
                                            24 : [ 0, 0 ],
                                            25 : [ 0, 0 ],
                                            26 : [ 0, 0 ],
                                            27 : [ 0, 0 ] ]

private var nextCard: Int = 0

class BackgroundAnimationViewController: UIViewController {

    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
		
		for (index, values) in cardTransitions {
			for (value) in values {
				kolodaView.addTransition(from: index, to: value)
			}
		}
		
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
}

//MARK: KolodaViewDelegate
extension BackgroundAnimationViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
	
	func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {

	}
	
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
		
    }

	func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
		debugPrint("== \(index)")
	}
}

// MARK: KolodaViewDataSource
extension BackgroundAnimationViewController: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfCards
    }
	
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
		return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
