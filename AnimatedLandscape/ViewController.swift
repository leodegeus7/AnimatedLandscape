import UIKit
import FLAnimatedImage
import QuartzCore

class ViewController: UIViewController {
  @IBOutlet weak var skyView: SkyView!
  @IBOutlet weak var sunView: Sun!
  @IBOutlet weak var mountainsView: Mountains!
  @IBOutlet weak var moonView: Moon!
  @IBOutlet weak var houseImage: FLAnimatedImageView!
  
  
  var count = 0.0
  var reverse = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

  }
  
  override func viewDidLayoutSubviews() {
    
    let path1 : String = Bundle.main.path(forResource: "house", ofType: "gif")!
    let url = URL(fileURLWithPath: path1)
    let gifData = try! Data(contentsOf: url)
    let imageData1 = FLAnimatedImage(animatedGIFData: gifData)
    houseImage.animatedImage = imageData1
    
    
    rotateView(targetView: sunView,
               duration: 20)
    moveSun()
  }
  
  private func moveSun() {
    let start = CGPoint(x:20, y: 300)
    let end = CGPoint(x: self.view.frame.width - 40, y: 300)
    self.animateViewOnCurve(view: self.sunView, duration: 20.0, factor: 0.38, fromPoint: start, toPoint: end) { (result) in
      self.createStar(turnOn: true)
      self.animateViewOnCurve(view: self.moonView, duration: 20.0, factor: 0.38, fromPoint: start, toPoint: end) { (result) in
        self.moveSun()
      }
    }
  }
  
  private func rotateView(targetView: UIView, duration: Double = 1.0) {
    UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
      targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
    }) { finished in
      self.rotateView(targetView: targetView, duration: duration)
    }
  }
  
  private func animateViewOnCurve(view : UIView,duration:Double, factor : CGFloat, fromPoint start : CGPoint, toPoint end: CGPoint,completion: @escaping (_ result: Bool) -> Void) {
    view.isHidden = false
    let animation = CAKeyframeAnimation(keyPath: "position")
    let path = UIBezierPath()
    path.move(to: start)
    let delta : CGFloat = end.x - start.x
    let c1 = CGPoint(x: start.x                  , y: start.y - delta * factor)
    let c2 = CGPoint(x: end.x                    , y: end.y - delta * factor)
    path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)
    animation.path = path.cgPath
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.duration = duration
    animation.repeatCount = 1
    count = 0.0
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
      var isDay = false
      if view.tag == 0 {
        isDay = true
      }
      self.changeSky(actual: Double(self.count), duration: duration,isDay:isDay)
      self.changeGrass(actual: Double(self.count), duration: duration,isDay:isDay)
      if self.reverse {
        self.count = self.count - 0.1
      } else {
        self.count = self.count + 0.1
      }
      
      if self.count > (duration / 2.0)  {
        self.reverse = true
        
      }else if self.count < 0 {
        self.reverse = false
        view.isHidden = true
        timer.invalidate()
        completion(true)
      }
    }
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    view.layer.add(animation, forKey: "trash")
  }
  
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }
  
  func changeSky(actual:Double,duration:Double,isDay:Bool) {
    let time = actual
    let y = Int(-1.111*time*time + 23.33*time)
    self.skyView.setRageLevel(y,isDay:isDay)
  }
  
  func changeGrass(actual:Double,duration:Double,isDay:Bool) {
    let time = actual
    let y = Int(-0.57*time*time + 18*time)
    self.mountainsView.setRageLevel(y,isDay:isDay)
  }
  
  var stars = [Star]()
  var numberOfStars = 70
  func createStar(turnOn:Bool) {
    if turnOn {
      let queue = OperationQueue()
      queue.maxConcurrentOperationCount = 1
      for _ in 0...numberOfStars {
        queue.addOperation {
          self.createStar()
        }
      }
    } else {
      let queue = OperationQueue()
      queue.maxConcurrentOperationCount = 1
      for _ in 0...numberOfStars {
        queue.addOperation {
          self.removeStar()
        }
      }
    }
  }
  
  func createStar() {
    DispatchQueue.main.async {
      let width = Double(arc4random_uniform(UInt32(10.0))) + 3.0
      let x = Double(self.skyView.frame.width) * drand48()
      let y = (Double(self.skyView.frame.height) / 2.0) * drand48()
      let star = Star.init(frame: CGRect(x: x, y: y, width: width, height: width))
      star.alpha = CGFloat(drand48())
      star.backgroundColor = UIColor.clear
      self.skyView.addSubview(star)
      self.stars.append(star)
    }
    usleep(140000)
    if stars.count == numberOfStars {
      usleep(2000000)
      createStar(turnOn: false)
    }
  }
  
  func removeStar() {
    DispatchQueue.main.async {
      if let star = self.stars.last {
        star.removeFromSuperview()
        self.stars.remove(at: self.stars.count - 1)
      }
    }
    usleep(140000)
  }
}
