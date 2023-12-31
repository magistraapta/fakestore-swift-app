//
//  TextSkeleton.swift
//  fetchJson
//
//  Created by Magistra Apta on 31/12/23.
//

import SwiftUI

struct TextSkeleton: View {
    var body: some View {
        VStack(alignment: .leading){
            Rectangle()
                .frame(width: 300, height: 20)
                .foregroundColor(Color.gray.opacity(0.5))
            Rectangle()
                .frame(width: 280, height: 20)
                .foregroundColor(Color.gray.opacity(0.5))
            Rectangle()
                .frame(width: 250, height: 20)
                .foregroundColor(Color.gray.opacity(0.5))
        }
    }
}

struct TextSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        TextSkeleton()
    }
}
