// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct CreateAnchorInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - lat
  ///   - long
  ///   - alt
  ///   - entityId
  ///   - message
  ///   - authorId
  public init(lat: Swift.Optional<Double?> = nil, long: Swift.Optional<Double?> = nil, alt: Swift.Optional<Double?> = nil, entityId: Swift.Optional<GraphQLID?> = nil, message: Swift.Optional<String?> = nil, authorId: Swift.Optional<GraphQLID?> = nil) {
    graphQLMap = ["lat": lat, "long": long, "alt": alt, "entity_id": entityId, "message": message, "author_id": authorId]
  }

  public var lat: Swift.Optional<Double?> {
    get {
      return graphQLMap["lat"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lat")
    }
  }

  public var long: Swift.Optional<Double?> {
    get {
      return graphQLMap["long"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "long")
    }
  }

  public var alt: Swift.Optional<Double?> {
    get {
      return graphQLMap["alt"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alt")
    }
  }

  public var entityId: Swift.Optional<GraphQLID?> {
    get {
      return graphQLMap["entity_id"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "entity_id")
    }
  }

  public var message: Swift.Optional<String?> {
    get {
      return graphQLMap["message"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "message")
    }
  }

  public var authorId: Swift.Optional<GraphQLID?> {
    get {
      return graphQLMap["author_id"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "author_id")
    }
  }
}

public struct DeleteAnchorInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  public init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct CreateCommentInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - authorId
  ///   - body
  public init(authorId: Swift.Optional<GraphQLID?> = nil, body: Swift.Optional<String?> = nil) {
    graphQLMap = ["authorID": authorId, "body": body]
  }

  public var authorId: Swift.Optional<GraphQLID?> {
    get {
      return graphQLMap["authorID"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorID")
    }
  }

  public var body: Swift.Optional<String?> {
    get {
      return graphQLMap["body"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "body")
    }
  }
}

public struct CreateStoryInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - authorId
  ///   - body
  ///   - heading
  ///   - learnMore
  public init(authorId: GraphQLID, body: Swift.Optional<String?> = nil, heading: Swift.Optional<String?> = nil, learnMore: Swift.Optional<String?> = nil) {
    graphQLMap = ["authorID": authorId, "body": body, "heading": heading, "learn_more": learnMore]
  }

  public var authorId: GraphQLID {
    get {
      return graphQLMap["authorID"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorID")
    }
  }

  public var body: Swift.Optional<String?> {
    get {
      return graphQLMap["body"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "body")
    }
  }

  public var heading: Swift.Optional<String?> {
    get {
      return graphQLMap["heading"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "heading")
    }
  }

  public var learnMore: Swift.Optional<String?> {
    get {
      return graphQLMap["learn_more"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "learn_more")
    }
  }
}

public struct CreateUserInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - username
  ///   - createDate
  ///   - profileIcon
  ///   - status
  public init(id: Swift.Optional<GraphQLID?> = nil, username: Swift.Optional<String?> = nil, createDate: Swift.Optional<String?> = nil, profileIcon: Swift.Optional<String?> = nil, status: Swift.Optional<String?> = nil) {
    graphQLMap = ["id": id, "username": username, "create_date": createDate, "profile_icon": profileIcon, "status": status]
  }

  public var id: Swift.Optional<GraphQLID?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var username: Swift.Optional<String?> {
    get {
      return graphQLMap["username"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "username")
    }
  }

  public var createDate: Swift.Optional<String?> {
    get {
      return graphQLMap["create_date"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "create_date")
    }
  }

  public var profileIcon: Swift.Optional<String?> {
    get {
      return graphQLMap["profile_icon"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_icon")
    }
  }

  public var status: Swift.Optional<String?> {
    get {
      return graphQLMap["status"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "status")
    }
  }
}

public final class GetAnchorByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getAnchorByID($id: ID!) {
      getAnchor(id: $id) {
        __typename
        id
        create_date
        author_id
        message
        entity_id
        lat
        long
        alt
      }
    }
    """

  public let operationName: String = "getAnchorByID"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAnchor", arguments: ["id": GraphQLVariable("id")], type: .object(GetAnchor.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAnchor: GetAnchor? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAnchor": getAnchor.flatMap { (value: GetAnchor) -> ResultMap in value.resultMap }])
    }

    public var getAnchor: GetAnchor? {
      get {
        return (resultMap["getAnchor"] as? ResultMap).flatMap { GetAnchor(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getAnchor")
      }
    }

    public struct GetAnchor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Anchor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("author_id", type: .scalar(GraphQLID.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("entity_id", type: .scalar(GraphQLID.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("long", type: .scalar(Double.self)),
          GraphQLField("alt", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, authorId: GraphQLID? = nil, message: String? = nil, entityId: GraphQLID? = nil, lat: Double? = nil, long: Double? = nil, alt: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "Anchor", "id": id, "create_date": createDate, "author_id": authorId, "message": message, "entity_id": entityId, "lat": lat, "long": long, "alt": alt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var authorId: GraphQLID? {
        get {
          return resultMap["author_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "author_id")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var entityId: GraphQLID? {
        get {
          return resultMap["entity_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_id")
        }
      }

      public var lat: Double? {
        get {
          return resultMap["lat"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var long: Double? {
        get {
          return resultMap["long"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "long")
        }
      }

      public var alt: Double? {
        get {
          return resultMap["alt"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "alt")
        }
      }
    }
  }
}

public final class ListAnchorsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query listAnchors($limit: Int, $nextToken: String) {
      listAnchors(limit: $limit, nextToken: $nextToken) {
        __typename
        nextToken
        items {
          __typename
          id
          create_date
          author_id
          message
          entity_id
          lat
          long
          alt
        }
      }
    }
    """

  public let operationName: String = "listAnchors"

  public var limit: Int?
  public var nextToken: String?

  public init(limit: Int? = nil, nextToken: String? = nil) {
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("listAnchors", arguments: ["limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListAnchor.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(listAnchors: ListAnchor? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "listAnchors": listAnchors.flatMap { (value: ListAnchor) -> ResultMap in value.resultMap }])
    }

    public var listAnchors: ListAnchor? {
      get {
        return (resultMap["listAnchors"] as? ResultMap).flatMap { ListAnchor(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "listAnchors")
      }
    }

    public struct ListAnchor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AnchorConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nextToken", type: .scalar(String.self)),
          GraphQLField("items", type: .list(.object(Item.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nextToken: String? = nil, items: [Item?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "AnchorConnection", "nextToken": nextToken, "items": items.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var nextToken: String? {
        get {
          return resultMap["nextToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "nextToken")
        }
      }

      public var items: [Item?]? {
        get {
          return (resultMap["items"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Item?] in value.map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Anchor"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("create_date", type: .scalar(String.self)),
            GraphQLField("author_id", type: .scalar(GraphQLID.self)),
            GraphQLField("message", type: .scalar(String.self)),
            GraphQLField("entity_id", type: .scalar(GraphQLID.self)),
            GraphQLField("lat", type: .scalar(Double.self)),
            GraphQLField("long", type: .scalar(Double.self)),
            GraphQLField("alt", type: .scalar(Double.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, createDate: String? = nil, authorId: GraphQLID? = nil, message: String? = nil, entityId: GraphQLID? = nil, lat: Double? = nil, long: Double? = nil, alt: Double? = nil) {
          self.init(unsafeResultMap: ["__typename": "Anchor", "id": id, "create_date": createDate, "author_id": authorId, "message": message, "entity_id": entityId, "lat": lat, "long": long, "alt": alt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var createDate: String? {
          get {
            return resultMap["create_date"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "create_date")
          }
        }

        public var authorId: GraphQLID? {
          get {
            return resultMap["author_id"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "author_id")
          }
        }

        public var message: String? {
          get {
            return resultMap["message"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var entityId: GraphQLID? {
          get {
            return resultMap["entity_id"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "entity_id")
          }
        }

        public var lat: Double? {
          get {
            return resultMap["lat"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var long: Double? {
          get {
            return resultMap["long"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "long")
          }
        }

        public var alt: Double? {
          get {
            return resultMap["alt"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "alt")
          }
        }
      }
    }
  }
}

public final class CreateAnchorMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation createAnchor($anchorInput: CreateAnchorInput!) {
      createAnchor(input: $anchorInput) {
        __typename
        id
        create_date
        author_id
        message
        entity_id
        lat
        long
        alt
      }
    }
    """

  public let operationName: String = "createAnchor"

  public var anchorInput: CreateAnchorInput

  public init(anchorInput: CreateAnchorInput) {
    self.anchorInput = anchorInput
  }

  public var variables: GraphQLMap? {
    return ["anchorInput": anchorInput]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createAnchor", arguments: ["input": GraphQLVariable("anchorInput")], type: .object(CreateAnchor.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createAnchor: CreateAnchor? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createAnchor": createAnchor.flatMap { (value: CreateAnchor) -> ResultMap in value.resultMap }])
    }

    public var createAnchor: CreateAnchor? {
      get {
        return (resultMap["createAnchor"] as? ResultMap).flatMap { CreateAnchor(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createAnchor")
      }
    }

    public struct CreateAnchor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Anchor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("author_id", type: .scalar(GraphQLID.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("entity_id", type: .scalar(GraphQLID.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("long", type: .scalar(Double.self)),
          GraphQLField("alt", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, authorId: GraphQLID? = nil, message: String? = nil, entityId: GraphQLID? = nil, lat: Double? = nil, long: Double? = nil, alt: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "Anchor", "id": id, "create_date": createDate, "author_id": authorId, "message": message, "entity_id": entityId, "lat": lat, "long": long, "alt": alt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var authorId: GraphQLID? {
        get {
          return resultMap["author_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "author_id")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var entityId: GraphQLID? {
        get {
          return resultMap["entity_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_id")
        }
      }

      public var lat: Double? {
        get {
          return resultMap["lat"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var long: Double? {
        get {
          return resultMap["long"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "long")
        }
      }

      public var alt: Double? {
        get {
          return resultMap["alt"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "alt")
        }
      }
    }
  }
}

public final class DeleteAnchorMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation deleteAnchor($anchorInput: DeleteAnchorInput!) {
      deleteAnchor(input: $anchorInput) {
        __typename
        id
        create_date
        author_id
        message
        entity_id
        lat
        long
        alt
      }
    }
    """

  public let operationName: String = "deleteAnchor"

  public var anchorInput: DeleteAnchorInput

  public init(anchorInput: DeleteAnchorInput) {
    self.anchorInput = anchorInput
  }

  public var variables: GraphQLMap? {
    return ["anchorInput": anchorInput]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteAnchor", arguments: ["input": GraphQLVariable("anchorInput")], type: .object(DeleteAnchor.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAnchor: DeleteAnchor? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteAnchor": deleteAnchor.flatMap { (value: DeleteAnchor) -> ResultMap in value.resultMap }])
    }

    public var deleteAnchor: DeleteAnchor? {
      get {
        return (resultMap["deleteAnchor"] as? ResultMap).flatMap { DeleteAnchor(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "deleteAnchor")
      }
    }

    public struct DeleteAnchor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Anchor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("author_id", type: .scalar(GraphQLID.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("entity_id", type: .scalar(GraphQLID.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("long", type: .scalar(Double.self)),
          GraphQLField("alt", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, authorId: GraphQLID? = nil, message: String? = nil, entityId: GraphQLID? = nil, lat: Double? = nil, long: Double? = nil, alt: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "Anchor", "id": id, "create_date": createDate, "author_id": authorId, "message": message, "entity_id": entityId, "lat": lat, "long": long, "alt": alt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var authorId: GraphQLID? {
        get {
          return resultMap["author_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "author_id")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var entityId: GraphQLID? {
        get {
          return resultMap["entity_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_id")
        }
      }

      public var lat: Double? {
        get {
          return resultMap["lat"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var long: Double? {
        get {
          return resultMap["long"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "long")
        }
      }

      public var alt: Double? {
        get {
          return resultMap["alt"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "alt")
        }
      }
    }
  }
}

public final class GetCommentByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getCommentByID($id: ID!) {
      getComment(id: $id) {
        __typename
        id
        create_date
        body
      }
    }
    """

  public let operationName: String = "getCommentByID"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getComment", arguments: ["id": GraphQLVariable("id")], type: .object(GetComment.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getComment: GetComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getComment": getComment.flatMap { (value: GetComment) -> ResultMap in value.resultMap }])
    }

    public var getComment: GetComment? {
      get {
        return (resultMap["getComment"] as? ResultMap).flatMap { GetComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getComment")
      }
    }

    public struct GetComment: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Comment"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("body", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, body: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Comment", "id": id, "create_date": createDate, "body": body])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var body: String? {
        get {
          return resultMap["body"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "body")
        }
      }
    }
  }
}

public final class CreateCommentMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation createComment($commentInput: CreateCommentInput!) {
      createComment(input: $commentInput) {
        __typename
        id
        create_date
        body
      }
    }
    """

  public let operationName: String = "createComment"

  public var commentInput: CreateCommentInput

  public init(commentInput: CreateCommentInput) {
    self.commentInput = commentInput
  }

  public var variables: GraphQLMap? {
    return ["commentInput": commentInput]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createComment", arguments: ["input": GraphQLVariable("commentInput")], type: .object(CreateComment.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createComment: CreateComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createComment": createComment.flatMap { (value: CreateComment) -> ResultMap in value.resultMap }])
    }

    public var createComment: CreateComment? {
      get {
        return (resultMap["createComment"] as? ResultMap).flatMap { CreateComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createComment")
      }
    }

    public struct CreateComment: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Comment"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("body", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, body: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Comment", "id": id, "create_date": createDate, "body": body])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var body: String? {
        get {
          return resultMap["body"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "body")
        }
      }
    }
  }
}

public final class GetStoryByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getStoryByID($id: ID!) {
      getStory(id: $id) {
        __typename
        id
        create_date
        heading
        body
      }
    }
    """

  public let operationName: String = "getStoryByID"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getStory", arguments: ["id": GraphQLVariable("id")], type: .object(GetStory.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getStory: GetStory? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getStory": getStory.flatMap { (value: GetStory) -> ResultMap in value.resultMap }])
    }

    public var getStory: GetStory? {
      get {
        return (resultMap["getStory"] as? ResultMap).flatMap { GetStory(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getStory")
      }
    }

    public struct GetStory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Story"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("heading", type: .scalar(String.self)),
          GraphQLField("body", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, heading: String? = nil, body: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Story", "id": id, "create_date": createDate, "heading": heading, "body": body])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var heading: String? {
        get {
          return resultMap["heading"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "heading")
        }
      }

      public var body: String? {
        get {
          return resultMap["body"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "body")
        }
      }
    }
  }
}

public final class CreateStoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation createStory($storyInput: CreateStoryInput!) {
      createStory(input: $storyInput) {
        __typename
        id
        create_date
        heading
        body
      }
    }
    """

  public let operationName: String = "createStory"

  public var storyInput: CreateStoryInput

  public init(storyInput: CreateStoryInput) {
    self.storyInput = storyInput
  }

  public var variables: GraphQLMap? {
    return ["storyInput": storyInput]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createStory", arguments: ["input": GraphQLVariable("storyInput")], type: .object(CreateStory.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createStory: CreateStory? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createStory": createStory.flatMap { (value: CreateStory) -> ResultMap in value.resultMap }])
    }

    public var createStory: CreateStory? {
      get {
        return (resultMap["createStory"] as? ResultMap).flatMap { CreateStory(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createStory")
      }
    }

    public struct CreateStory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Story"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("heading", type: .scalar(String.self)),
          GraphQLField("body", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, createDate: String? = nil, heading: String? = nil, body: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Story", "id": id, "create_date": createDate, "heading": heading, "body": body])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var heading: String? {
        get {
          return resultMap["heading"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "heading")
        }
      }

      public var body: String? {
        get {
          return resultMap["body"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "body")
        }
      }
    }
  }
}

public final class TestQueryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TestQuery {
      getUser(id: "753882cb-506a-402a-9ed0-ed14a413f368") {
        __typename
        id
        username
      }
    }
    """

  public let operationName: String = "TestQuery"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getUser", arguments: ["id": "753882cb-506a-402a-9ed0-ed14a413f368"], type: .object(GetUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUser: GetUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUser": getUser.flatMap { (value: GetUser) -> ResultMap in value.resultMap }])
    }

    public var getUser: GetUser? {
      get {
        return (resultMap["getUser"] as? ResultMap).flatMap { GetUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getUser")
      }
    }

    public struct GetUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }
    }
  }
}

public final class GetUserByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getUserByID($id: ID!) {
      getUser(id: $id) {
        __typename
        id
        username
        create_date
        status
        profile_icon
      }
    }
    """

  public let operationName: String = "getUserByID"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getUser", arguments: ["id": GraphQLVariable("id")], type: .object(GetUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUser: GetUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUser": getUser.flatMap { (value: GetUser) -> ResultMap in value.resultMap }])
    }

    public var getUser: GetUser? {
      get {
        return (resultMap["getUser"] as? ResultMap).flatMap { GetUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getUser")
      }
    }

    public struct GetUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("create_date", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
          GraphQLField("profile_icon", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String? = nil, createDate: String? = nil, status: String? = nil, profileIcon: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "create_date": createDate, "status": status, "profile_icon": profileIcon])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var profileIcon: String? {
        get {
          return resultMap["profile_icon"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_icon")
        }
      }
    }
  }
}

public final class CreateUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation createUser($userInput: CreateUserInput!) {
      createUser(input: $userInput) {
        __typename
        id
        username
        create_date
      }
    }
    """

  public let operationName: String = "createUser"

  public var userInput: CreateUserInput

  public init(userInput: CreateUserInput) {
    self.userInput = userInput
  }

  public var variables: GraphQLMap? {
    return ["userInput": userInput]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createUser", arguments: ["input": GraphQLVariable("userInput")], type: .object(CreateUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
    }

    public var createUser: CreateUser? {
      get {
        return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("create_date", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String? = nil, createDate: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "create_date": createDate])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var createDate: String? {
        get {
          return resultMap["create_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "create_date")
        }
      }
    }
  }
}
