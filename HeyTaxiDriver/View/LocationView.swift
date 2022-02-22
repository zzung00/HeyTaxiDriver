//
//  LocationView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/22.
//

import SwiftUI

struct LocationView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        switch viewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(viewModel)
            
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
            
        case .denied:
            ErrorView(errorText: "Please enable them in settings.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            TrackingView()
                .environmentObject(viewModel)
            
        default:
            Text("Unexpected status")
        }
    }
}

struct RequestLocationView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.blue)
            Button(action: {print("allowing perms")}, label: {Label("Allow tracking", systemImage: "location")})
                .padding(10)
                .foregroundColor(.white)
                .background(Color.mainGreen)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track u.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
    }
}

struct TrackingView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        Text("Thanks!!!")
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
