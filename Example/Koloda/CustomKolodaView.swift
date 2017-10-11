//
//  CustomKolodaView.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

let defaultTopOffset: CGFloat = 20
let defaultHorizontalOffset: CGFloat = 10
let defaultHeightRatio: CGFloat = 1.25
let backgroundCardHorizontalMarginMultiplier: CGFloat = 0.25
let backgroundCardScalePercent: CGFloat = 1.5

class CustomKolodaView: KolodaView {

    override func frameForCard(at index: Int) -> CGRect {
        if index == 0 {
            let topOffset: CGFloat = defaultTopOffset
            let xOffset: CGFloat = defaultHorizontalOffset
            let width = (self.frame).width - 2 * defaultHorizontalOffset
            let height = width * defaultHeightRatio
            let yOffset: CGFloat = topOffset
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            
            return frame
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardHorizontalMarginMultiplier
            let width = self.bounds.width * backgroundCardScalePercent
            let height = width * defaultHeightRatio
            return CGRect(x: horizontalMargin, y: 0, width: width, height: height)
        }
        return CGRect.zero
    }

	
    
//    public func revertAction() {
//        guard currentCardIndex > 0 && !animating else {
//            return
//        }
//        if countOfCards - currentCardIndex >= countOfVisibleCards {
//            if let lastCard = visibleCards.last {
//                lastCard.removeFromSuperview()
//                visibleCards.removeLast()
//            }
//        }
//        currentCardIndex -= 1
//
//        if dataSource != nil {
//            let firstCardView = createCard(at: currentCardIndex, frame: frameForTopCard())
//
//            if shouldTransparentizeNextCard {
//                firstCardView.alpha = alphaValueTransparent
//            }
//            firstCardView.delegate = self
//
//            addSubview(firstCardView)
//            visibleCards.insert(firstCardView, at: 0)
//
//            animating = true
//            animator.applyReverseAnimation(firstCardView, completion: { [weak self] _ in
//                guard let _self = self else {
//                    return
//                }
//
//                _self.animating = false
//                _self.delegate?.koloda(_self, didShowCardAt: _self.currentCardIndex)
//            })
//        }
//
//        for (index, card) in visibleCards.dropFirst().enumerated() {
//            if shouldTransparentizeNextCard {
//                card.alpha = alphaValueSemiTransparent
//            }
//            card.isUserInteractionEnabled = false
//
//            let cardParameters = backgroundCardParametersForFrame(frameForCard(at: index + 1))
//            animator.applyScaleAnimation(
//                card,
//                scale: cardParameters.scale,
//                frame: cardParameters.frame,
//                duration: defaultBackgroundCardFrameAnimationDuration,
//                completion: nil
//            )
//        }
//    }
    
}
