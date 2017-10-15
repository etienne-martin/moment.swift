//
//  moment.swift
//  moment.swift
//
//  Created by Etienne Martin on 2017-10-07.
//  Copyright © 2017 Etienne Martin. All rights reserved.
//

import JavaScriptCore

fileprivate var javascriptContext = JSContext()!
fileprivate var libraryIsLoaded = false
fileprivate var momentObject: JSValue!

open class moment{
    fileprivate var momentInstance: JSValue!
    
    init(_ args:Any...){
        if libraryIsLoaded == false {
            if let libraryPath = Bundle.main.path(forResource: "moment-with-locales.min", ofType: "js") {
                do{
                    let momentJS = try String(contentsOfFile: libraryPath, encoding: String.Encoding.utf8)
                    _ = javascriptContext.evaluateScript(momentJS)
                }catch{
                    print("Unable to load moment.js")
                    return
                }
                
                bridgeConsole()
                libraryIsLoaded = true
                momentObject = javascriptContext.objectForKeyedSubscript("moment")
            }else{
                print("Unable to load moment.js")
                return
            }
        }
        
        let arguments = convertArgs(args)
        momentInstance = momentObject.construct(withArguments: arguments)
    }
    
    fileprivate func bridgeConsole(){
        let consoleLog: @convention(block) (String) -> () = { message in
            print("-------------------------------")
            print(message)
            print("-------------------------------")
        }
        javascriptContext.evaluateScript("console.log = function(message){ _consoleLog(message) }")
        javascriptContext.evaluateScript("console.error = function(message){ _consoleLog(message) }")
        javascriptContext.evaluateScript("console.warn = function(message){ _consoleLog(message) }")
        javascriptContext.setObject(unsafeBitCast(consoleLog, to: AnyObject.self), forKeyedSubscript: "_consoleLog" as (NSCopying & NSObjectProtocol)!)
    }
    
    /******* Helper functions *******/
    
    // Converting Between JavaScript and Native Types
    // https://developer.apple.com/documentation/javascriptcore/jsvalue#1663421
    
    private func convertArgs(_ args:[Any]) -> [Any]{
        var arguments = args
        for (index, arg) in args.enumerated() {
            if arg is moment {
                arguments[index] = (arg.self as! moment).momentInstance
            }
        }
        return arguments
    }
}

// Parse
extension moment {
    
    // moment.ISO_8601
    static var ISO_8601: JSValue {
        get {
            if libraryIsLoaded == false {
                _ = moment()
            }
            return momentObject.objectForKeyedSubscript("ISO_8601")
        }
    }
    
    // moment.unix(Number)
    static func unix(_ args:Any...) -> moment {
        let newMomentInstance = moment()
        newMomentInstance.momentInstance = (momentObject.invokeMethod("unix", withArguments: args))!
        return newMomentInstance
    }
    
    // moment().clone()
    func clone() -> moment {
        return moment(self.momentInstance)
    }
    
    // moment.utc()
    // moment.utc(Number)
    // moment.utc(Number[])
    // moment.utc(String)
    // moment.utc(String, String)
    // moment.utc(String, String[])
    // moment.utc(String, String, String)
    // moment.utc(Moment)
    // moment.utc(Date)
    static func utc(_ args:Any...) -> moment {
        let newMomentInstance = moment()
        let arguments = newMomentInstance.convertArgs(args)
        newMomentInstance.momentInstance = (momentObject.invokeMethod("utc", withArguments: arguments))!
        return newMomentInstance
    }
    
    // moment.parseZone()
    // moment.parseZone(String)
    // moment.parseZone(String, String)
    // moment.parseZone(String, [String])
    // moment.parseZone(String, String, Boolean)
    // moment.parseZone(String, String, String, Boolean)
    static func parseZone(_ args:Any...) -> moment {
        let newMomentInstance = moment()
        newMomentInstance.momentInstance = (momentObject.invokeMethod("parseZone", withArguments: args))!
        return newMomentInstance
    }
    
