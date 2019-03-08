import UIKit

class Mountains: UIView {
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
    
    
    drawMountains(in: rect, in: context, with: colorSpace)
    drawGrass(in: rect, in: context, with: colorSpace)
    drawFlowers(in: rect, in: context, with: colorSpace)
  }
  
  private func drawMountains(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0, blue: 67.0 / 255.0, alpha: 1)
    let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
    let rectWidth = rect.size.width
    
    let mountainColors = [darkColor.cgColor, lightColor.cgColor]
    let mountainLocations: [CGFloat] = [0.1, 0.2]
    guard let mountainGrad = CGGradient.init(colorsSpace: colorSpace, colors: mountainColors as CFArray, locations: mountainLocations) else {
      return
    }
    
    let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
    let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
    
    context.saveGState()
    defer { context.restoreGState() }
    
    let backgroundMountains = CGMutablePath()
    backgroundMountains.move(to: CGPoint(x: -5, y: 157), transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157), control: CGPoint(x: 30, y: 129), transform: .identity)
    backgroundMountains.addCurve(to: CGPoint(x: 303, y: 125), control1: CGPoint(x: 190, y: 210), control2: CGPoint(x: 200, y: 70), transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 350, y: 150), control: CGPoint(x: 340, y: 150), transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 410, y: 145), control: CGPoint(x: 380, y: 155), transform: .identity)
    backgroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 165), control1: CGPoint(x: rectWidth - 90, y: 100), control2: CGPoint(x: rectWidth - 50, y: 190), transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: rectWidth - 10, y: rect.size.width), transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: -5, y: rect.size.width), transform: .identity)
    backgroundMountains.closeSubpath()
    
    // Background Mountain Drawing
    context.addPath(backgroundMountains)
    
    context.clip()
    context.drawLinearGradient(mountainGrad, start: mountainStart, end: mountainEnd, options: [])
    context.setLineWidth(4)
    
    // Background Mountain Stroking
    context.addPath(backgroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    
    // Foreground Mountains
    let foregroundMountains = CGMutablePath()
    foregroundMountains.move(to: CGPoint(x: -5, y: 190), transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190), control1: CGPoint(x: 160, y: 250), control2: CGPoint(x: 200, y: 140), transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210), control1: CGPoint(x: rectWidth - 150, y: 250), control2: CGPoint(x: rectWidth - 50, y: 170), transform: .identity)
    foregroundMountains.addLine(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215), transform: .identity)
    foregroundMountains.closeSubpath()
    
    // Foreground Mountain drawing
    context.addPath(foregroundMountains)
    context.clip()
    context.setFillColor(darkColor.cgColor)
    context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))
    
    // Foreground Mountain stroking
    context.addPath(foregroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
  }
  
  private func drawGrass(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let grassStart = CGPoint(x: rect.size.height / 2, y: 100)
    let grassEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
    let rectWidth = rect.size.width
    
    let grass = CGMutablePath()
    grass.move(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
    grass.addCurve(to: CGPoint(x: 0, y: 225), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215), transform: .identity)
    grass.addLine(to: CGPoint(x: 0, y: rect.size.width), transform: .identity)
    grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width), transform: .identity)
    
    context.addPath(grass)
    context.clip()
    
    var lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0, blue: 95.0 / 255.0, alpha: 1)
    var darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0, blue: 61.0 / 255.0, alpha: 1)
    
    
    let rage = CGFloat(rageLevel) / 4.0
    if isDay {
      lightGreen = lightGreen.adjust(by: rage)!
      darkGreen = darkGreen.adjust(by: rage)!
    } else {
      lightGreen = lightGreen.adjust(by: rage * -1 * 1.8)!
      darkGreen = darkGreen.adjust(by: rage * -1 * 1.8)!
    }
    
    let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
    let grassLocations: [CGFloat] = [0.3, 0.4]
    if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
      context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
    }
    
    context.setLineWidth(1)
    context.setFillColor(UIColor.white.cgColor)
    context.setStrokeColor(UIColor.black.cgColor)
  }
  
  private func drawPetal(in rect: CGRect, inDegrees degrees: Int, inContext context: CGContext) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let flowerPetal = CGMutablePath()
    
    let midX = rect.midX
    let midY = rect.midY
    
    let transform = CGAffineTransform(translationX: -midX, y: -midY).concatenating(CGAffineTransform(rotationAngle:
      degreesToRadians(CGFloat(degrees)))).concatenating(CGAffineTransform(translationX: midX, y: midY))
    
    var colorWhite = UIColor.white
    let rage = CGFloat(rageLevel) / 4.0
    if isDay {
      colorWhite = colorWhite.adjust(by: rage)!
    } else {
      colorWhite = colorWhite.adjust(by: rage * -1 * 1.8)!
    }
    
    
    flowerPetal.addEllipse(in: rect, transform: transform)
    context.addPath(flowerPetal)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    context.setFillColor(colorWhite.cgColor)
    context.addPath(flowerPetal)
    context.fillPath()
  }
  
  private func drawFlowers(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
    context.saveGState()
    defer { context.restoreGState() }
    
    let flowerSize = CGSize(width: 300, height: 300)
    guard let flowerLayer = CGLayer(context, size: flowerSize, auxiliaryInfo: nil) else {
      return
    }
    
    guard let flowerContext = flowerLayer.context else {
      return
    }
    
    // Draw petals of the flower
    drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14), inDegrees: 0, inContext: flowerContext)
    drawPetal(in: CGRect(x: 115, y: 236, width: 10, height: 12), inDegrees: 300, inContext: flowerContext)
    drawPetal(in: CGRect(x: 120, y: 246, width: 9, height: 14), inDegrees: 5, inContext: flowerContext)
    drawPetal(in: CGRect(x: 128, y: 246, width: 9, height: 14), inDegrees: 350, inContext: flowerContext)
    drawPetal(in: CGRect(x: 133, y: 236, width: 11, height: 14), inDegrees: 80, inContext: flowerContext)
    
    let center = CGMutablePath()
    let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
    center.addEllipse(in: ellipse, transform: .identity)
    
    let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)
    
    // Draw flower
    flowerContext.addPath(center)
    flowerContext.setStrokeColor(UIColor.black.cgColor)
    flowerContext.strokePath()
    flowerContext.setFillColor(orangeColor.cgColor)
    flowerContext.addPath(center)
    flowerContext.fillPath()
    flowerContext.move(to: CGPoint(x: 135, y: 249))
    context.setStrokeColor(UIColor.black.cgColor)
    flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270), control: CGPoint(x: 145, y: 250))
    flowerContext.strokePath()

    getArrayFlowers(count: 5)
    for point in cgpoints {
      context.draw(flowerLayer, at: CGPoint(x: point.x, y: point.y))
    }
  }
  
  var cgpoints = [CGPoint]()
  func getArrayFlowers(count:Int) {
    if cgpoints.isEmpty {
      for _ in 0...count - 1 {
        let x = Int(arc4random_uniform(UInt32(800))) - 100
        let y = Int(arc4random_uniform(UInt32(80))) - 10
        cgpoints.append(CGPoint(x: CGFloat(x), y:  CGFloat(y)))
      }
    }
  }
  
  
}
