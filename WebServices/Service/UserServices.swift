//
//  UserServices.swift
//  StrataPanel
//
//  Created by Gaurang on 12/04/23.
//

import Foundation

enum UserServices {
    case dashboard
    case bills(page: Int, year: String, month: String)
    case billDetails(id: String)
    case billInvoiceDownload(id: String)
    case billAlreadyPaid(model: RequestModels.BillAlreadyPaid)
    case billPayment(billID: String)
    case paymentMethods
    case paymentHistory
    case myUnits
    case announcements(page: Int)
    case meetings(page: Int)
    case events(page: Int)
    case polls(page: Int)
    case pollsVote(pollId: String, option: String)
    case visitors(filter: RequestModels.VisitorFilter)
    case visitorHistory(filter: RequestModels.VisitorFilter)
    case visitorPreFill(phone: String)
    case directories(page: Int, type: String)
    case visitorAction(id: String, isAccepted: String, reason: String)
    case visitorCompanies
    case visitorAdd(model: RequestModels.AddVisitor, files: [MimeTypes])
    case visitorDefaultToggle(id: String)
    case amenities
    case bookedAmenities
    case bookAmenities(model: RequestModels.BookAmenities)
    case documents(type: String)
    case documentTypes
    case addDocuments(model: RequestModels.AddDocument, files: [MimeTypes])
    case ticketTypes
    case ticketCreate(model: RequestModels.CreateTicket, files: [MimeTypes])
    case ticketList(status: ComplaintType, page: Int)
    case ticketHistory(id: String)
    case addVehicle(model: RequestModels.AddVehicle)
    case vehicleList
    case vehicleSlots
    case updateProfile(photo: MimeTypes?, params: RequestModels.EditProfile)
    case feedback(rating: Int, comment: String)
    case notification(page: Int)
}

extension UserServices: TargetType {
    
    var baseURL: String {
        return Helper.apiBaseURL
    }
    
    var path: String {
        switch self {
        case .dashboard:            return "dashboard"
        case .bills:                return "bills"
        case .billDetails:          return "bill/detail"
        case .billInvoiceDownload:  return "bill/invoice/download"
        case .billAlreadyPaid:      return "bill/already_paid"
        case .paymentMethods:       return "bills/payment_methods"
        case .billPayment:          return "bill/payment"
        case .paymentHistory:       return "bill/payment_history"
        case .myUnits:              return "myunit"
        case .announcements:        return "announcements"
        case .meetings:             return "meetings"
        case .events:               return "events"
        case .polls:                return "polls"
        case .pollsVote:            return "polls/vote"
        case .visitors:             return "visitors"
        case .visitorHistory:       return "visitor/history"
        case .visitorAction:        return "visitor/action"
        case .visitorCompanies:     return "visitor/company"
        case .visitorPreFill:       return "visitor/details"
        case .visitorAdd:           return "visitor/add"
        case .visitorDefaultToggle: return "visitor/default"
        case .directories:          return "directory"
        case .amenities:            return "amenities"
        case .bookAmenities:        return "amenities/book"
        case .bookedAmenities:      return "amenities/booked"
        case .documents:            return "documents"
        case .documentTypes:        return "document_types"
        case .addDocuments:         return "document/add"
        case .ticketTypes:          return "ticket_types"
        case .ticketCreate:         return "ticket/create"
        case .ticketList:           return "ticket/list"
        case .ticketHistory:        return "ticket/history"
        case .addVehicle:           return "vehicle/add"
        case .vehicleList:          return "vehicles"
        case .vehicleSlots:         return "vehicle/slots"
        case .updateProfile:        return "update_profile"
        case .feedback:             return "feedback"
        case .notification:         return "notifications"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .bills, .billDetails,
                .billInvoiceDownload, .billPayment,
                .visitorAction, .visitors, .visitorHistory,
                .visitorPreFill, .visitorAdd,
                .bookAmenities, .addDocuments,
                .ticketCreate, .pollsVote,
                .addVehicle, .billAlreadyPaid,
                .ticketHistory, .updateProfile, 
                .paymentHistory, .feedback, .visitorDefaultToggle:
            return .post
        case .myUnits, .announcements, .meetings,
                .events, .polls, .bookedAmenities,
                .dashboard, .amenities, .documents,
                .documentTypes, .ticketTypes, .directories,
                .vehicleList, .vehicleSlots, .paymentMethods,
                .ticketList, .visitorCompanies, .notification:
            return .get
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .ticketCreate,.updateProfile, .visitorAdd, .addDocuments, .billInvoiceDownload:
            return ClientService.shared.getApiHeaders(isForMultipart: true)
        default:
            return ClientService.shared.getApiHeaders()
        }
        
    }
    