    // moment().isValid()
    open func isValid() -> Bool {
        return (momentInstance.invokeMethod("isValid", withArguments: []))!.toBool()
    }
    
    // moment().invalidAt()
    open func invalidAt() -> NSNumber {
        return (momentInstance.invokeMethod("invalidAt", withArguments: []))!.toNumber()
    }
    
    // moment().creationData()
    open func creationData() -> NSDictionary {
        return (momentInstance.invokeMethod("creationData", withArguments: []))!.toObject() as! NSDictionary
    }
}

// Get + Set
extension moment {
    
    // Getter
    open func millisecond() -> NSNumber {
        return (momentInstance.invokeMethod("millisecond", withArguments: []))!.toNumber()
    }
    // Setter
    open func millisecond(_ args:Any...) -> moment {
        momentInstance.invokeMethod("millisecond", withArguments: args)
        return self
    }
    // Getter
    open func milliseconds() -> NSNumber {
        return (momentInstance.invokeMethod("milliseconds", withArguments: []))!.toNumber()
    }
    // Setter
    open func milliseconds(_ args:Any...) -> moment {
        momentInstance.invokeMethod("milliseconds", withArguments: args)
        return self
    }
    
    // Getter
    open func second() -> NSNumber {
        return (momentInstance.invokeMethod("second", withArguments: []))!.toNumber()
    }
    // Setter
    open func second(_ args:Any...) -> moment {
        momentInstance.invokeMethod("second", withArguments: args)
        return self
    }
    // Getter
    open func seconds() -> NSNumber {
        return (momentInstance.invokeMethod("seconds", withArguments: []))!.toNumber()
    }
    // Setter
    open func seconds(_ args:Any...) -> moment {
        momentInstance.invokeMethod("seconds", withArguments: args)
        return self
    }
    
    // Getter
    open func minute() -> NSNumber {
        return (momentInstance.invokeMethod("minute", withArguments: []))!.toNumber()
    }
    // Setter
    open func minute(_ args:Any...) -> moment {
        momentInstance.invokeMethod("minute", withArguments: args)
        return self
    }
    // Getter
    open func minutes() -> NSNumber {
        return (momentInstance.invokeMethod("minutes", withArguments: []))!.toNumber()
    }
    // Setter
    open func minutes(_ args:Any...) -> moment {
        momentInstance.invokeMethod("minutes", withArguments: args)
        return self
    }
    
    // Getter
    open func hour() -> NSNumber {
        return (momentInstance.invokeMethod("hour", withArguments: []))!.toNumber()
    }
    // Setter
    open func hour(_ args:Any...) -> moment {
        momentInstance.invokeMethod("hour", withArguments: args)
        return self
    }
    // Getter
    open func hours() -> NSNumber {
        return (momentInstance.invokeMethod("hours", withArguments: []))!.toNumber()
    }
    // Setter
    open func hours(_ args:Any...) -> moment {
        momentInstance.invokeMethod("hours", withArguments: args)
        return self
    }
    
    // Getter
    open func date() -> NSNumber {
        return (momentInstance.invokeMethod("date", withArguments: []))!.toNumber()
    }
    // Setter
    open func date(_ args:Any...) -> moment {
        momentInstance.invokeMethod("date", withArguments: args)
        return self
    }
    // Getter
    open func dates() -> NSNumber {
        return (momentInstance.invokeMethod("dates", withArguments: []))!.toNumber()
    }
    // Setter
    open func dates(_ args:Any...) -> moment {
        momentInstance.invokeMethod("dates", withArguments: args)
        return self
    }
    
    // Getter
    open func day() -> NSNumber {
        return (momentInstance.invokeMethod("day", withArguments: []))!.toNumber()
    }
    // Setter
    open func day(_ args:Any...) -> moment {
        momentInstance.invokeMethod("day", withArguments: args)
        return self
    }
    // Getter
    open func days() -> NSNumber {
        return (momentInstance.invokeMethod("days", withArguments: []))!.toNumber()
    }
    // Setter
    open func days(_ args:Any...) -> moment {
        momentInstance.invokeMethod("days", withArguments: args)
        return self
    }
    
