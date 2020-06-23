//
//  OperationQueueController.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class OperationQueueController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        blockOperation()
//        operationSub()
//        operationQueue()
        operationDependencies()
//        operationQueueWithDispatchGroup()
    }
    

    func blockOperation()
    {
        let operation = BlockOperation
        {
            for i in 0...10
            {
                print("🧤 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        let thread = Thread {
            operation.start()
        }
        thread.start()
    }
    
    func operationSub()
    {
        let operation = MyOperation()
        operation.start()
        sleep(1)
        operation.cancel()
    }
    
    func operationQueue()
    {
        let operationQueue = OperationQueue()
        
        let blockOperations1 = BlockOperation
        {
            for i in 0 ... 4
            {
                print("👺 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        let blockOperations2 = BlockOperation
        {
            for i in 0 ... 4
            {
                print("😽 \(i)")
                print(Thread.isMainThread)
            }
        }
        operationQueue.maxConcurrentOperationCount = 1 //The maximum number of queued operations that can excute at the same time.
        operationQueue.addOperation(blockOperations1)
        operationQueue.addOperation(blockOperations2)
    }
    
    func operationDependencies()
    {
        let operationQueue = OperationQueue()
        
        let blockOperations1 = BlockOperation
        {
            for i in 0 ... 4
            {
                print("💩 \(i)")
            }
        }
        
        let blockOperations2 = BlockOperation
        {
            for i in 0 ... 4
            {
                print("🤩 \(i)")
            }
        }
        
        operationQueue.maxConcurrentOperationCount = 2
        blockOperations1.addDependency(blockOperations2)
        operationQueue.addOperation(blockOperations1)
        operationQueue.addOperation(blockOperations2)
    }
    
    func operationQueueWithDispatchGroup()
    {
        DispatchQueue.global().async
        {
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 4
            let blockOperations1 = BlockOperation
            {
                for i in 0 ... 90000
                {
                    print("🥳 \(i)")
                }
            }
            
            let blockOperations2 = BlockOperation
            {
                for i in 0 ... 90000
                {
                    print("🍔 \(i)")
                }
            }
            
            let blockOperations3 = BlockOperation
            {
                for i in 0 ... 90000
                {
                    print("🍌 \(i)")
                }
            }
            
            operationQueue.addOperations([blockOperations1,blockOperations2,blockOperations3], waitUntilFinished: true)
            print("All Operation is Completed")
        }
    }
}

class MyOperation: Operation
{

    override func start()
    {
        if isCancelled { return }
        Thread.init(block: main).start()
    }
    
    override func main()
    {
        for i in 0 ... 90000
        {
            if isCancelled { break }
            print("😍 \(i)")
            print(Thread.isMainThread)
        }
    }
    
    
}
