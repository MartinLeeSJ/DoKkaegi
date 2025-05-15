//
//  LoadingView.swift
//  DoKkaegi
//
//  Created by Martin on 5/10/25.
//

import SwiftUI

struct LoadingView: View {
    @Environment(NavigationCoordinator.self) private var navigation
    var body: some View {
        VStack {
            Text("Loading...")
        }
        .task {
            try? await Task.sleep(for: .seconds(3))
            navigation.push(appPath: .finding)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LoadingView()
    }
    .environment(NavigationCoordinator())
}
