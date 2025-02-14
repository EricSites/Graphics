//
//  AVLTree.swift
//  DataStructures
//
//  Created by James Bean on 9/9/18.
//

import Destructure

/// Copy-on-write self-balancing binary search tree.
public struct AVLTree <Key: Comparable, Value> {

    // MARK: - Instance Properties

    /// The root node of this `AVLTree`.
    public var root: Node?

    /// Creates an `AVLTree` with the given `root` node.
    @inlinable
    public init(root: Node? = nil) {
        self.root = root
    }
}

extension AVLTree {

    // MARK: - Nested Types

    /// Node for an `AVLTree` which contains a `key`, and `value`, along with the `left` and `right`
    /// child nodes (if they exist), as well as its `height`.
    public final class Node {

        // MARK: - Instance Properties

        // MARK: Key and Value

        /// The key used to keep this node sorted within an `AVLTree`.
        public var key: Key

        /// The payload contained herein.
        public var value: Value

        // MARK: Child nodes

        /// The node storing values with keys less than this one.
        public var left: Node?

        /// The node storing values with keys greater than this one.
        public var right: Node?

        // MARK: Position

        /// The height of this node within an `AVLTree`.
        public var height: Int

        // MARK: - Initializers

        /// Creates an `AVLTree.Node` with the given `key`, `value`, and `height`.
        @inlinable
        public init(key: Key, value: Value, height: Int = 1) {
            self.key = key
            self.value = value
            self.height = height
        }
    }
}

extension AVLTree {

    // MARK: - Initializers

    /// Creates an `AVLTree` with the given `key` and `value` for the `root` node.
    @inlinable
    public init(key: Key, value: Value) {
        self.root = Node(key: key, value: value)
    }

    /// Creates an `AVLTree` with the given `sequence` of key-value pairs.
    @inlinable
    public init <S> (_ sequence: S) where S: Sequence, S.Element == (Key,Value) {
        self.init()
        sequence.forEach { key,value in insert(value, forKey: key) }
    }
}

extension AVLTree {

    // MARK: - Computed Properties

    /// - Returns: An array of key-value pairs in sorted order.
    @inlinable
    public var inOrder: [(Key,Value)] {
        func traverse(_ node: Node, into result: inout [(Key,Value)]) -> [(Key,Value)] {
            let left = node.left.map { traverse($0, into: &result ) } ?? []
            let right = node.right.map { traverse($0, into: &result) } ?? []
            return left + [(node.key,node.value)] + right
        }
        var result: [(Key,Value)] = []
        guard let root = root else { return result }
        return traverse(root, into: &result)
    }
}

extension AVLTree {

    // MARK: - Instance Methods

    /// Inserts the given `value` for the given `key`.
    @inlinable
    public mutating func insert(_ value: Value, forKey key: Key) {
        ensureUnique()
        if let node = root {
            root = AVLTree.insert(value, forKey: key, into: node)
        } else {
            root = Node(key: key, value: value)
        }
    }

    @usableFromInline
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&root) {
            self = AVLTree(root: root)
        }
    }

    // FIXME: If Value is RangeRepleceableCollection (or Additive?), instead of returning `node`
    // upon interval match, concatenate incoming `value` with extant value.
    @usableFromInline
    @discardableResult
    static func insert(_ value: Value, forKey key: Key, into node: Node? = nil) -> Node? {
        guard let node = node else { return Node(key: key, value: value) }
        if node.key > key {
            node.left = insert(value, forKey: key, into: node.left)
        } else if node.key < key {
            node.right = insert(value, forKey: key, into: node.right)
        } else {
            return node
        }
        return balance(node, with: key)
    }

    /// Balances an `AVLTree` to ensure that leaf no path is no more than one longer than any other.
    @inlinable
    public static func balance(_ node: Node, with key: Key) -> Node {
        node.updateHeight()
        let balance = balanceFactor(node.left, node.right)
        if balance > 1 && key < node.left!.key {
            return rotateRight(node)
        } else if balance < -1 && key > node.right!.key {
            return rotateLeft(node)
        } else if balance > 1 && key > node.left!.key {
            node.left = rotateLeft(node.left!)
            return rotateRight(node)
        } else if balance < -1 && key < node.right!.key {
            node.right = rotateRight(node.right!)
            return rotateLeft(node)
        }
        return node
    }

    // TODO: removeValue(forKey key: Key) -> Node?

    @usableFromInline
    static func balanceFactor(_ left: Node?, _ right: Node?) -> Int {
        return (left?.height ?? -1) - (right?.height ?? -1)
    }

    @usableFromInline
    static func rotateLeft(_ node: Node) -> Node {
        guard let newRoot = node.right else { return node }
        node.right = newRoot.left
        newRoot.left = node
        node.updateHeight()
        newRoot.updateHeight()
        return newRoot
    }

    @usableFromInline
    static func rotateRight(_ node: Node) -> Node {
        guard let newRoot = node.left else { return node }
        node.left = newRoot.right
        newRoot.right = node
        node.updateHeight()
        newRoot.updateHeight()
        return newRoot
    }
}

extension AVLTree.Node {

    @usableFromInline
    func updateHeight() {
        self.height = max(left?.height ?? 0, right?.height ?? 0) + 1
    }
}

extension AVLTree.Node: Equatable where Value: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if the two given `AVLTree.Node` values are equivalent. Otherwise, `nil`.
    public static func == (lhs: AVLTree.Node, rhs: AVLTree.Node) -> Bool {
        guard lhs.key == rhs.key, lhs.value == rhs.value else { return false }
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

extension AVLTree: Equatable where Value: Equatable { }

extension AVLTree: ExpressibleByArrayLiteral {

    // MARK: - ExpressibleByArrayLiteral

    /// Creates an `AVLTree` with an array literal of key-value pairs.
    public init(arrayLiteral elements: (Key,Value)...) {
        self.init(elements)
    }
}
