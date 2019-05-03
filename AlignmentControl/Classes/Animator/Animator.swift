//
//  Animator.swift
//  AlignmentControl
//
//  Created by Mikhail Kupriyanov on 03/05/2019.
//

import Foundation

protocol Animationable {
    
    // MARK: - Animation by axe X
    
    func leftToCenter()
    func leftToRight()
    func rightToLeft()
    func centerToRight()
    func rightToCenter()
    func centerToLeft()
    
    // MARK: - Animation by axe Y
    
    func topToMiddle()
    func topToBottom()
    func bottomToTop()
    func middleToBottom()
    func bottomToMiddle()
    func middleToTop()
}

class Animator: Animationable {
    private(set) var alignment: AlignmentMode
    private(set) var offsetX: CGFloat
    private(set) var offsetY: CGFloat
    private(set) var activeMiddleWard: CAShapeLayer
    private(set) var activeShortWard: CAShapeLayer
    private let kDelay: CFTimeInterval = 0.1
    
    init(alignment: AlignmentMode,
         offsetX: CGFloat,
         offsetY: CGFloat,
         activeMiddleWard: CAShapeLayer,
         activeShortWard: CAShapeLayer) {
        
        self.alignment = alignment
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.activeMiddleWard = activeMiddleWard
        self.activeShortWard = activeShortWard
    }
    
    // MARK: - Animation by axe X
    
    func leftToCenter() {
        
        leftToCenter(activeWard: activeMiddleWard)
        leftToCenter(activeWard: activeShortWard, delay: kDelay)
    }
    
    func leftToRight() {
        
        leftToRight(activeWard: activeMiddleWard)
        leftToRight(activeWard: activeShortWard, delay: kDelay)
    }
    
    func rightToLeft() {
        
        rightToLeft(activeWard: activeMiddleWard)
        rightToLeft(activeWard: activeShortWard, delay: kDelay)
    }
    
    func centerToRight() {
        
        centerToRight(activeWard: activeMiddleWard)
        centerToRight(activeWard: activeShortWard, delay: kDelay)
    }
    
    func rightToCenter() {
        rightToCenter(activeWard: activeMiddleWard)
        rightToCenter(activeWard: activeShortWard, delay: kDelay)
    }
    
    func centerToLeft() {
        
        centerToLeft(activeWard: activeMiddleWard)
        centerToLeft(activeWard: activeShortWard, delay: kDelay)
    }
    
    // MARK: - Animation by axe Y
    
    func topToMiddle() {
        
        topToMiddle(activeWard: activeMiddleWard)
        topToMiddle(activeWard: activeShortWard, delay: kDelay)
    }
    
    func topToBottom() {
        
        topToBottom(activeWard: activeMiddleWard)
        topToBottom(activeWard: activeShortWard, delay: kDelay)
    }
    
     func bottomToTop() {
        
        bottomToTop(activeWard: activeMiddleWard)
        bottomToTop(activeWard: activeShortWard, delay: kDelay)
    }
    
     func middleToBottom() {
        
        middleToBottom(activeWard: activeMiddleWard)
        middleToBottom(activeWard: activeShortWard, delay: kDelay)
    }
    
     func bottomToMiddle() {
        
        bottomToMiddle(activeWard: activeMiddleWard)
        bottomToMiddle(activeWard: activeShortWard, delay: kDelay)
    }
    
    func middleToTop() {
        
        middleToTop(activeWard: activeMiddleWard)
        middleToTop(activeWard: activeShortWard, delay: kDelay)
    }
    
    // MARK: - Private : Axe X
    
        private func makeAnimationByX(delay: CFTimeInterval) -> CASpringAnimation {
            
            let animation = CASpringAnimation(keyPath: "position.x")
            animation.initialVelocity = 10.0
            animation.mass = 1.0
            animation.stiffness = 100.0
            animation.damping = 10.0
            animation.duration = animation.settlingDuration
            animation.beginTime = CACurrentMediaTime() + delay
            animation.isRemovedOnCompletion = true
            return animation
        }
        
