//
//  Enum.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum Storyboard: String {
    case LAUNCHSCREEN = "LaunchScreen"
    case MAIN = "Main"
    case TABS = "Tabs"
    case SEARCH = "Search"
    case PROFILE = "Profile"
}

public enum NavigationContainer: String {
    case DashboardContainer = "DashboardContainer"
    case LoginContainer = "LoginContainer"
}

public enum SampleAppError: Error {
    case PublicClientApplicationCreation(NSError)
    case UserNotFound(NSError)
    case NoUserSignedIn
    case ServerInvalidResponse
    case ImageCacheError(Error)
    case FailedToMakeUIImageError
}

public enum GraphScopes: String {
    case UserRead = "User.Read"
    case CalendarsRead = "Calendars.Read"
}

public enum PlayListType {
    case MainPlayList
    case MainSubPlayList
    case Genreshiphop
    case Moods
}

public enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"

    public var errorDescription: String? {
        rawValue
    }
}
