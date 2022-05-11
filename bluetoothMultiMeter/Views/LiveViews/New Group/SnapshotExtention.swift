//
//  SnapshotExtention.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/9/22.
//
//  Source Code From https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image

import SwiftUI
import Foundation

//extension View {
//
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//
//        let targetSize = controller.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: false)
//        }
//    }
//
//}

    extension View {
        
        func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (UIImage) -> Void) {
            let size = CGSize(width: width, height: height)
            
            let controller = UIHostingController(rootView: self.frame(width: width, height: height))
            controller.view.bounds = CGRect(origin: .zero, size: size)
            let image = controller.view.asImage()
            
            completion(image)
        }
    }

    extension UIView {
        func asImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
            return renderer.image { ctx in
                self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            }
        }
    }