    // Getter
    open func weekday() -> NSNumber {
        return (momentInstance.invokeMethod("weekday", withArguments: []))!.toNumber()
    }
    // Setter
    open func weekday(_ args:Any...) -> moment {
        momentInstance.invokeMethod("weekday", withArguments: args)
        return self
    }
    
    // Getter
    open func isoWeekday() -> NSNumber {
        return (momentInstance.invokeMethod("isoWeekday", withArguments: []))!.toNumber()
    }
    // Setter
    open func isoWeekday(_ args:Any...) -> moment {
        momentInstance.invokeMethod("isoWeekday", withArguments: args)
        return self
    }
    
    // Getter
    open func dayOfYear() -> NSNumber {
        return (momentInstance.invokeMethod("dayOfYear", withArguments: []))!.toNumber()
    }
    // Setter
    open func dayOfYear(_ args:Any...) -> moment {
        momentInstance.invokeMethod("dayOfYear", withArguments: args)
        return self
    }
    
    // Getter
    open func week() -> NSNumber {
        return (momentInstance.invokeMethod("week", withArguments: []))!.toNumber()
    }
    // Setter
    open func week(_ args:Any...) -> moment {
        momentInstance.invokeMethod("week", withArguments: args)
        return self
    }
    // Getter
    open func weeks() -> NSNumber {
        return (momentInstance.invokeMethod("weeks", withArguments: []))!.toNumber()
    }
    // Setter
    open func weeks(_ args:Any...) -> moment {
        momentInstance.invokeMethod("weeks", withArguments: args)
        return self
    }
    
    // moment().isoWeek()
    open func isoWeek() -> NSNumber {
        return (momentInstance.invokeMethod("isoWeek", withArguments: []))!.toNumber()
    }
    // moment().isoWeek(Number)
    open func isoWeek(_ args:Any...) -> moment {
        momentInstance.invokeMethod("isoWeek", withArguments: args)
        return self
    }
    // moment().isoWeeks()
    open func isoWeeks() -> NSNumber {
        return (momentInstance.invokeMethod("isoWeeks", withArguments: []))!.toNumber()
    }
    // moment().isoWeeks(Number)
    open func isoWeeks(_ args:Any...) -> moment {
        momentInstance.invokeMethod("isoWeeks", withArguments: args)
        return self
    }
    
    // moment().month()
    open func month() -> NSNumber {
        return (momentInstance.invokeMethod("month", withArguments: []))!.toNumber()
    }
    // moment().month(Number|String)
    open func month(_ args:Any...) -> moment {
        momentInstance.invokeMethod("month", withArguments: args)
        return self
    }
    // moment().months()
    open func months() -> NSNumber {
        return (momentInstance.invokeMethod("months", withArguments: []))!.toNumber()
    }
    // moment().months(Number|String)
    open func months(_ args:Any...) -> moment {
        momentInstance.invokeMethod("months", withArguments: args)
        return self
    }
    
    // moment().quarter()
    open func quarter() -> NSNumber {
        return (momentInstance.invokeMethod("quarter", withArguments: []))!.toNumber()
    }
    // moment().quarter(Number)
    open func quarter(_ args:Any...) -> moment {
        momentInstance.invokeMethod("quarter", withArguments: args)
        return self
    }
    // moment().quarters()
    open func quarters() -> NSNumber {
        return (momentInstance.invokeMethod("quarters", withArguments: []))!.toNumber()
    }
    // moment().quarters(Number)
    open func quarters(_ args:Any...) -> moment {
        momentInstance.invokeMethod("quarters", withArguments: args)
        return self
    }
    
