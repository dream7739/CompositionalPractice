//
//  ChattingData.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/18/24.
//

import Foundation

struct ChatRoom: Hashable, Identifiable {
    let id = UUID()
    let profile: String
    let title: String
    let description: String
}

struct ChatRoomResult {
    static let chatRoomList: [ChatRoom] = [
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함"),
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함"),
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함"),
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함"),
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함"),
        ChatRoom(profile: "seven_ruppy", title: "세븐일레븐 루피방", description: "GS보단 세븐인가요"),
        ChatRoom(profile: "sad_ruppy", title: "아파서 슬픈 루피방", description: "눈물이 흐른다"),
        ChatRoom(profile: "happy_ruppy", title: "행복한 루피방", description: "치킨을 먹어서 행복함")
    ]
}
