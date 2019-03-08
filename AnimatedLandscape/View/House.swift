import UIKit

class House: UIView {
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }
  
  var isDay = false
  private var rageLevel = 1
  var lastValue = 0
  
  func setRageLevel(_ rageLevel: Int,isDay:Bool) {
    self.isDay = isDay
    if rageLevel > 100 {
      self.rageLevel = 100
    } else if rageLevel < 0 {
      self.rageLevel = 0
    } else {
      self.rageLevel = rageLevel
    }
    if self.rageLevel != self.lastValue {
      setNeedsDisplay()
      self.lastValue = rageLevel
    }
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    drawHouse(in: rect, in: context, with: colorSpace)
  }
  
  private func drawHouse(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0, blue: 67.0 / 255.0, alpha: 1)
    let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
    let rectWidth = rect.size.width
    context.saveGState()
    defer { context.restoreGState() }
    let backgroundMountains = CGMutablePath()
    backgroundMountains.move(to: CGPoint(x: 0, y: 0), transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: 0, y: 300), transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: 400, y: 300), transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: 400, y: 300), transform: .identity)
    backgroundMountains.closeSubpath()
    context.addPath(backgroundMountains)
    context.clip()
    context.setLineWidth(4)
    context.addPath(backgroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
  }
}
