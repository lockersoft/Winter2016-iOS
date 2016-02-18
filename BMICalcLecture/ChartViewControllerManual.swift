//
//  ChartViewController.swift
//  BMICalcLecture
//
//  Created by Jones, Dave on 2/8/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var chartImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(chartImage)
        chartImage.image = drawDavesChart( chartImage.bounds.size )
    }

    
    func drawDavesChart( size : CGSize ) -> UIImage {
        UIGraphicsBeginImageContext( size )
        let context = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 50, 10)
        CGContextAddLineToPoint(context, 10, 300)
        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 4.0)
        CGContextSetRGBStrokeColor(context, 255, 0, 0, 1.0)
        
        CGContextStrokePath(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
