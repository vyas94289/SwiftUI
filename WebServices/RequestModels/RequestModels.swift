//
//  RequestModels.swift
//  BaseStructure
//
//  Created by Gaurang on 03/05/22.
//

import Foundation

struct RequestModels {
    
}

extension RequestModels {
    // Login
    struct Login: Encodable {
        let username: String
        let otp: String
        let password: String
        let dtoken: String
    }
    
    // Book Amenities
    struct BookAmenities: Encodable {
        let id: String
        let date: String //2023-05-30
        let time: String // 12 to 1
        let details: String
    }
    
    // Add Document
    struct AddDocument: Encodable {
        let type: String
        let name: String
        let remark: String
    }
    
    // Create Ticket
    struct CreateTicket: Encodable {
        let type: String
        let name: String
        let description: String
        let priority: String
    }
    
    // Add Vehicle
    struct AddVehicle: Encodable {
        let slotId, number, model: String
        let type: VehicleType
        
        enum CodingKeys: String, CodingKey {
            case slotId = "slot_id"
            case number
            case model
            case type
        }
    }
    
    // Bill Already Paid
    struct BillAlreadyPaid: Encodable {
        let id, paymentMethod, referenceNo, remark: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case paymentMethod  = "payment_method"
            case referenceNo    = "reference_no"
            case remark
        }
    }
    
    // Visitor
    class VisitorFilter: Encodable {
        var page: Int = 1
        var unitId: String?
        var status: VisitorStatus?
        var companyId: String?
        var startDate: String? //2023-11-29
        var endDate: String?
        var name: String?
        var visitorType: String?
        
        enum CodingKeys: String, CodingKey {
            case page
            case unitId = "unit_id"
            case status
            case companyId = "company_id"
            case startDate = "start_date"
            case endDate = "end_date"
            case name
            case visitorType = "visitor_type"
        }
        
        func reset() {
            page = 1
            unitId = nil
            status = nil
            companyId = nil
            startDate = nil
            name = nil
            endDate = nil
            visitorType = nil
        }
    }
    
    struct AddVisitor: Encodable {
        let name, phone: String?
        let gender: Gender?
        let type: VisitorType?
        let companyId: String?
        let companyName: String?
        let vehicleNo: String?
        let purpose: String?
        let visitType: VisitAreaType?
        let unitId: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case phone
            case gender
            case type
            case companyId = "company_id"
            case companyName = "company_name"
            case vehicleNo = "vehicle_no"
            case purpose
            case visitType = "visit_type"
            case unitId = "unit_id"
        }
    }
    
    struct EditProfile: Encodable {
        let hideInfo: String
        let emergencyId: String
        let emergencyName: String
        let emergencyEmail: String
        let emergencyPhone: String
        let emergencyRelationship: String
        
        enum CodingKeys: String, CodingKey {
            case hideInfo = "hide_info"
            case emergencyId = "emergency_id"
            case emergencyName  = "emergency_name"
            case emergencyEmail = "emergency_email"
            case emergencyPhone = "emergency_phone"
            case emergencyRelationship = "emergency_relationship"
        }
    }
}
