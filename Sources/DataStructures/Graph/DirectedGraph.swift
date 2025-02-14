//
//  DirectedGraph.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Unweighted, directed graph.
public struct DirectedGraph <Node: Hashable>: UnweightedGraphProtocol, DirectedGraphProtocol {

    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var nodes: Set<Node>

    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `OrderedPair` of `Node` values.
    public var edges: Set<Edge>
}

extension DirectedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    public typealias Edge = OrderedPair<Node>
}

extension DirectedGraph {

    // MARK: - Initializers

    /// Creates a `DirectedGraph` with the given set of nodes, with no edges between the nodes.
    @inlinable
    public init(_ nodes: Set<Node> = []) {
        self.nodes = nodes
        self.edges = []
    }

    /// Creates a `DirectedGraph` with the given set of nodes and the given set of edges connecting the
    /// nodes.
    @inlinable
    public init(_ nodes: Set<Node> = [], _ edges: Set<Edge> = []) {
        self.init(nodes)
        self.edges = edges
    }

    /// Creates a `DirectedGraph` which is composed a path of nodes.
    @inlinable
    public init <C> (path: C) where C: Collection, C.Element == Node {
        self.nodes = Set(path)
        self.edges = Set(nodes.pairs.map(OrderedPair.init))
    }

    /// Creates a `DirectedGraph` with enough memory to store the given `minimumNodesCapacity` and
    /// `minimumEdgesCapacity`.
    public init(minimumNodesCapacity: Int, minimumEdgesCapacity: Int) {
        self.nodes = Set(minimumCapacity: minimumNodesCapacity)
        self.edges = Set(minimumCapacity: minimumEdgesCapacity)
    }
}

extension DirectedGraph: Equatable { }
extension DirectedGraph: Hashable { }
