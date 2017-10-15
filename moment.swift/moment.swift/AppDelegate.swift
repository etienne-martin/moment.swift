//
//  AppDelegate.swift
//  moment.swift
//
//  Created by Etienne Martin on 2017-10-07.
//  Copyright © 2017 Etienne Martin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        print(moment.ISO_8601.toString() == "function (){}")
        print(moment().format() == moment(Date()).format())
        print(moment(moment(1318874398806)).format() == "2011-10-17T13:59:58-04:00")
        print(moment(5, "HH").format() == moment().hours(5).minutes(0).seconds(0).format())
        print(moment(1318874398806).unix() == 1318874398)
        print(moment(1318874398806).utc().format() == "2011-10-17T17:59:58Z")
        print(moment.utc([2010, 1, 14, 15, 25, 50, 125]).format() == "2010-02-14T15:25:50Z")
        print(moment.utc(1318781876406).format() == "2011-10-16T16:17:56Z")
        print(moment("1995-12-25").format() == "1995-12-25T00:00:00-05:00")
        print(moment("2017-10-07T19:45:46-04:00").isValid() == true)
        print(moment("not a real date").isValid() == false)
        print(moment("123", "hmm").format("HH:mm") == "01:23")
        print(moment("12-25-1995", ["MM-DD-YYYY", "YYYY-MM-DD"]).format() == "1995-12-25T00:00:00-05:00")
        print(moment("2010-01-01T05:06:07", moment.ISO_8601).format() == "2010-01-01T05:06:07-05:00")
        print(moment("2010-01-01T05:06:07", ["YYYY", moment.ISO_8601]).format() == "2010-01-01T05:06:07-05:00")
        print(moment(1318781876406).format() == "2011-10-16T12:17:56-04:00")
        print(moment.unix(1318781876).format() == "2011-10-16T12:17:56-04:00")
        print(moment.unix(1318781876).format("HH:mm") == "12:17")
        print(moment.unix(1318781876.721).format() == "2011-10-16T12:17:56-04:00")
        print(moment([2010, 1, 14, 15, 25, 50, 125]).format() == "2010-02-14T15:25:50-05:00")
        print(moment([2010, 12]).isValid() == false)
        print(moment("/Date(1198908717056-0700)/").format() == "2007-12-29T01:11:57-05:00")
        print(moment(1318781876406).format("dddd, MMMM Do YYYY, h:mm:ss a") == "Sunday, October 16th 2011, 12:17:56 pm")
        print(moment(1318781876406).format("ddd, hA") == "Sun, 12PM")
        print(moment("gibberish").format("YYYY MM DD") == "Invalid date")
        print(moment("2011-10-10T10:20:90").format() == "Invalid date")
        print(moment().fromNow() == "a few seconds ago")
        print(moment([2007, 0, 29]).fromNow() == "11 years ago")
        print(moment([2007, 0, 29]).fromNow(true) == "11 years")
        print(moment([2007, 0, 28]).from([2007, 0, 30]) == "2 days ago")
        print(moment([2007, 0, 28]).from(moment([2007, 0, 29])) == "a day ago")
        print(moment([2007, 0, 29]).toNow() == "in 11 years")
        print(moment([2007, 0, 29]).toNow(true) == "11 years")
        print(moment().utcOffset() == -240)
        print(moment(1318781876406).utcOffset(120).format() == "2011-10-16T18:17:56+02:00")
        print(moment(1318781846406).utcOffset(8).format() == "2011-10-17T00:17:26+08:00")
        print(moment(1318781876406).utcOffset("+08:00").format() == "2011-10-17T00:17:56+08:00")
        print(moment(1318781876406).utcOffset("2013-03-07T07:00:00+08:00").format() == "2011-10-17T00:17:56+08:00")
        print(moment([2016, 0, 1, 0, 0, 0]).utcOffset(-5, true).format() == "2016-01-01T00:00:00-05:00")
        print(moment().zone(120).zone() == 120)
        print(moment().zone("-08:00").zone() == 480)
        print(moment(1318781876406).zone(120).format() == "2011-10-16T14:17:56-02:00")
        print(moment(1318781876406).zone(8).format() == "2011-10-16T08:17:56-08:00")
        print(moment(1318781876406).format("dddd, MMMM Do YYYY, h:mm:ss a") == "Sunday, October 16th 2011, 12:17:56 pm")
        print(moment(1318781876406).format("ddd, hA") == "Sun, 12PM")
        print(moment(1318781876406).format("[today] dddd") == "today Sunday")
        print(moment([2007, 0, 28]).to([2007, 0, 29]) == "in a day")
        print(moment([2007, 0, 28]).to(moment([2007, 0, 29])) == "in a day")
        print(moment([2007, 0, 28]).to("2007-01-29") == "in a day")
        print(moment(1318781876406).add(3, "seconds").format() == "2011-10-16T12:17:59-04:00")
        print(moment(1318874398806).valueOf() == 1318874398806)
        print(moment("2012-02", "YYYY-MM").daysInMonth() == 29)
        print(moment(1318874398806).toArray() == [2011, 9, 17, 13, 59, 58, 806])
        print(moment(1318874398806).toISOString() == "2011-10-17T17:59:58.806Z")
        print(moment(Date()).toDate().description == Date().description)
        print(moment(1318874398806).toString() == "Mon Oct 17 2011 13:59:58 GMT-0400")
        print(moment(1318874398806).inspect() == "moment(\"2011-10-17T13:59:58.806\")")
        print(moment.utc([2010, 1, 14, 15, 25, 50, 125]).inspect() == "moment.utc(\"2010-02-14T15:25:50.125+00:00\")")
        print(moment.parseZone("2016-11-10T06:24:12.958+05:00").inspect() == "moment.parseZone(\"2016-11-10T06:24:12.958+05:00\")")
        print(moment("blah", "YYYY").inspect() == "moment.invalid(/* blah */)")
        print(moment("2010-10-20").isBefore("2010-10-21") == true)
        print(moment("2010-10-20").isBefore("2010-12-31", "year") == false)
        print(moment("2010-10-20").isSame("2010-10-20") == true)
        print(moment("2010-10-20").isSame("2009-12-31", "year") == false)
        print(moment("2010-10-20").isAfter("2010-10-19") == true)
        print(moment("2010-10-20").isAfter("2010-01-01", "year") == false)
        print(moment("2010-10-20").isSameOrBefore("2010-10-21") == true)
        print(moment("2010-10-20").isSameOrBefore("2009-12-31", "year") == false)
        print(moment("2010-10-20").isSameOrAfter("2010-10-19") == true)
        print(moment("2010-10-20").isSameOrAfter("2011-12-31", "year") == false)
        print(moment("2010-10-20").isBetween("2010-10-19", "2010-10-25") == true)
        print(moment("2010-10-20").isBetween("2010-01-01", "2012-01-01", "year") == false)
        print(moment("2016-10-30").isBetween("2016-10-30", "2016-12-30", NSNull(), "()") == false)
        print(moment("2016-10-30").isBetween("2016-10-30", "2016-12-30", NSNull(), "[)") == true)
        print(moment("2016-10-30").isBetween("2016-01-01", "2016-10-30", NSNull(), "()") == false)
        print(moment("2016-10-30").isBetween("2016-01-01", "2016-10-30", NSNull(), "(]") == true)
        print(moment("2016-10-30").isBetween("2016-10-30", "2016-10-30", NSNull(), "[]") == true)
        print(moment("2016-10-30").isBetween("2016-10-30", "2016-10-30", NSNull(), "(]") == false)
        print(moment([2011, 2, 12]).isDST() == false)
        print(moment([2011, 2, 14]).isDST() == true)
        print(moment("2013-03-10 2:30", "YYYY-MM-DD HH:mm").isDSTShifted() == true)
        print(moment([2000]).isLeapYear() == true)
        print(moment([2001]).isLeapYear() == false)
        print(moment.isMoment() == false)
        print(moment.isMoment(moment()) == true)
        print(moment.isDate() == false)
        print(moment.isDate(Date()) == true)
        print(moment.isDate(moment()) == false)
        print(moment.parseZone("2013-01-01T00:00:00-13:00").utcOffset() == -780)
        print(moment("2011-10-10T10:20:90").invalidAt() == 5)
        print("\(moment("2011-10-10T10:20:90").unix())" == "nan")
        print(moment([2007, 0, 29]).diff(moment([2007, 0, 28])) == 86400000)
        print(moment([2007, 0, 29]).diff(moment([2007, 0, 28]), "days") == 1)
        print(moment([2007, 0, 29]).diff(moment([2007, 0, 28]), "years", true) == 0.0026881720430107525)
        print(moment().diff(moment().add(1, "seconds")) == -1000, "diff") // TODO: Fail sometimes, output: -1001 instead of -1000
        print(moment().add(1, "seconds").diff(moment()) == 1000, "diff") // TODO: Fail sometimes, output: 1001 instead of 1000
        print(moment("2013-01-02", "YYYY-MM-DD", true).creationData().count > 0)
        print(moment().millisecond(30).millisecond() == 30)
        print(moment().milliseconds(30).milliseconds() == 30)
        print(moment().second(30).second() == 30)
        print(moment().seconds(30).seconds() == 30)
        print(moment().minute(30).minute() == 30)
        print(moment().minutes(30).minutes() == 30)
        print(moment().hour(10).hour() == 10)
        print(moment().hours(10).hours() == 10)
        print(moment().date(10).date() == 10)
        print(moment().dates(10).dates() == 10)
        print(moment().day(7).day() == 0)
        print(moment().days(7).days() == 0)
        print(moment().day("Sunday").day() == 0)
        print(moment().days("Sunday").days() == 0)
        print(moment().weekday(2).weekday() == 2)
        print(moment().isoWeekday(1).isoWeekday() == 1)
        print(moment().dayOfYear(10).dayOfYear() == 10)
        print(moment().week(7).week() == 7)
        print(moment().weeks(7).weeks() == 7)
        print(moment().isoWeek(7).isoWeek() == 7)
        print(moment().isoWeeks(7).isoWeeks() == 7)
        print(moment().month(7).month() == 7)
        print(moment().months(7).months() == 7)
        print(moment().month("January").month() == 0)
        print(moment().months("January").months() == 0)
        print(moment().quarter(2).quarter() == 2)
        print(moment().quarters(2).quarters() == 2)
        print(moment().year(2000).year() == 2000)
        print(moment().years(2000).years() == 2000)
        print(moment().weekYear(2000).weekYear() == 2000)
        print(moment().isoWeekYear(2000).isoWeekYear() == 2000)
        print(moment([2012]).weeksInYear() == 52)
        print(moment([2012]).isoWeeksInYear() == 52)
        print(moment().set("year", 2012).get("year") == 2012)
        print(moment().set(["year": 2013, "month": 2]).get("month") == 2)
        print(moment(1318874398806).startOf("year").format() == "2011-01-01T00:00:00-05:00")
        print(moment(1318874398806).endOf("year").format() == "2011-12-31T23:59:59-05:00")
        print(moment.parseZone("2016-05-03T22:15:01+02:00").local().format() == "2016-05-03T16:15:01-04:00")
        print(moment.parseZone("2016-05-03T22:15:01+02:00").utc().format() == "2016-05-03T20:15:01Z")
        print(moment(1318874398806).calendar() == "10/17/2011")
        print(moment(1318874398806).calendar(1318874398806) == "Today at 1:59 PM")
        print(moment(1318874398806).calendar(moment(1318874398806)) == "Today at 1:59 PM")
        
        // print(moment.max(moment().subtract(1, "day"), moment().add(1, "day"))) // TODO: finish implementation
        // print(moment().max("2013-04-20T20:00:00+0800").format() == "2013-04-20T08:00:00-04:00") // TODO: finish implementation
        
        print(moment().calendar(NSNull(), [
            "sameDay": "[Today is the day]",
            "nextDay": "[Tomorrow]",
            "nextWeek": "dddd",
            "lastDay": "[Yesterday]",
            "lastWeek": "[Last] dddd",
            "sameElse": "DD/MM/YYYY"
            ]) == "Today is the day")
        
        let myMoment = moment()
        
        let callback: @convention(block) (String) -> String = { now in
            if myMoment.isBefore(now) {
                return "[Will Happen Today]"
            }else{
                return "[Happened Today]"
            }
        }
        
        print(myMoment.calendar(NSNull(), [
            "sameDay": callback
            ]) == "Happened Today")
        
        print(moment(1318874398806).toObject() == [
            "date": 17,
            "hours": 13,
            "milliseconds": 806,
            "minutes": 59,
            "months": 9,
            "seconds": 58,
            "years": 2011
            ])
        
        print(moment([
            "date": 17,
            "hours": 13,
            "milliseconds": 806,
            "minutes": 59,
            "months": 9,
            "seconds": 58,
            "years": 2011
            ]).format() == "2011-10-17T13:59:58-04:00")
        
        // Clone instance
        let a = moment([2012])
        let b = moment(a)
        _ = a.year(2000)
        print(b.year() == 2012)
        print(a.year() == 2000)
        
        // Clone instance
        let A = moment([2012])
        let B = A.clone()
        _ = A.year(2000)
        print(B.year() == 2012)
        print(A.year() == 2000)
        
        // Test different locales
        
        /*
         let ordinal: @convention(block) (NSNumber) -> (String) = { number in
         return "\(number)\((number == 1 ? "er" : "e"))"
         }
         
         let isPM: @convention(block) (String) -> (Bool) = { input in
         return input.first == "M"
         }
         
         let meridiem: @convention(block) (NSNumber) -> (String) = { hours in
         return (hours as! Float) < 12 ? "PD" : "MD"
         }
         */
        
        print(moment.locale("fr", [
            "months" : ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"],
            "monthsShort" : ["janv.", "févr.", "mars", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."],
            "monthsParseExact" : true,
            "weekdays" : ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"],
            "weekdaysShort" : ["dim.", "lun.", "mar.", "mer.", "jeu.", "ven.", "sam."],
            "weekdaysMin" : ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"],
            "weekdaysParseExact" : true,
            "longDateFormat" : [
                "LT" : "HH:mm",
                "LTS" : "HH:mm:ss",
                "L" : "DD/MM/YYYY",
                "LL" : "D MMMM YYYY",
                "LLL" : "D MMMM YYYY HH:mm",
                "LLLL" : "dddd D MMMM YYYY HH:mm"
            ],
            "calendar" : [
                "sameDay" : "[Aujourd’hui à] LT",
                "nextDay" : "[Demain à] LT",
                "nextWeek" : "dddd [à] LT",
                "lastDay" : "[Hier à] LT",
                "lastWeek" : "dddd [dernier à] LT",
                "sameElse" : "L"
            ],
            "relativeTime" : [
                "future" : "dans %s",
                "past" : "il y a %s",
                "s" : "quelques secondes",
                "m" : "une minute",
                "mm" : "%d minutes",
                "h" : "une heure",
                "hh" : "%d heures",
                "d" : "un jour",
                "dd" : "%d jours",
                "M" : "un mois",
                "MM" : "%d mois",
                "y" : "un an",
                "yy" : "%d ans"
            ],
            // "dayOfMonthOrdinalParse" : "/\\d{1,2}(er|e)/", // TODO: test this thing.
            // "ordinal" : ordinal,
            // "meridiemParse" : "/PD|MD/", // TODO: test this thing too.
            // "isPM" : isPM,
            // "meridiem" : meridiem,
            "week" : [
                "dow" : 1, // Monday is the first day of the week.
                "doy" : 4  // The week that contains Jan 4th is the first week of the year.
            ]
            ]) == "fr")
        
        print(moment().fromNow() == "il y a quelques secondes")
        print(moment.locale("en") == "en")
        print(moment().fromNow() == "a few seconds ago")
        print(moment.locale(["tq", "fr"]) == "fr")
        print(moment.locale() == "fr")
        print(moment.locale("en") == "en") // Reset global locale
        print(moment().locale("fr").locale() == "fr")
        print(moment().locale("fr").locale(false).locale() == "en")
        print(moment.lang("fr") == "fr")
        print(moment.lang() == "fr")
        print("\(moment.locales()[0])" == "en")
        print(moment.locale("en") == "en") // Reset global locale
        
        print("\(moment.months()[0])" == "January")
        print(moment.months(0) == "January")
        
        print("\(moment.monthsShort()[0])" == "Jan")
        print(moment.monthsShort(0) == "Jan")
        print(moment.locale("nl") == "nl") // Set global locale to nl
        print("\(moment.monthsShort()[0])" == "jan.")
        print("\(moment.monthsShort("-MMM-")[0])" == "jan")
        print(moment.monthsShort("-MMM-", 3) == "apr")
        print(moment.locale("en") == "en") // Reset global locale
        
        print("\(moment.weekdays()[0])" == "Sunday")
        print(moment.weekdays(0) == "Sunday")
        print("\(moment.weekdays(true)[0])" == "Sunday")
        print(moment.weekdays(true, 0) == "Sunday")
        
        print("\(moment.weekdaysShort()[0])" == "Sun")
        print(moment.weekdaysShort(0) == "Sun")
        print("\(moment.weekdaysShort(true)[0])" == "Sun")
        print(moment.weekdaysShort(true, 0) == "Sun")
        
        print("\(moment.weekdaysMin()[0])" == "Su")
        print(moment.weekdaysMin(0) == "Su")
        print("\(moment.weekdaysMin(true)[0])" == "Su")
        print(moment.weekdaysMin(true, 0) == "Su")
        
        print(moment().lang() == moment().localeData())
        print(moment.localeData() == moment().localeData())
        print(moment.localeData("en") == moment().locale("en").localeData())
        
        // let localeData = moment.localeData()
        // localeData.months()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

