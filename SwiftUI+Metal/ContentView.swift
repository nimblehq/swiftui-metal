//
//  ContentView.swift
//  SwiftUI+Metal
//
//  Created by MarkG on 17/01/2024.
//

import SwiftUI

struct ContentView: View {

    static let magnifierSize = CGSize(width: 100, height: 100)

    @State var pixellate: CGFloat = 10
    @State var magnifierPosition: CGPoint = .init(x: magnifierSize.width, y: magnifierSize.height / 2)

    var pixellateShader: Shader {
        .init(
            function: .init(
                library: .default,
                name: "pixellate"
            ),
            arguments: [
                .float(pixellate),
                .float2(
                    .init(
                        x: magnifierPosition.x - Self.magnifierSize.width / 2,
                        y: magnifierPosition.y - Self.magnifierSize.height / 2
                    )
                ),
                .float2(Self.magnifierSize.width, Self.magnifierSize.height)
            ]
        )
    }

    var body: some View {
        VStack {
            Image(.sample)
                .distortionEffect(
                    pixellateShader,
                    maxSampleOffset: .zero
                )
                .overlay(
                    manigierView,
                    alignment: .topLeading
                )
            Slider(value: $pixellate, in: 1...10)
        }
        .padding()
    }

    var manigierView: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .fill(.clear)
            .frame(
                width: Self.magnifierSize.width,
                height: Self.magnifierSize.height
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16.0)
                    .stroke(.white)
            )
            .contentShape(Rectangle())
            .position(magnifierPosition)
            .gesture(
                DragGesture()
                    .onChanged {
                        magnifierPosition = $0.location
                    }
            )
    }
}

#Preview {
    ContentView()
}
