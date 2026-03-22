//
//  DemoView.swift
//  Example for Pastel
//

import SwiftUI
import Pastel

@available(iOS 16.0, *)
struct DemoView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: PastelGradientView
                    PastelText("PastelGradientView", font: .headline, gradient: .youngPassion)
                    PastelGradientView(gradient: .youngPassion, duration: 3.0)
                        .frame(height: 200)
                        .cornerRadius(12)

                    // MARK: PastelText
                    PastelText("PastelText", font: .headline, gradient: .trueSunset)
                    PastelText("Hello, Pastel 🎨", font: .largeTitle, gradient: .trueSunset)

                    // MARK: .pastelBackground()
                    PastelText(".pastelBackground()", font: .headline, gradient: .ripeMalinka)
                    PastelText("ViewModifier Demo", font: .body, gradient: .warmFlame)
                        .padding()
                        .pastelBackground(.ripeMalinka)
                        .cornerRadius(12)

                }
                .padding()
            }
            .navigationTitle("Pastel Components")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("✕") { dismiss() }
                }
            }
        }
    }
}
