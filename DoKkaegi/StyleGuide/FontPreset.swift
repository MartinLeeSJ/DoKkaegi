//
//  FontPreset.swift
//  DoKkaegi
//
//  Created by Martin on 5/15/25.
//

import Foundation

enum FontPreset {
    case largeTitle
    case title
    case subtitle
    case body
    case caption
}

extension FontPreset {
    var fontName: String {
           return switch self {
           case .largeTitle:
               "SeoulAlrimTTF-ExtraBold"
           case .title:
               "SeoulAlrimTTF-Bold" // 필요 시 .Medium, .EB, .Heavy 버전으로 바꿔서 조합 가능
           case .subtitle, .body, .caption:
               "SeoulAlrimTTF-Medium"
           }
       }
    var size: CGFloat {
            switch self {
            case .largeTitle:
                return 36
            case .title:
                return 28
            case .subtitle:
                return 20
            case .body:
                return 16
            case .caption:
                return 12
            }
        }
}
