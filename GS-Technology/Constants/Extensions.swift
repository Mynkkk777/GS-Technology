//
//  Extensions.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import Foundation
import UIKit

extension StoryBoards {
    
    func getStoryBoard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle : nil)
    }
}
//pop kidhar se hota hai
extension UIViewController {
    func presentMenu(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.reveal //push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)

    }
    
    func presentDetails(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)

    }
    //Left to right => for present LEft menu and right to left => for dismiss. //nahi toh library hai. Mai study krta hu ispe. OK.Close karu ya kuch aur ? Nhi thankssss bhaiii wc by
    func dismissMenu(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push //push
        transition.subtype = CATransitionSubtype.fromRight//fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
        
    }
    func dismissMenuLeft(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
        
    }
    func setImgTintColor(_ imgArr: [UIImageView],color: UIColor){
    for img in imgArr{
        let template = img.image?.withRenderingMode(.alwaysTemplate)
        img.image = template
        img.tintColor = color
    }
    
}

func hexStringToUIColor(_ hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
    
    
    func loadingView(flag : Bool){
            DispatchQueue.main.async(execute: {
                var inloading = false
                for vew in self.view.subviews {
                    if vew.tag == 999 {
                        inloading = true
                        break
                    }
                }
                if flag {
                    if !inloading {
                        let wd = UIScreen.main.bounds.width
                        let ht = UIScreen.main.bounds.height
                        let v = UIView(frame: CGRect(x: 0,y : 0,width : wd, height : ht))
                        v.tag = 999
                        v.backgroundColor = BLURCOLOR
                        let activityView = UIActivityIndicatorView(style: .whiteLarge)
                        activityView.center = v.center
                        activityView.startAnimating()
                        v.addSubview(activityView)
                        self.view.addSubview(v)
                    }
                }
                else {
                    if inloading {
                        for vew in self.view.subviews {
                            if vew.tag == 999 {
                                vew.removeFromSuperview()
                                break
                            }
                        }
    //                    let c = self.view.subviews.count
    //                    self.view.subviews[c-1].removeFromSuperview()
                    }

                }
            })
        }
    
    
    func alertWithCustomBtnCallback(title:String, message:String,buttonTitle:String, onClick:@escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: buttonTitle, style: .default) { (action) in

            onClick()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in

        }
        alertController.addAction(actionButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }

    
    
    
}

extension UIImage {
    func maskWithGradientColor(color: UIColor) -> UIImage? {
        
        let maskImage = self.cgImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil,
                                      width: Int(width),
                                      height: Int(height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo.rawValue)
        
        let locations:[CGFloat] = [0.0, 1.0]
        let bottom = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        let top = UIColor(red: 0, green: 1, blue: 0, alpha: 0).cgColor
        let colors = [top, bottom] as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        let startPoint = CGPoint(x: width/2, y: 0)
        let endPoint = CGPoint(x: width/2, y: height)
        
        bitmapContext!.clip(to: bounds, mask: maskImage!)
        bitmapContext!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        if let cImage = bitmapContext!.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            return coloredImage
        }
        else  {
            return nil
        }
    }
}

extension APPCOLORS {
    func toColor() -> UIColor {
        var cString:String = self.rawValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
    }
}
