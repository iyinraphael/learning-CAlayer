/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CAScrollLayerViewController: UIViewController {
  @IBOutlet weak var scrollingView: ScrollingView!
  @IBOutlet weak var horizontalScrollingSwitch: UISwitch!
  @IBOutlet weak var verticalScrollingSwitch: UISwitch!

  var scrollingViewLayer: CAScrollLayer {
    // swiftlint:disable:next force_cast
    return scrollingView.layer as! CAScrollLayer
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollingViewLayer.scrollMode = .both
  }
}

// MARK: - IBActions
extension CAScrollLayerViewController {
  @IBAction func panRecognized(_ sender: UIPanGestureRecognizer) {
    
    /**
        When a pan gesture occurs, you calculate the corresponding translation required
        and then call the scroll(to:) method on the CAScrollayer to move the image accordingly.
     
        scroll(to:) dosen't animate automatically, so you animate it explecitiy using UIView.animate(withDuration: animations:)
     */
    
    var newPoint = scrollingView.bounds.origin
    newPoint.x -= sender.translation(in: scrollingView).x
    newPoint.y -= sender.translation(in: scrollingView).y
    sender.setTranslation(.zero, in: scrollingView)
    scrollingViewLayer.scroll(to: newPoint)
    
    if sender.state == .ended {
      UIView.animate(withDuration: 0.3) {
        self.scrollingViewLayer.scroll(to: CGPoint.zero)
      }
    }
  }
  
  
  /**
    Here are some rules of thumb for when to use - or not to use - CAScrollLayer
        >   If you want something lightweight and you only neeed to scroll programmatically, consider using CAScrollLayer.
        >   When you wnat the user to be able to scroll, you're better off with UIScrollView.
        >   If you're scrolling a very large image, consider using CATiledLayer
   */

  @IBAction func scrollingSwitchChanged(_ sender: UISwitch) {
    
    switch (horizontalScrollingSwitch.isOn, verticalScrollingSwitch.isOn) {
    case (true, true):
      scrollingViewLayer.scrollMode = .both
    case (true, false):
      scrollingViewLayer.scrollMode = .horizontally
    case (false, true):
      scrollingViewLayer.scrollMode = .vertically
    default:
      scrollingViewLayer.scrollMode = .none
      
    }
  }
}
