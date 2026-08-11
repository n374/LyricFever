//
//  KaraokeBackgroundMode.swift
//  Lyric Fever
//

import SwiftUI

// What fills the karaoke panel behind the lyric text.
enum KaraokeBackgroundMode: Int, CaseIterable, Identifiable {
    // Color sampled from the currently playing album's artwork. The original default.
    case albumColor = 0
    // A user-picked fixed color, for when the album's color doesn't suit.
    case fixedColor = 1
    // No fill at all, not even the frosted NSVisualEffectView blur behind the other two modes, so
    // the lyrics float directly over whatever is on the desktop. karaokeTransparency has nothing
    // left to fade in this mode, so KaraokeSettingsView hides that slider for it.
    case transparent = 2

    var id: Int { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .albumColor:
            return "Use album color"
        case .fixedColor:
            return "Use a fixed color"
        case .transparent:
            return "Transparent (no background)"
        }
    }
}
