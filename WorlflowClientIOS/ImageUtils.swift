//
//  ImageUtils.swift
//  WorlflowClientIOS
//
//  Created by Danny Lin on 2015/12/15.
//  Copyright © 2015年 Daz. All rights reserved.
//

import Foundation

class ImageUtils {
 
    class func correctlyOrientedImage(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImageOrientation.Up {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return normalizedImage;
    }
    
}
