//
//  String+Extension.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

extension String {
    func toInt()->(Int){
        return Int(self) ?? 0
    }

    func toDouble()->Double{
        return (self as NSString).doubleValue
    }

    func getDate()-> Date {
        var actualDate: Date = Date()
        let dateComponent = self.components(separatedBy: ".")
        if dateComponent.count == 2 {
            actualDate = self.toDate()
        }
        else {
            actualDate = self.toDateFromGmtString() ?? Date()
        }
        return actualDate
    }

    // UTC time
    func preciseUTCTime(formate: String = "MM/dd/yyyy hh:mm:ss a")-> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = formate
        return formatter.date(from: self) ?? Date()
    }

    func toGregorianDate(formate: String = "MM/dd/yyyy hh:mm:ss a") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.calendar = Calendar(identifier: .gregorian)
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: self) ?? Date()
    }

    func toDateFromGmtString() -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en-US")
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0 * 3600)
        return dateFormatter.date(from: self)
    }

    func toGenericDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0 * 3600)
        return dateFormatter.date(from:self)
    }

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.init(identifier: "en-US")
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0 * 3600)
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }

    func toLocalDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: self)
        return localDate ?? Date()
    }


    func toAmount() -> String {
        return String(format: "$%@", self)
    }

    func replaceOccureance() -> String
    {
        return self.replacingOccurrences(of: "\n", with: "")
    }

    func replaceForPhone() -> String
    {
        var phone = self.replacingOccurrences(of: "(", with: "")
        phone = phone.replacingOccurrences(of: ")", with: "")
        phone = phone.replacingOccurrences(of: "-", with: "")
        phone = phone.replacingOccurrences(of: " ", with: "")
        return phone
    }

    func height() -> CGFloat {
        let width = UIScreen.main.bounds.size.width - 40.0
        let font = UIFont.systemFont(ofSize: 17.0)
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    var withoutHtmlTags: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
    .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
    "", options:.regularExpression, range: nil)
    }

    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }

    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }

        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }

        return String(self[substringStartIndex ..< substringEndIndex])
    }

    func toCurrencyFormat() -> String
     {
        if let intValue = Double(self){
               let numberFormatter = NumberFormatter()
               numberFormatter.locale = Locale(identifier: "en_US")/* Using Nigeria's Naira here or you can use Locale.current to get current locale, please change to your locale, link below to get all locale identifier.*/
               numberFormatter.numberStyle = NumberFormatter.Style.currency
               return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
          }
        return ""
    }

    func isNotEmpty() -> Bool {
        return !self.isEmpty
    }

    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }

    // MARK: To check Password is valid or not
    func isValidPassword() -> Bool {
        let emailRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }

    var isUpperCase: Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }

    var isLowerCase: Bool {
        let capitalLetterRegEx  = ".*[a-z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }

    var isNumber: Bool {
        let capitalLetterRegEx  = ".*[0-9]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }

    var isSpecialCharacter: Bool {
        let capitalLetterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }
}
