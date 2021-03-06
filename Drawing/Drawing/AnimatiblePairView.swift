//
//  AnimatiblePairView.swift
//  Drawing
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI

struct AnimatiblePairView: View {
        @State private var rows = 4
        @State private var columns = 4

        var body: some View {
            Checkerboard(rows: rows, columns: columns)
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        rows = 8
                        columns = 16
                }
            }
        }
    }


struct AnimatiblePairView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatiblePairView().preferredColorScheme(.dark)
    }
}
