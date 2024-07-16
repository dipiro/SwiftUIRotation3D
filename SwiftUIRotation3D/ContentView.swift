//
//  ContentView.swift
//  SwiftUIRotation3D
//
//  Created by piro2 on 7/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var translation : CGSize = .zero
    @State private var isDragging = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            background
            icon
        }
        .rotation3DEffect(.degrees(isDragging ? 10 : 0),
                          axis: (x: -translation.height, y: translation.width, z: 0.0))
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        gestureAction(translation: value.translation, isDragging: true)
                    }
                }
                .onEnded { value in
                    withAnimation {
                        gestureAction(translation: .zero, isDragging: false)
                    }
                }
        )
        .ignoresSafeArea()
    }
}

// MARK: - Private
private extension ContentView {
    var background: some View {
        Image("space")
            .resizable()
            .scaledToFill()
            .frame(minHeight: 1050)
            .offset(x: translation.width / 17, y: translation.height / 17)
            .ignoresSafeArea()
    }
    
    var icon: some View {
        Image("spaceship")
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 250)
            .offset(x: translation.width / 3, y: translation.height / 3)
    }
    
    func gestureAction(translation: CGSize, isDragging: Bool) {
        self.translation = translation
        self.isDragging = isDragging
    }
}

#Preview {
    ContentView()
}
