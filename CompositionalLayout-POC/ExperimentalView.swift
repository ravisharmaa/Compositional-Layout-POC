//
//  ExperimentalView.swift
//  CompositionalLayout-POC
//
//  Created by Ravi Bastola on 3/22/20.
//  Copyright © 2020 Ravi Bastola. All rights reserved.
//

import SwiftUI



struct ExperimentalView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ExperimentalView>) -> ViewController {
        
        let viewController = ViewController()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<ExperimentalView>) {
        
    }
    
    typealias UIViewControllerType = ViewController
    
    
}

struct ExperimentalView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentalView().edgesIgnoringSafeArea(.all)
    }
}
