//
//  SettingModel.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/14.
//

import Foundation

struct SettingModel {
    var leftImageName: String = "" //초기값 지정해두는 이유는 다른 class 에서 initialize할때 optional 이 아닌 변수는 초기화가 되어 있어야 하기 때문임
    var menuTitle: String = ""
    var subTitle: String? //있을수도 없을수도 있는 항목은 optional으로
    var rightImageName: String?
}
