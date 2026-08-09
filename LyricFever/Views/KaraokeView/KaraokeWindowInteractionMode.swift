//
//  KaraokeWindowInteractionMode.swift
//  Lyric Fever
//

import SwiftUI

// How the karaoke panel responds to the mouse.
enum KaraokeWindowInteractionMode: Int, CaseIterable, Identifiable {
    // Always visible; can be dragged at any time. The original Lyric Fever behaviour, and the
    // default for anyone who never touched "Hide Karaoke window when mouse passes by".
    case alwaysDraggable = 0
    // Hides while the mouse is over the panel, so it never gets in the way of what's underneath.
    case hideOnHover = 1
    // Same as hideOnHover, except holding Command before moving the mouse onto the panel keeps it
    // visible for that hover instead, so it can still be dragged without giving up hover-to-hide
    // the rest of the time. Command is only checked at the moment the mouse arrives — pressing or
    // releasing it while the mouse already sits on the panel has no effect until the mouse leaves
    // and comes back, which keeps the check a single NSEvent.modifierFlags read with no polling or
    // global key monitoring (and no Accessibility permission prompt) involved.
    case commandToDrag = 2

    var id: Int { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .alwaysDraggable:
            return "Always visible, draggable"
        case .hideOnHover:
            return "Hide when mouse passes by"
        case .commandToDrag:
            return "Hold ⌘ before moving mouse over it to drag, otherwise hide on hover"
        }
    }
}
