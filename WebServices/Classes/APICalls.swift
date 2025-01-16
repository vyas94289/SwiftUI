//
//  APICalls.swift
//  Lyronel
//
//  Created by Gaurang on 21/12/22.
//

import Foundation
import Combine
import UIKit

class APICalls {
    
    private init() {}
    
    static func verifyClient(
        _ client: String
    ) async -> ApiResult<BaseResponse<String>> {
        let target = AuthService.verifyClient(client: client)
        return await ApiService.shared.call(target: target)
    }
    
    static func login(
        _ model: RequestModels.Login
    ) async -> ApiResult<BaseResponse<UserAccount>> {
        let target = AuthService.login(model: model)
        return await ApiService.shared.call(target: target)
    }
    
    static func requestOTP(
        _ username: String
    ) async -> ApiResult<MessageResponse> {
        let target = AuthService.requestOTP(userName: username)
        return await ApiService.shared.call(target: target)
    }
    
    static func forgotPassword(
        _ username: String
    ) async -> ApiResult<MessageResponse> {
        let target = AuthService.forgotPassword(username: username)
        return await ApiService.shared.call(target: target)
    }
    
    static func dashboard() async -> ApiResult<BaseResponse<DashboardResponse>> {
        let target = UserServices.dashboard
        return await ApiService.shared.call(target: target)
    }

    static func bills(page: Int, year: String, month: String) async -> ApiResult<BaseResponse<BillResponse>> {
        let target = UserServices.bills(page: page, year: year, month: month)
        return await ApiService.shared.call(target: target)
    }
    
    static func billDetails(
        id: String
    ) async -> ApiResult<BaseResponse<BillDetails>>  {
        let target = UserServices.billDetails(id: id)
        return await ApiService.shared.call(target: target)
    }
    
    static func billInvoiceDownload(
        id: String
    ) async -> ApiResult<BaseResponse<String>>  {
        let target = UserServices.billInvoiceDownload(id: id)
        return await ApiService.shared.call(target: target)
    }
    
    static func billAlreadyPaid(
        model: RequestModels.BillAlreadyPaid
    ) async -> ApiResult<MessageResponse>  {
        let target = UserServices.billAlreadyPaid(model: model)
        return await ApiService.shared.call(target: target)
    }
    
    static func billPayment(
        id: String
    ) async -> ApiResult<BaseResponse<String>>  {
        let target = UserServices.billPayment(billID: id)
        return await ApiService.shared.call(target: target)
    }
    
    static func paymentMethods() async -> ApiResult<BaseResponse<[IdName]>> {
        let target = UserServices.paymentMethods
        return await ApiService.shared.call(target: target)
    }
    
    static func myUnits() async -> ApiResult<BaseResponse<UnitResponse>> {
        let target = UserServices.myUnits
        return await ApiService.shared.call(target: target)
    }
    
    static func announcements(page: Int) async -> ApiResult<BaseResponse<AnnouncementResponse>> {
        let target = UserServices.announcements(page: page)
        return await ApiService.shared.call(target: target)
    }
    
    static func meetings(page: Int) async -> ApiResult<BaseResponse<MeetingResponse>> {
        let target = UserServices.meetings(page: page)
        return await ApiService.shared.call(target: target)
    }
    
    static func events(page: Int) async -> ApiResult<BaseResponse<EventResponse>> {
        let target = UserServices.events(page: page)
        return await ApiService.shared.call(target: target)
    }
    
    static func polls(page: Int) async -> ApiResult<BaseResponse<PollResponse>> {
        let target = UserServices.polls(page: page)
        return await ApiService.shared.call(target: target)
    }
    
    static func pollVote(pollId: String, option: String) async -> ApiResult<MessageResponse> {
        let target = UserServices.pollsVote(pollId: pollId, option: option)
        return await ApiService.shared.call(target: target)
    }
    
    static func visitors(
        filter: RequestModels.VisitorFilter
    ) async -> ApiResult<BaseResponse<VisitorResponse>> {
        let target = UserServices.visitors(filter: filter)
        return await ApiService.shared.call(target: target)
    }
    
    static func visitorHistory(
        filter: RequestModels.VisitorFilter
    ) async -> ApiResult<BaseResponse<[Visitor]>> {
        let target = UserServices.visitorHistory(filter: filter)
        return await ApiService.shared.call(target: target)
    }
    
    static func visitorAction(
        id: String, isAccepted: String, reason: String
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.visitorAction(id: id, isAccepted: isAccepted, reason: reason)
        return await ApiService.shared.call(target: target)
    }
    
    static func directories(page: Int, type: String) async -> ApiResult<BaseResponse<DirectoryResponse>> {
        let target = UserServices.directories(page: page, type: type)
        return await ApiService.shared.call(target: target)
    }
    
