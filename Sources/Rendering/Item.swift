//
//  Item.swift
//  Rendering
//
//  Created by James Bean on 7/25/17.
//
//

import Geometry

public enum Item {

    case path(StyledPath)
    case text(Text)

    public var frame: Rectangle {
        switch self {
        case .path(let path):
            return path.frame
        case .text(let text):
            return text.frame
        }
    }

    public var resizedToFitContents: Item {
        switch self {
        case .path(let renderedPath):
            return .path(renderedPath.resizedToFitContents)
        case .text:
            fatalError()
        }
    }

    public func translated(by point: Point) -> Item {
        switch self {
        case .path(let renderedPath):
            return .path(renderedPath.translated(by: point))
        case .text:
            fatalError()
        }
    }
}
