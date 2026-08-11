//
//  TextOutlineModifier.swift
//  Lyric Fever
//

import SwiftUI

// Keeps white lyric text readable over an arbitrary desktop background (the transparent karaoke
// mode) without the sticker/caption look a crisp solid-color outline gives text at this size.
// Two effects layer together, both tracing each glyph's own shape rather than a fixed-size box —
// SwiftUI has no public API to turn Text into a Path, so both lean on the same workaround: stack
// the same content offset a point or two in a ring of directions in a translucent color, then draw
// the real content on top. Their union follows every character's silhouette, thick or thin
// depending on the letterform:
// - A thin, low-opacity ring for guaranteed contrast on every side of every glyph, even against a
//   flat, uniformly bright desktop where a shadow alone (being one-directional) would leave the
//   opposite edge unreadable.
// - A soft, stacked shadow behind that for depth — two radii rather than one so the falloff reads
//   as a gradient instead of a single hard-edged blur ring.
struct TextOutlineModifier: ViewModifier {
    let color: Color
    let fill: Color
    let width: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat

    // 8 directions is enough to read as a continuous ring at the font sizes this panel uses; more
    // would cost extra draws for a difference nobody would see.
    private static let directions: [CGSize] = stride(from: 0.0, to: 360.0, by: 45.0).map { degrees in
        let radians = degrees * .pi / 180
        return CGSize(width: cos(radians), height: sin(radians))
    }

    func body(content: Content) -> some View {
        ZStack {
            ForEach(Array(Self.directions.enumerated()), id: \.offset) { _, direction in
                content
                    .foregroundStyle(color)
                    .offset(x: direction.width * width, y: direction.height * width)
            }
            content
                .foregroundStyle(fill)
        }
        .shadow(color: shadowColor, radius: shadowRadius)
        .shadow(color: shadowColor.opacity(0.6), radius: shadowRadius * 2.5)
    }
}

extension View {
    func textOutline(
        color: Color = .black.opacity(0.35),
        fill: Color = .white,
        width: CGFloat = 1,
        shadowColor: Color = .black.opacity(0.5),
        shadowRadius: CGFloat = 3
    ) -> some View {
        modifier(TextOutlineModifier(color: color, fill: fill, width: width, shadowColor: shadowColor, shadowRadius: shadowRadius))
    }
}