    // moment().year()
    open func year() -> NSNumber {
        return (momentInstance.invokeMethod("year", withArguments: []))!.toNumber()
    }
    // moment().year(Number)
    open func year(_ args:Any...) -> moment {
        momentInstance.invokeMethod("year", withArguments: args)
        return self
    }
    // moment().years()
    open func years() -> NSNumber {
        return (momentInstance.invokeMethod("years", withArguments: []))!.toNumber()
    }
    // moment().years(Number)
    open func years(_ args:Any...) -> moment {
        momentInstance.invokeMethod("years", withArguments: args)
        return self
    }
    
    // moment().weekYear()
    open func weekYear() -> NSNumber {
        return (momentInstance.invokeMethod("weekYear", withArguments: []))!.toNumber()
    }
    // moment().weekYear(Number)
    open func weekYear(_ args:Any...) -> moment {
        momentInstance.invokeMethod("weekYear", withArguments: args)
        return self
    }
    
    // moment().isoWeekYear()
    open func isoWeekYear() -> NSNumber {
        return (momentInstance.invokeMethod("isoWeekYear", withArguments: []))!.toNumber()
    }
    // moment().isoWeekYear(Number)
    open func isoWeekYear(_ args:Any...) -> moment {
        momentInstance.invokeMethod("isoWeekYear", withArguments: args)
        return self
    }
    
    // moment().weeksInYear()
    open func weeksInYear() -> NSNumber {
        return (momentInstance.invokeMethod("weeksInYear", withArguments: []))!.toNumber()
    }
    
    // moment().isoWeeksInYear()
    open func isoWeeksInYear() -> NSNumber {
        return (momentInstance.invokeMethod("isoWeeksInYear", withArguments: []))!.toNumber()
    }
    
    // moment().get('year')
    open func get(_ args:Any...) -> NSNumber {
        return (momentInstance.invokeMethod("get", withArguments: args))!.toNumber()
    }
    // moment().set('year')
    open func set(_ args:Any...) -> moment {
        momentInstance.invokeMethod("set", withArguments: args)
        return self
    }
    
    // moment.max(Moment[,Moment...])
    // moment.max(Moment[])
    // TODO: finish implementation
    static func max(_ args:Any...) -> JSValue {
        let newMomentInstance = moment()
        let arguments = newMomentInstance.convertArgs(args)
        return (newMomentInstance.momentInstance.invokeMethod("max", withArguments: arguments))!
    }
    
    // moment.min(Moment[,Moment...])
    // moment.min(Moment[])
    // TODO: finish implementation
    static func min(_ args:Any...) -> JSValue {
        let newMomentInstance = moment()
        let arguments = newMomentInstance.convertArgs(args)
        return (newMomentInstance.momentInstance.invokeMethod("min", withArguments: arguments))!
    }
}

// Manipulate
extension moment {
    
    // moment().add(Number, String)
    // moment().add(Duration)
    // moment().add(Object)
    // TODO: finish implementation (Support durations)
    open func add(_ args:Any...) -> moment {
        momentInstance.invokeMethod("add", withArguments: args)
        return self
    }
    
    // moment().subtract(Number, String)
    // moment().subtract(Duration)
    // moment().subtract(Object)
    // TODO: finish implementation (Support durations)
    open func subtract(_ args:Any...) -> moment {
        momentInstance.invokeMethod("subtract", withArguments: args)
        return self
    }
    
    // moment().startOf(String)
    open func startOf(_ args:Any...) -> moment {
        momentInstance.invokeMethod("startOf", withArguments: args)
        return self
    }
    
    // moment().endOf(String)
    open func endOf(_ args:Any...) -> moment {
        momentInstance.invokeMethod("endOf", withArguments: args)
        return self
    }
    
