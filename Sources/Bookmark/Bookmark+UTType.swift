//
//  Bookmark+UTType.swift
//
//  Copyright © 2024 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import UniformTypeIdentifiers

public extension Bookmark {
	/// Returns the UTI for the bookmark's target
	func resolvedUTIString() throws -> String {
		let targetURL = try self.resolved().url
		guard
			let typeString = try targetURL.resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier
		else {
			throw BookmarkError.cantAccessTargetUTType
		}
		return typeString
	}

	/// Returns the UTI for the bookmark's target
	@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
	func resolvedUTI() throws -> UTType {
		let utiString = try self.resolvedUTIString()
		guard let t = UTType(utiString) else {
			throw BookmarkError.invalidTargetUTType
		}
		return t
	}
}
