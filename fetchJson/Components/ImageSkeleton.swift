//
//  ImageSkeleton.swift
//  fetchJson
//
//  Created by Magistra Apta on 31/12/23.
//

import SwiftUI

struct ImageSkeleton: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.gray.opacity(0.5))
            .frame(height: 200)
            .overlay{
                Image(systemName: "gift")
                    .font(.system(size: 64))
                    .foregroundColor(Color.gray)
            }
    }
}

struct ImageSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        ImageSkeleton()
    }
}