    // moment().max(Moment|String|Number|Date|Array)
    // TODO: finish implementation
    open func max(_ args:Any...) -> NSNumber {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("max", withArguments: arguments))!.toNumber()
    }
    
    // moment().min(Moment|String|Number|Date|Array)
    // TODO: finish implementation
    open func min(_ args:Any...) -> NSNumber {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("min", withArguments: arguments))!.toNumber()
    }
    
    // moment().local()
    open func local() -> moment {
        momentInstance.invokeMethod("local", withArguments: [])
        return self
    }
    
    // moment().utc()
    open func utc() -> moment {
        momentInstance.invokeMethod("utc", withArguments: [])
        return self
    }
    
    // moment().utcOffset()
    open func utcOffset() -> NSNumber {
        return (momentInstance.invokeMethod("utcOffset", withArguments: []))!.toNumber()
    }
    // moment().utcOffset(Number|String)
    // moment().utcOffset(Number|String, Boolean)
    open func utcOffset(_ args:Any...) -> moment {
        momentInstance.invokeMethod("utcOffset", withArguments: args)
        return self
    }
    
    // moment().zone()
    open func zone() -> NSNumber {
        return (momentInstance.invokeMethod("zone", withArguments: []))!.toNumber()
    }
    // moment().zone(Number|String)
    open func zone(_ args:Any...) -> moment {
        momentInstance.invokeMethod("zone", withArguments: args)
        return self
    }
}

// Display
extension moment {
    
    // moment().format()
    // moment().format(String)
    open func format(_ args:Any...) -> String {
        return (momentInstance.invokeMethod("format", withArguments: args))!.toString()
    }
    
    // moment().fromNow()
    // moment().fromNow(Boolean)
    open func fromNow(_ args:Any...) -> String {
        return (momentInstance.invokeMethod("fromNow", withArguments: args))!.toString()
    }
    
    // moment().from(Moment|String|Number|Date|Array)
    // moment().from(Moment|String|Number|Date|Array, Boolean)
    open func from(_ args:Any...) -> String {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("from", withArguments: arguments))!.toString()
    }
    
    // moment().toNow()
    // moment().toNow(Boolean)
    open func toNow(_ args:Any...) -> String {
        return (momentInstance.invokeMethod("toNow", withArguments: args))!.toString()
    }
    
    // moment().to(Moment|String|Number|Date|Array)
    // moment().to(Moment|String|Number|Date|Array, Boolean)
    open func to(_ args:Any...) -> String {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("to", withArguments: arguments))!.toString()
    }
    
    // moment().calendar()
    // moment().calendar(referenceTime)
    // moment().calendar(referenceTime, formats)
    open func calendar(_ args:Any...) -> String {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("calendar", withArguments: arguments))!.toString()
    }
    
    // moment().diff(Moment|String|Number|Date|Array)
    // moment().diff(Moment|String|Number|Date|Array, String)
    // moment().diff(Moment|String|Number|Date|Array, String, Boolean)
    open func diff(_ args:Any...) -> NSNumber {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("diff", withArguments: arguments))!.toNumber()
    }
    
    // moment().valueOf()
    open func valueOf() -> NSNumber {
        return (momentInstance.invokeMethod("valueOf", withArguments: []))!.toNumber()
    }
    
    // moment().unix()
    open func unix() -> NSNumber {
        return (momentInstance.invokeMethod("unix", withArguments: []))!.toNumber()
    }
    
    // moment().daysInMonth()
    open func daysInMonth() -> NSNumber {
        return (momentInstance.invokeMethod("daysInMonth", withArguments: []))!.toNumber()
    }
    
    // moment().toDate()
    open func toDate() -> NSDate {
        return (momentInstance.invokeMethod("toDate", withArguments: []))!.toDate()! as NSDate
    }
    
    // moment().toArray()
    open func toArray() -> NSArray {
        return (momentInstance.invokeMethod("toArray", withArguments: []))!.toArray()! as NSArray
    }
    
    // moment().toISOString()
    open func toISOString() -> String {
        return (momentInstance.invokeMethod("toISOString", withArguments: []))!.toString()
    }
    
    // moment().toObject()
    open func toObject() -> NSDictionary {
        return (momentInstance.invokeMethod("toObject", withArguments: []))!.toObject() as! NSDictionary
    }
    
    // moment().toString()
    open func toString() -> String {
        return (momentInstance.invokeMethod("toString", withArguments: []))!.toString()
    }
    
    // moment().inspect()
    open func inspect() -> String {
        return (momentInstance.invokeMethod("inspect", withArguments: []))!.toString()
    }
}

