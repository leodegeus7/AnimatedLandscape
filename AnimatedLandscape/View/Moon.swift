import UIKit

class Moon: UIView {
  
  var grayColor = UIColor(red: 154.0 / 255.0, green: 154.0 / 255.0,
                            blue: 157.0 / 255.0, alpha: 1.0)
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    self.tag = 1
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    self.backgroundColor = UIColor.clear
    drawMoon(in: rect, in: context, with: colorSpace)
  }
  
  
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }
  
  func drawMoon(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let flowerSize = CGSize(width: 500, height: 500)
    guard let flowerLayer = CGLayer(context, size: flowerSize,
                                    auxiliaryInfo: nil) else {
                                      return
    }
    guard let flowerContext = flowerLayer.context else {
      return
    }
    
    drawCircle(in: CGRect(x: 22, y: 97, width: 70, height: 70), in: flowerContext, with: colorSpace, color: grayColor)
    
    context.draw(flowerLayer, at: CGPoint(x: rect.width * 0.8 - 89, y:rect.height * 0.12 - 83))
  }
  
  func drawCircle(in rect: CGRect,in context: CGContext, with colorSpace: CGColorSpace?, color:UIColor) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let backgroundMountains = CGMutablePath()
    backgroundMountains.addEllipse(in: rect)
    context.addPath(backgroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    context.setFillColor(color.cgColor)
    context.addPath(backgroundMountains)
    context.fillPath()
  }
  
}
