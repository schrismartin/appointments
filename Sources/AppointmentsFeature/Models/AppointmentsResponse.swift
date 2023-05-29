import Foundation
import Primitives

public struct AppointmentsResponse: Codable, Equatable {
  public var appointments: [Appointment]
  
  public struct Appointment: Codable, Equatable, Identifiable {
    public var id: String
    public var professional: Professional
    public var user: User
    public var startTime: Date
    public var endTime: Date
    public var length: TimeInterval
    public var topic: String
    public var status: Status
    public var requestedAt: Date
    public var lastMessage: String?
    public var lastMessageAt: Date?
    
    public struct Professional: Codable, Equatable, Identifiable {
      public var id: Int
      public var firstName: String
      public var lastName: String
      public var jobTitle: JobTitle
      
      public enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case jobTitle
      }
      
      public enum JobTitle: String, Codable, FallbackRawRepresentable, Equatable {
        case dvm = "DVM"
        
        case unhandled
      }
    }
    
    public struct User: Codable, Equatable, Identifiable {
      public var id: Int
      public var firstName: String
      public var lastName: String
      
      public enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
      }
      
      var components: PersonNameComponents {
        var components = PersonNameComponents()
        components.givenName = firstName
        components.familyName = lastName
        return components
      }
    }
    
    public enum Status: String, Codable, FallbackRawRepresentable, Equatable {
      case active = "ACTIVE"
      case completed = "COMPLETED"
      case initiated = "INITIATED"
      case requested = "REQUESTED"
      
      case unhandled
    }
  }
}
