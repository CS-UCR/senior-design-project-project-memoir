// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
