//
//  RTest.swift
//  Rising
//
//  Created by SSR on 2022/9/8.
//

import Foundation

class ScheduleModel : Identifiable {
    var dic : Dictionary <Range<Int>, ScheduleModel>
    init(dict:Dictionary <Range<Int>, ScheduleModel>) {
        dic = dict;
        
    }
}