        private func leftToCenter(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
            case .Left:
                animation.fromValue = initialPosition
                animation.toValue = offsetX
                finishPosition = offsetX
                
            case .Center:
                animation.fromValue = -offsetX
                animation.toValue = initialPosition
                finishPosition = initialPosition
                
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
        
        private func leftToRight(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
            case .Left:
                animation.fromValue = initialPosition
                animation.toValue = offsetX
                finishPosition = offsetX
                
            case .Center:
                animation.fromValue = -offsetX
                animation.toValue = offsetX
                finishPosition = offsetX
                
            case .Right:
                animation.fromValue = -offsetX
                animation.toValue =  initialPosition
                finishPosition = initialPosition
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
        
        private func rightToLeft(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
            case .Right:
                animation.fromValue = initialPosition
                animation.toValue = -offsetX
                finishPosition = -offsetX
                
            case .Center:
                animation.fromValue = offsetX
                animation.toValue = -offsetX
                finishPosition = -offsetX
                
            case .Left:
                animation.fromValue = offsetX
                animation.toValue =  initialPosition
                finishPosition = initialPosition
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
        
        private func centerToRight(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
                
            case .Center:
                animation.fromValue = initialPosition
                animation.toValue = offsetX
                finishPosition = offsetX
                
            case .Right:
                animation.fromValue = -offsetX
                animation.toValue =  initialPosition
                finishPosition = initialPosition
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
        
        private func rightToCenter(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
            case .Right:
                animation.fromValue = initialPosition
                animation.toValue =  -offsetX
                finishPosition = -offsetX
                
            case .Center:
                animation.fromValue = offsetX
                animation.toValue = initialPosition
                finishPosition = initialPosition
                
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
        
        private func centerToLeft(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
            
            let animation = makeAnimationByX(delay: delay)
            var finishPosition: CGFloat = 0
            let initialPosition: CGFloat = 0
            switch alignment {
            case .Center:
                animation.fromValue = initialPosition
                animation.toValue =  -offsetX
                finishPosition = -offsetX
                
            case .Left:
                animation.fromValue = offsetX
                animation.toValue = initialPosition
                finishPosition = initialPosition
                
            default:
                break
            }
            activeWard.add(animation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                activeWard.position.x = finishPosition
            }
        }
    
    // MARK: - Private : Axe Y
    
    private func makeAnimationByY(delay: CFTimeInterval) -> CASpringAnimation {
        
        let animation = CASpringAnimation(keyPath: "position.y")
        animation.initialVelocity = 10.0
        animation.mass = 1.0
        animation.stiffness = 100.0
        animation.damping = 10.0
        animation.duration = animation.settlingDuration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = true
        return animation
    }
    
    private func topToMiddle(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
        case .Top:
            animation.fromValue = initialPosition
            animation.toValue = offsetY
            finishPosition = offsetY
            
        case .Middle:
            animation.fromValue = -offsetY
            animation.toValue = initialPosition
            finishPosition = initialPosition
            
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
    
    private func topToBottom(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
        case .Top:
            animation.fromValue = initialPosition
            animation.toValue = offsetY
            finishPosition = offsetY
            
        case .Middle:
            animation.fromValue = -offsetY
            animation.toValue = offsetY
            finishPosition = offsetY
            
        case .Bottom:
            animation.fromValue = -offsetY
            animation.toValue =  initialPosition
            finishPosition = initialPosition
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
    
    private func bottomToTop(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
        case .Bottom:
            animation.fromValue = initialPosition
            animation.toValue = -offsetY
            finishPosition = -offsetY
            
        case .Middle:
            animation.fromValue = offsetY
            animation.toValue = -offsetY
            finishPosition = -offsetY
            
        case .Top:
            animation.fromValue = offsetY
            animation.toValue =  initialPosition
            finishPosition = initialPosition
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
    
    private func middleToBottom(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
            
        case .Middle:
            animation.fromValue = initialPosition
            animation.toValue = offsetY
            finishPosition = offsetY
            
        case .Bottom:
            animation.fromValue = -offsetY
            animation.toValue =  initialPosition
            finishPosition = initialPosition
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
    
    private func bottomToMiddle(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
        case .Bottom:
            animation.fromValue = initialPosition
            animation.toValue =  -offsetY
            finishPosition = -offsetY
            
        case .Middle:
            animation.fromValue = offsetY
            animation.toValue = initialPosition
            finishPosition = initialPosition
            
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
    
    private func middleToTop(activeWard: CAShapeLayer, delay: CFTimeInterval = 0) {
        
        let animation = makeAnimationByY(delay: delay)
        var finishPosition: CGFloat = 0
        let initialPosition: CGFloat = 0
        switch alignment {
        case .Middle:
            animation.fromValue = initialPosition
            animation.toValue =  -offsetY
            finishPosition = -offsetY
            
        case .Top:
            animation.fromValue = offsetY
            animation.toValue = initialPosition
            finishPosition = initialPosition
            
        default:
            break
        }
        activeWard.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            activeWard.position.y = finishPosition
        }
    }
}
