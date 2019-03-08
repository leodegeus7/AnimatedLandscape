import UIKit

class Star: UIView {
  
  var grayColor = UIColor(red: 120.0 / 255.0, green: 120.0 / 255.0,
                          blue: 122.0 / 255.0, alpha: 1.0)
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    self.backgroundColor = UIColor.clear
    drawStar(in: rect, in: context, with: colorSpace)
  }
  
  func drawStar(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let starSize = CGSize(width: self.frame.width, height: self.frame.height)
    guard let starLayer = CGLayer(context, size: starSize,
                                    auxiliaryInfo: nil) else {
                                      return
    }
    guard let starContext = starLayer.context else {
      return
    }
    
    drawCircle(in: CGRect(x: 1, y: 1, width: self.frame.width - 2, height: self.frame.height - 2), in: starContext, with: colorSpace, color: grayColor)
    
    context.draw(starLayer, at: CGPoint(x:0, y:0))
  }
  
  func drawCircle(in rect: CGRect,in context: CGContext, with colorSpace: CGColorSpace?, color:UIColor) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let backgroundMountains = CGMutablePath()
    backgroundMountains.addEllipse(in: rect)
    context.addPath(backgroundMountains)
    context.strokePath()
    context.setFillColor(color.cgColor)
    context.addPath(backgroundMountains)
    context.fillPath()
  }

}