// Query
extension moment {
    
    // moment().isBefore(Moment|String|Number|Date|Array)
    // moment().isBefore(Moment|String|Number|Date|Array, String)
    open func isBefore(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isBefore", withArguments: arguments))!.toBool()
    }
    
    // moment().isSame(Moment|String|Number|Date|Array)
    // moment().isSame(Moment|String|Number|Date|Array, String)
    open func isSame(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isSame", withArguments: arguments))!.toBool()
    }
    
    // moment().isAfter(Moment|String|Number|Date|Array)
    // moment().isAfter(Moment|String|Number|Date|Array, String)
    open func isAfter(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isAfter", withArguments: arguments))!.toBool()
    }
    
    // moment().isSameOrBefore(Moment|String|Number|Date|Array)
    // moment().isSameOrBefore(Moment|String|Number|Date|Array, String)
    open func isSameOrBefore(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isSameOrBefore", withArguments: arguments))!.toBool()
    }
    
    // moment().isSameOrAfter(Moment|String|Number|Date|Array)
    // moment().isSameOrAfter(Moment|String|Number|Date|Array, String)
    open func isSameOrAfter(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isSameOrAfter", withArguments: arguments))!.toBool()
    }
    
    // moment().isBetween(moment-like, moment-like)
    // moment().isBetween(moment-like, moment-like, String)
    // moment().isBetween(moment-like, moment-like, String, String)
    // where moment-like is Moment|String|Number|Date|Array
    open func isBetween(_ args:Any...) -> Bool {
        let arguments = convertArgs(args)
        return (momentInstance.invokeMethod("isBetween", withArguments: arguments))!.toBool()
    }
    
    // moment().isDST()
    open func isDST() -> Bool {
        return (momentInstance.invokeMethod("isDST", withArguments: []))!.toBool()
    }
    
    // moment('2013-03-10 2:30', 'YYYY-MM-DD HH:mm').isDSTShifted()
    open func isDSTShifted(_ args:Any...) -> Bool {
        return (momentInstance.invokeMethod("isDSTShifted", withArguments: args))!.toBool()
    }
    
    // moment().isLeapYear()
    open func isLeapYear() -> Bool {
        return (momentInstance.invokeMethod("isLeapYear", withArguments: []))!.toBool()
    }
    
    // moment.isMoment(obj)
    static func isMoment(_ args:Any...) -> Bool {
        let newMomentInstance = moment()
        let arguments = newMomentInstance.convertArgs(args)
        return (momentObject.invokeMethod("isMoment", withArguments: arguments))!.toBool()
    }
    
    // moment.isDate(obj)
    static func isDate(_ args:Any...) -> Bool {
        let newMomentInstance = moment()
        let arguments = newMomentInstance.convertArgs(args)
        return (momentObject.invokeMethod("isDate", withArguments: arguments))!.toBool()
    }
}

// i18n
extension moment {
    
    // moment.locale(String)
    // moment.locale(String[])
    // moment.locale(String, Object)
    static func locale(_ args:Any...) -> String {
        return (momentObject.invokeMethod("locale", withArguments: args))!.toString()
    }
    
    // moment.lang(String)
    // moment.lang(String[])
    // moment.lang(String, Object)
    static func lang(_ args:Any...) -> String {
        return (momentObject.invokeMethod("lang", withArguments: args))!.toString()
    }
    
    // moment().locale()
    open func locale() -> String {
        return (momentInstance.invokeMethod("locale", withArguments: []))!.toString()
    }
    // moment().locale(String|Boolean)
    open func locale(_ args:Any...) -> moment {
        momentInstance.invokeMethod("locale", withArguments: args)
        return self
    }
    
