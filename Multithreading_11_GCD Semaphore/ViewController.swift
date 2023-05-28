//
//  ViewController.swift
//  Multithreading_11_GCD Semaphore
//
//  Created by Дмитрий Гусев on 25.05.2023.
//




//Охранник

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let semmm = SemaphorTest()
        semmm.startAllThread()
        
        let queue = DispatchQueue(label: "The swift Developer", attributes: .concurrent)
        
        let semaphore = DispatchSemaphore(value: 0)

        queue.async {
            semaphore.wait() // -1
            sleep(3)
            print("method 1")
            semaphore.signal() // +1
        }
        queue.async {
            semaphore.wait() // -1
            sleep(3)
            print("method 2")
            semaphore.signal() // +1
        }
        queue.async {
            semaphore.wait() // -1
            sleep(3)
            print("method 3")
            semaphore.signal() // +1
        }
        
        let sem = DispatchSemaphore(value: 0)
        
        DispatchQueue.concurrentPerform(iterations: 10) { id in
            sem.wait(timeout: .distantFuture)
            
            sleep(1)
            print("Block", String(id))
            
            sem.signal()
        }
        
        
        
        
        
      
    }


}

class SemaphorTest {
    private let semaph = DispatchSemaphore(value: 1)
    
    private var array = [Int]()
    
    private func meethodWork(_ id: Int) {
        semaph.wait() // -1
        
        array.append(id)
        print("test array, \(array.count)")
        
        Thread.sleep(forTimeInterval: 2)
        semaph.signal() // +1
    }
    
    public func startAllThread() {
        DispatchQueue.global().async {
            self.meethodWork(3242)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.meethodWork(5433)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.meethodWork(5672)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.meethodWork(0457)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.meethodWork(5882)
            print(Thread.current)
        }
    }
}
