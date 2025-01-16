//
//  MockGenerator.swift
//  StrataPanel
//
//  Created by Gaurang on 11/04/23.
//

import Foundation

enum MockJson: String {
    case userAccount    = "UserAccount"
    case bills          = "BillsMock"
    case communityBuzz  = "CommunityBuzz"
    case visitor        = "Visitor"
    case notification   = "Notification"
    case facilities     = "Facilities"
    case directory      = "Directory"
}

extension MockJson {
    
    private func generate<C: Codable>(ofType type: C.Type) -> C? {
        Helper.loadJson(fileName: self.rawValue, type: type)
    }
}

extension MockJson {
    
    static func fetchUserAccount() -> UserAccount? {
        MockJson.userAccount.generate(ofType: UserAccount.self)
    }
    
    static func fetchBills() -> [BillModel] {
        MockJson.bills.generate(ofType: [BillModel].self) ?? []
    }
    
    static func fetchCommunityBuzz() -> [CommunityBuzz] {
        MockJson.communityBuzz.generate(ofType: [CommunityBuzz].self) ?? []
    }
    
    static func fetchVisitors() -> [Visitor] {
        MockJson.visitor.generate(ofType: [Visitor].self) ?? []
    }
    
    static func fetchNotifications() -> [NotificationModel] {
        MockJson.notification.generate(ofType: [NotificationModel].self) ?? []
    }
    
    static func fetchFacilities() -> [AmenitiesModel] {
        MockJson.facilities.generate(ofType: [AmenitiesModel].self) ?? []
    }
    
    static func fetchDirectory() -> [DirectoryModel] {
        MockJson.directory.generate(ofType: [DirectoryModel].self) ?? []
    }
    
    static func fetchComplaintHistory() -> [ComplaintStep] {
        [
            .init(id: 1, title: "Complaint has been registered", date: .now, status: .completed),
            .init(id: 2, title: "Assigned to Andrew Smith (Manager)", date: .now, status: .completed),
            .init(id: 3, title: "Complaint has been in progress", date: .now, status: .running),
            .init(id: 4, title: "Complaint has been resolved", date: .now, status: .incomplete),
        ]
    }
    
    static func getPoll() -> Poll {
        let jsonString = """
        {
                        "id": 4,
                        "name": "Test Poll",
                        "start_date": "30 Oct 2023",
                        "end_date": "31 Mar 2024",
                        "start_time": "19:36:00",
                        "end_time": "19:36:00",
                        "option_1": "one",
                        "option_2": "two",
                        "option_3": "three",
                        "option_4": null,
                        "option_5": null,
                        "is_voted": true,
                        "created_at": "30 Oct 2023",
                        "status": "Ongoing",
                        "poll_status": 1,
                        "result": {
                            "one": "10%",
                            "two": "20%",
                            "three": "70%"
                        }
                    }
        """
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(Poll.self, from: data)
    }
    
}
