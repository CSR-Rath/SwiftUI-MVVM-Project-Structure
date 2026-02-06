//
//  CompassRotatingLabelView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 6/2/26.
//

import SwiftUI

struct CompassDegreeLabelsView: View {

    let heading: Double

    private let labels = [
        "", "N1","", "N2","", "N3", "", "Ne1", "", "Ne2","", "Ne3",
        "", "E1","", "E2","","E3", "", "Se1","", "Se2","", "Se3",
        "", "S1","", "S2","", "S3","", "Sw1","", "Sw2","", "Sw3",
        "", "W1","", "W2","","W3", "", "Nw1","", "Nw2", "","Nw3"
    ]

    var body: some View {
        ZStack {
            ForEach(labels.indices, id: \.self) { i in
                CompassRotatingLabelView(
                    text: labels[i],
                    degree: Double(i) * 7.5,
                    heading: heading,
                    font: .system(size: 12, weight: .regular),
                    color: .primary
                )
            }
        }
    }
}

struct CompassCardinalDirectionsView: View {

    let heading: Double
    private let labels = ["N", "E", "S", "W"]

    var body: some View {
        ZStack {
            ForEach(labels.indices, id: \.self) { i in
                CompassRotatingLabelView(
                    text: labels[i],
                    degree: (Double(i) * 90) + 22.5,
                    heading: heading,
                    font: .system(size: 20, weight: .bold),
                    color: .red
                )
            }
        }
    }
}

struct CompassRotatingLabelView: View {

    let text: String
    let degree: Double
    let heading: Double
    let font: Font
    let color: Color

    var body: some View {
        VStack {
            Text(text)
                .font(font)
                .foregroundColor(color)
                .rotationEffect(.degrees(heading - degree))

            Spacer()
        }
        .rotationEffect(.degrees(degree))
    }
}
