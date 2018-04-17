//
//  RealmError.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 1/15/18.
//  Copyright © 2018 sang. All rights reserved.
//

enum RealmError: Error {
	case failedToInitialize
	case failedToRead
	case failedToWrite
	
	var localizedDescription: String {
		switch self {
		case .failedToInitialize:
			return "Failed to initialize Realm"
		case .failedToRead:
			return "Failed to read from Realm database"
		case .failedToWrite:
			return "Failed to write to Realm database"
		}
	}
}
