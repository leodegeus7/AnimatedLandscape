import UIKit

class Sun: UIView {

  var orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0,
                            blue: 49.0 / 255.0, alpha: 1.0)
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    self.tag = 0
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    self.backgroundColor = UIColor.clear
    drawSun(in: rect, in: context, with: colorSpace)
  }


  
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }
  
  func drawSun(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
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
    
    drawSunBeams(in: CGRect(x: 100, y: 100, width: 9, height: 14), inDegrees: 0, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 47, y: 120, width: 9, height: 14), inDegrees: 45, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 47, y: 120, width: 9, height: 14), inDegrees: 90, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 48, y: 120, width: 9, height: 14), inDegrees: 135, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 48, y: 120, width: 9, height: 14), inDegrees: 180, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 48, y: 120, width: 9, height: 14), inDegrees: 225, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 48, y: 118, width: 9, height: 14), inDegrees: 270, in: flowerContext, with: colorSpace, color: orangeColor)
    drawSunBeams(in: CGRect(x: 48, y: 120, width: 9, height: 14), inDegrees: 315, in: flowerContext, with: colorSpace, color: orangeColor)
    drawCircle(in: CGRect(x: 22, y: 97, width: 60, height: 60), in: flowerContext, with: colorSpace, color: orangeColor)
    
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
  
  func drawSunBeams(in rect: CGRect,inDegrees degrees: Int,in context: CGContext, with colorSpace: CGColorSpace?,color:UIColor) {
    context.saveGState()
    defer { context.restoreGState() }
    let midX = rect.midX
    let midY = rect.midY
    let transform = CGAffineTransform(translationX: -midX, y: -midY)
      .concatenating(CGAffineTransform(rotationAngle: degreesToRadians(CGFloat(degrees))))
      .concatenating(CGAffineTransform(translationX: midX, y: midY))
    let backgroundMountains = CGMutablePath()
    backgroundMountains.move(to: CGPoint(x: 40, y: 100), transform: transform)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 46, y: 85),
                                     control: CGPoint(x: 40, y: 94),
                                     transform: transform)
    backgroundMountains.addLine(to: CGPoint(x: 53, y: 70),transform: transform)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 62, y: 92),
                                     control: CGPoint(x: 50, y: 84),
                                     transform: transform)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 65, y: 100),
                                     control: CGPoint(x: 65 + 2 , y: 100 - 2),
                                     transform: transform)
    context.addPath(backgroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    context.setFillColor(color.cgColor)
    context.addPath(backgroundMountains)
    context.fillPath()
    context.strokePath()
  }
}