    // moment().lang()
    open func lang() -> NSDictionary {
        return (momentInstance.invokeMethod("lang", withArguments: []))!.toObject() as! NSDictionary
    }
    // moment().lang(String|Boolean)
    open func lang(_ args:Any...) -> moment {
        momentInstance.invokeMethod("lang", withArguments: args)
        return self
    }
    
    // moment.locales()
    static func locales() -> NSArray {
        return (momentObject.invokeMethod("locales", withArguments: []))!.toArray()! as NSArray
    }
    
    // moment.months()
    static func months() -> NSArray {
        return (momentObject.invokeMethod("months", withArguments: []))!.toArray()! as NSArray
    }
    // moment.months(Number)
    static func months(_ args:Any...) -> String {
        return (momentObject.invokeMethod("months", withArguments: args))!.toString()
    }
    
    // moment.monthsShort()
    static func monthsShort() -> NSArray {
        return (momentObject.invokeMethod("monthsShort", withArguments: []))!.toArray()! as NSArray
    }
    // moment.monthsShort(Number)
    // moment.monthsShort(String, Number)
    static func monthsShort(_ args:Any...) -> String {
        return (momentObject.invokeMethod("monthsShort", withArguments: args))!.toString()
    }
    // moment.monthsShort(String)
    static func monthsShort(_ arg:String) -> NSArray {
        return (momentObject.invokeMethod("monthsShort", withArguments: [arg]))!.toArray()! as NSArray
    }
    
    // moment.weekdays()
    static func weekdays() -> NSArray {
        return (momentObject.invokeMethod("weekdays", withArguments: []))!.toArray()! as NSArray
    }
    // moment.weekdays(Number)
    // moment.weekdays(Boolean, Number)
    static func weekdays(_ args:Any...) -> String {
        return (momentObject.invokeMethod("weekdays", withArguments: args))!.toString()
    }
    // moment.weekdays(Boolean)
    static func weekdays(_ arg:Bool) -> NSArray {
        return (momentObject.invokeMethod("weekdays", withArguments: [arg]))!.toArray()! as NSArray
    }
    
    // moment.weekdaysShort()
    static func weekdaysShort() -> NSArray {
        return (momentObject.invokeMethod("weekdaysShort", withArguments: []))!.toArray()! as NSArray
    }
    // moment.weekdaysShort(Number)
    // moment.weekdaysShort(Boolean, Number)
    static func weekdaysShort(_ args:Any...) -> String {
        return (momentObject.invokeMethod("weekdaysShort", withArguments: args))!.toString()
    }
    // moment.weekdaysShort(Boolean)
    static func weekdaysShort(_ arg:Bool) -> NSArray {
        return (momentObject.invokeMethod("weekdaysShort", withArguments: [arg]))!.toArray()! as NSArray
    }
    
    // moment.weekdaysMin()
    static func weekdaysMin() -> NSArray {
        return (momentObject.invokeMethod("weekdaysMin", withArguments: []))!.toArray()! as NSArray
    }
    // moment.weekdaysMin(Number)
    // moment.weekdaysMin(Boolean, Number)
    static func weekdaysMin(_ args:Any...) -> String {
        return (momentObject.invokeMethod("weekdaysMin", withArguments: args))!.toString()
    }
    // moment.weekdaysMin(Boolean)
    static func weekdaysMin(_ arg:Bool) -> NSArray {
        return (momentObject.invokeMethod("weekdaysMin", withArguments: [arg]))!.toArray()! as NSArray
    }
    
    // moment.localeData(String)
    // TODO: finish implementation
    static func localeData(_ args:Any...) -> NSDictionary {
        return (momentObject.invokeMethod("localeData", withArguments: args))!.toObject() as! NSDictionary
    }
    // moment().localeData()
    // TODO: finish implementation
    open func localeData() -> NSDictionary {
        return (momentInstance.invokeMethod("localeData", withArguments: []))!.toObject() as! NSDictionary
    }
}
