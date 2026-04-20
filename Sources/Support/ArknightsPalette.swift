//
//  ArknightsPalette.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct ArknightsPalette {
    let pageBackground: Color
    let surface: Color
    let surfaceSoft: Color

    let textPrimary: Color
    let textBright: Color
    let textMuted: Color
    let textInverse: Color

    let accent: Color
    let accentSecondary: Color
    let danger: Color

    let border: Color
    let borderSoft: Color

    let codeBackground: Color
}



extension ArknightsPalette {
    static let dark = ArknightsPalette(
        pageBackground: Color(hex: "#141516"),
        surface: Color(hex: "#141516"),
        surfaceSoft: Color(white: 1, opacity: 0.05),

        textPrimary: Color(hex: "#C4C4C4"),
        textBright: Color(hex: "#FFFFFF"),
        textMuted: Color(hex: "#898989"),
        textInverse: Color(hex: "#000000"),

        accent: Color(hex: "#22BBFF"),
        accentSecondary: Color(hex: "#FFEE22"),
        danger: Color(hex: "#C0392B"),

        border: Color(hex: "#FFEE22"),
        borderSoft: Color(white: 1, opacity: 0.10),

        codeBackground: Color(white: 1, opacity: 0.05)
    )
    
    static let light = ArknightsPalette(
        pageBackground: Color(hex: "#F4F5F6"),
        surface: Color(hex: "#F4F5F6"),
        surfaceSoft: Color(white: 1, opacity: 0.05),

        textPrimary: Color(hex: "#222222"),
        textBright: Color(hex: "#000000"),
        textMuted: Color(hex: "#767676"),
        textInverse: Color(hex: "#FFFFFF"),

        accent: Color(hex: "#22BBFF"),
        accentSecondary: Color(hex: "#FFEE22"),
        danger: Color(hex: "#C0392B"),

        border: Color(hex: "#FFEE22"),
        borderSoft: Color(white: 1, opacity: 0.10),

        codeBackground: Color(white: 1, opacity: 0.05)
    )
}
