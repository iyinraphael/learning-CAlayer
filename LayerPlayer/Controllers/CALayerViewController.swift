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

class CALayerViewController: UIViewController {
  @IBOutlet weak var viewForLayer: UIView!

  let layer = CALayer()

  // MARK: - View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLayer()
    viewForLayer.layer.addSublayer(layer)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "DisplayLayerControls" {
      (segue.destination as? CALayerControlsViewController)?.layerViewController = self
    }
  }
}

// MARK: - Layer
extension CALayerViewController {
  func setUpLayer() {
    /**
          1. You set the bounds of the layer, then set an image as the layer's constents.
            Notice the use of the underlying CGImage
     */
    
    layer.frame = viewForLayer.bounds
    layer.contents = UIImage(named: "star")?.cgImage
    
    /**
          2. Then you center the image within the layer. You can use contentsGravity to change both size
          — as in resizing, resizing aspect and resizing aspect fill — and position — center, top, top-right, right, etc.
          magnificationFilter controls the behavior of the enlarged image.
     */
    layer.contentsGravity = .center
    layer.magnificationFilter = .linear
    
    /**
          3. Next, you set CALayer‘s background color, make it round and add a border to it.
          Notice that you’re using the underlying CGColor objects to change the layer’s color attributes.
     */
    layer.cornerRadius = 100.0
    layer.borderWidth = 12.0
    layer.borderColor = UIColor.white.cgColor
    layer.backgroundColor = swiftOrangeColor.cgColor
    
    /**
          4. Finally, you create a shadow for the layer. When isGeometryFlipped is true,
          the positional geometry and shadow will be upside-down.
     */
    layer.shadowOpacity = 0.75
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3.0
    layer.isGeometryFlipped = false
  }
}
