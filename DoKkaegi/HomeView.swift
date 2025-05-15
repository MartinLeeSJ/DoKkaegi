//
//  HomeView.swift
//  DoKkaegi
//
//  Created by Martin on 5/6/25.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State private var navigation: NavigationCoordinator = .init()
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ZStack {
                Image(.mainBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 50)
                    
                Image(.mainBackground)
                    .resizable()
                    .scaledToFit()
                    .mask {
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.05),
                                .init(color: .black, location: 0.2),
                                .init(color: .black, location: 0.7),
                                .init(color: .clear, location: 0.95),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                VStack {
                    Spacer()
                    Text("도장을 깨볼까? 등의 흥미를 돋구는 안내멘트")
                    Spacer()
                    Button {
                        navigation.push(appPath: .loading)
                    } label: {
                        Text("시작하기")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.brown)
                    }
                    .padding()
                    Spacer()
                }
            }
            .navigationDestination(for: AppPath.self) { path in
                Group {
                    switch path {
                    case .loading: LoadingView()
                    case .finding: Text("Finding...")
                    case .result: Text("Result...")
                    case .record: Text("Record...")
                    }
                }
                .environment(navigation)
            }
            
        }
    }
}

@Observable
class HomeViewModel: NSObject {
    var dojang: Dojang?
    
    private let manager: CLLocationManager
    
    override init() {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager = locationManager
        
        super.init()
        locationManager.delegate = self
    }
    
    
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        
    }
}

struct Dojang {
    var name: String?
    private(set)var coordinate: CLLocationCoordinate2D
    private(set)var state: DonjangState
    private(set)var createdAt: Date
    private(set)var foundAt: Date?
    
    //TODO: 사진을 저장할 수 있을지?
    enum DonjangState {
        case created
        case found
        case failed
        case weirdo
    }
    
    init(
        base: CLLocationCoordinate2D,
        radiusInMeters: Double = 1000,
        coordinate: CLLocationCoordinate2D
    ) {
        self.coordinate = Self.randomCoordinate(from: base, radiusInMeters: radiusInMeters)
        self.createdAt = Date.now
        self.state = .created
    }
    
    private static func randomCoordinate(
        from base: CLLocationCoordinate2D,
        radiusInMeters: Double
    ) -> CLLocationCoordinate2D {
        let earthRadius = 6371000.0 // m
        
        let deltaLat = (Double.random(in: -1...1) * radiusInMeters) / earthRadius
        let deltaLon = (Double.random(in: -1...1) * radiusInMeters) / (earthRadius * cos(base.latitude * .pi / 180))
        
        let newLat = base.latitude + deltaLat * (180 / .pi)
        let newLon = base.longitude + deltaLon * (180 / .pi)
        
        return CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
    }
}

#Preview {
    HomeView()
        .environment(NavigationCoordinator())
}