    static func amenities() async -> ApiResult<BaseResponse<[AmenitiesModel]>> {
        let target = UserServices.amenities
        return await ApiService.shared.call(target: target)
    }
    
    static func bookAmenity(_ model: RequestModels.BookAmenities) async -> ApiResult<MessageResponse> {
        let target = UserServices.bookAmenities(model: model)
        return await ApiService.shared.call(target: target)
    }
    
    static func bookedAmenities(
    ) async -> ApiResult<BaseResponse<[BookedAmenity]>> {
        let target = UserServices.bookedAmenities
        return await ApiService.shared.call(target: target)
    }
    
    static func documentsTypes() async -> ApiResult<BaseResponse<[IdName]>> {
        let target = UserServices.documentTypes
        return await ApiService.shared.call(target: target)
    }
    
    static func documents(typeID: String?) async -> ApiResult<BaseResponse<[DocumentModel]>> {
        let target = UserServices.documents(type: typeID ?? "")
        return await ApiService.shared.call(target: target)
    }
    
    static func addDocuments(
        model: RequestModels.AddDocument,
        file: MimeTypes
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.addDocuments(model: model, files: [file])
        return await ApiService.shared.call(target: target)
    }
    
    static func ticketTypes() async -> ApiResult<BaseResponse<[IdName]>> {
        let target = UserServices.ticketTypes
        return await ApiService.shared.call(target: target)
    }
    
    static func createTicket(
        model: RequestModels.CreateTicket, files: [MimeTypes]
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.ticketCreate(model: model, files: files)
        return await ApiService.shared.call(target: target)
    }
    
    static func ticketList(
        status: ComplaintType, page: Int
    ) async -> ApiResult<BaseResponse<TicketResponse>> {
        let target = UserServices.ticketList(status: status, page: page)
        return await ApiService.shared.call(target: target)
    }
    
    static func ticketHistory(
        id: String
    ) async -> ApiResult<BaseResponse<TicketHistory>> {
        let target = UserServices.ticketHistory(id: id)
        return await ApiService.shared.call(target: target)
    }
    
    static func addVehicle(
        model: RequestModels.AddVehicle
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.addVehicle(model: model)
        return await ApiService.shared.call(target: target)
    }
    
    static func vehicleList(
    ) async -> ApiResult<BaseResponse<[VehicleModel]>> {
        let target = UserServices.vehicleList
        return await ApiService.shared.call(target: target)
    }
    
    static func vehicleSlots(
    ) async -> ApiResult<BaseResponse<[VehicleSlot]>> {
        let target = UserServices.vehicleSlots
        return await ApiService.shared.call(target: target)
    }
    
    static func visitorCompanies(
    ) async -> ApiResult<BaseResponse<VisitorCompanies>> {
        let target = UserServices.visitorCompanies
        return await ApiService.shared.call(target: target)
    }
    
    static func visitorPreFill(
        phone: String
    ) async -> ApiResult<BaseResponse<VisitorPreFill>> {
        let target = UserServices.visitorPreFill(phone: phone)
        return await ApiService.shared.call(target: target)
    }
    
    static func addVisitor(
        model: RequestModels.AddVisitor,
        photo: UIImage?
    ) async -> ApiResult<MessageResponse> {
        var files: [MimeTypes] = []
        if let photo, let file = MimeTypes(photo, key: "photo") {
            files.append(file)
        }
        let target = UserServices.visitorAdd(model: model, files: files)
        return await ApiService.shared.call(target: target)
    }
    
    static func visitorDefaultToggle(
        id: String
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.visitorDefaultToggle(id: id)
        return await ApiService.shared.call(target: target)
    }
    
    static func updateProfile(
        photo: UIImage?, params: RequestModels.EditProfile
    ) async -> ApiResult<BaseResponse<UserAccount>> {
        var mimeType: MimeTypes?
        if let photo {
            mimeType = MimeTypes(photo, key: "photo")
        }
        let target = UserServices.updateProfile(photo: mimeType, params: params)
        return await ApiService.shared.call(target: target)
    }
    
    static func paymentHistory(
    ) async -> ApiResult<BaseResponse<[PaymentHistory]>> {
        let target = UserServices.paymentHistory
        return await ApiService.shared.call(target: target)
    }
    
    static func feedback(
        rating: Int, comment: String
    ) async -> ApiResult<MessageResponse> {
        let target = UserServices.feedback(rating: rating, comment: comment)
        return await ApiService.shared.call(target: target)
    }
    
    static func notifications(
        page: Int
    ) async -> ApiResult<BaseResponse<[String: [NotificationModel]]>> {
        let target = UserServices.notification(page: page)
        return await ApiService.shared.call(target: target)
    }
}