    var task: ApiTask {
        switch self {
        case .myUnits, .dashboard, .amenities,
                .documentTypes, .ticketTypes, .bookedAmenities,
                .vehicleList, .vehicleSlots, .paymentMethods,
                .visitorCompanies, .paymentHistory:
            return .plainRequest
        case .bills(let page, let year, let month):
            let params: [String: Any] = [
                "page": page,
                "year": year,
                "month": month
            ]
            return .withParameters(.init(params), encoding: .json)
        case .billDetails(let id):
            return .withParameters(.init(["id": id]), encoding: .json)
        case .billInvoiceDownload(let id):
            return .multipart(parameters: .init(["id": id]), files: [])
        case .billPayment(let id):
            return .withParameters(.init(["id": id]), encoding: .json)
        case .billAlreadyPaid(let model):
            return .withParameters(.init(model), encoding: .json)
        case .announcements(let page):
            return .withParameters(.init(["page": page]), encoding: .url)
        case .meetings(let page):
            return .withParameters(.init(["page": page]), encoding: .url)
        case .events(let page):
            return .withParameters(.init(["page": page]), encoding: .url)
        case .polls(let page):
            return .withParameters(.init(["page": page]), encoding: .url)
        case .pollsVote(let pollId, let option):
            let param = [
                "poll_id": pollId, "option": option
            ]
            return .withParameters(.init(param), encoding: .json)
        case .visitors(let filter):
            return .withParameters(.init(filter), encoding: .url)
        case .visitorHistory(let filter):
            return .withParameters(.init(filter), encoding: .url)
        case .visitorAction(let id, let isAccepted, let reason):
            let params: [String: Any] = [
                "id": id,
                "is_accept": isAccepted,
                "reason": reason
            ]
            return .withParameters(.init(params), encoding: .json)
        case .visitorPreFill(let phone):
            return .withParameters(.init(["phone": phone]), encoding: .json)
        case .visitorAdd(let model, let files):
            return .multipart(parameters: .init(model), files: files)
        case .directories(let page, let type):
            let params: [String: Any] = [
                "page": page,
                "type": type
            ]
            return .withParameters(.init(params), encoding: .url)
        case .bookAmenities(let model):
            return .withParameters(.init(model), encoding: .json)
        case .documents(let type):
            return .withParameters(.init(["type": type]), encoding: .url)
        case .addDocuments(let model, let files):
            return .multipart(parameters: .init(model), files: files)
        case .ticketCreate(let model, let files):
            return .multipart(parameters: .init(model), files: files)
        case .ticketList(let status, let page):
            return .withParameters(
                .init(
                    [
                        "status": status.rawValue,
                        "page": page
                    ]
                ),
                encoding: .url
            )
        case .ticketHistory(let id):
            return .withParameters(.init(["id": id]), encoding: .json)
        case .addVehicle(model: let model):
            return .withParameters(.init(model), encoding: .json)
        case .updateProfile(let photo, let params):
            return .multipart(
                parameters: .init(params),
                files: [photo].compactMap({$0})
            )
        case .feedback(let rating, let comment):
            let data: [String: Any] = [
                "rating": rating,
                "comment": comment
            ]
            return .withParameters(.init(data), encoding: .json)
        case .visitorDefaultToggle(let id):
            return .withParameters(.init(["id": id]), encoding: .json)
        case .notification(let page):
            return .withParameters(.init(["page": page]), encoding: .url)
        }
    }
}
