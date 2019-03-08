import UIKit

class SkyView: UIView {
  
  
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
  
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    drawSky(in: rect, rageLevel: rageLevel, context: context, colorSpace: colorSpace)
  }
  
  private func drawSky(in rect: CGRect, rageLevel: Int, context: CGContext, colorSpace: CGColorSpace) {
    var baseColor: UIColor
    var middleStop: UIColor
    var farStop: UIColor

    if isDay {
      baseColor = UIColor(red: 0 / 255.0, green: CGFloat(1.58 * Double(rageLevel) / 255.0), blue: CGFloat(1.8 * Double(rageLevel) / 255.0), alpha: 1.0)
      middleStop = UIColor(red: 0.0 / 255.0, green: CGFloat(2.55 * Double(rageLevel) / 255.0), blue: CGFloat(2.52 * Double(rageLevel) / 255.0), alpha: 1.0)
      farStop = UIColor(red: CGFloat(2.55 * Double(rageLevel) / 255.0), green: CGFloat(2.55 * Double(rageLevel) / 255.0), blue: CGFloat(2.55 * Double(rageLevel) / 255.0), alpha: 1.0)
    } else {
      baseColor = UIColor(red: 0.23 / 255.0, green: CGFloat(0.31 * Double(rageLevel) / 255.0), blue: CGFloat(0.81 * Double(rageLevel) / 255.0), alpha: 1.0)
      middleStop = UIColor(red: 0.04 / 255.0, green: CGFloat(0.04 * Double(rageLevel) / 255.0), blue: CGFloat(0.30 * Double(rageLevel) / 255.0), alpha: 1.0)
      farStop = UIColor(red: CGFloat(0 * Double(rageLevel) / 255.0), green: CGFloat(0.01 * Double(rageLevel) / 255.0), blue: CGFloat(0.19 * Double(rageLevel) / 255.0), alpha: 1.0)
    }
    context.saveGState()
    defer { context.restoreGState() }
    
    let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
    let locations: [CGFloat] = [0.0, 0.1, 0.25]
    
    let startPoint = CGPoint(x: rect.size.height/2, y: 0)
    let endPoint = CGPoint(x: rect.size.height/2, y: rect.size.width)
    
    if let gradient = CGGradient.init(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations) {
      context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
  }

}
