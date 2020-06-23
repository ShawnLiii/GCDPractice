//
//  OperationPracticeController.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/22/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class OperationPracticeController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    let imageUrl1 = "https://www.telecomreviewasia.com/images/stories/2019/12/Big-Data-Asias-newest-socio-economic-ally.jpg"
    let imageUrl2 = "https://www.verdict.co.uk/wp-content/uploads/2020/01/Leading-data-trends-in-big-data-600x450.jpg"
    let imageUrl3 = "https://bbvaopen4u.com/sites/default/files/styles/big-image/public/img/new/imagen_1_10.png"
    let viewModel = ViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        executeOperationQueue()
    }
    
    func executeOperationQueue()
    {
        let operationQueue = OperationQueue()

        let blockOperations1 = BlockOperation
        {
            self.viewModel.getImage(url: self.imageUrl1)
            { (image) in
                OperationQueue.main.addOperation
                    {
                        self.imageView1.image = image
                }
            }
        }
        
        let blockOperations2 = BlockOperation
        {
            self.viewModel.getImage(url: self.imageUrl2)
            { (image) in
                OperationQueue.main.addOperation
                    {
                        self.imageView2.image = image
                }
                
            }
        }
        
        let blockOperations3 = BlockOperation
        {
            self.viewModel.getImage(url: self.imageUrl3)
            { (image) in
                OperationQueue.main.addOperation
                    {
                        self.imageView3.image = image
                }
                
            }
        }
        
        blockOperations3.addDependency(blockOperations2)
        blockOperations2.addDependency(blockOperations1)
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.addOperations([blockOperations1,blockOperations2,blockOperations3], waitUntilFinished: false)
     
    }
    
}
