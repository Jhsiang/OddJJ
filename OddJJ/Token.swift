//
//  Token.swift
//  OddJJ
//
//  Created by Jim Chuang on 2018/9/26.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

class Select {
    var power = 0
    var belong = 0
    var mod = 0 // addMode,takeMode,moveMode
}

class Token {
    private var power = 0 //1,2,3
    private var belong = 0 //1,2
    private var statusArr = [[0,0,0],[0,0,0]] //每格的狀態[0][0]位置為P1放入最小Token, [1][2]位置為P2放入最大TokenJ

    func showBelong() -> Int{
        return belong
    }

    func showPower() -> Int{
        return power
    }

    func showText() -> String{
        if belong == 0 {
            return ""
        }else if belong == 1{
            return "P1 \(power)"
        }else if belong == 2{
            return "P2 \(power)"
        }else{
            return ""
        }
    }

    func setToken(setBelong:Int,setPower:Int) -> Bool{

        // setBelong = 1~2
        guard setBelong <= 2 && setBelong >= 1 else{
            return false
        }

        // setPower = 1~3
        guard setPower <= 3 && setPower >= 1 else{
            return false
        }

        // 設定值要大於原始值
        guard setPower > power else{
            return false
        }

        let player = setBelong - 1
        let loc = setPower - 1

        statusArr[player][loc] = 1
        belong = setBelong
        power = setPower

        return true
    }

    func removeToken() -> Bool{

        // belong = 1~2
        guard belong <= 2 && belong >= 1 else{
            return false
        }

        // rmPower = 1~3
        guard power <= 3 && power >= 1 else{
            return false
        }

        let player = belong - 1
        let loc = power - 1
        statusArr[player][loc] = 0
        belong = 0
        power = 0

        for pwr in 0...2{
            for play in 0...1{
                if statusArr[play][pwr] == 1{
                    belong = play + 1
                    power = pwr + 1
                }
            }
        }

        return true
    }

    func checkBigger(iToken:Token) -> Bool{
        if iToken.belong == self.belong{
            return false
        }

        if iToken.power <= self.power{
            return false
        }

        return true
    }

    func clean(){
        power = 0
        belong = 0
        statusArr = [[0,0,0],[0,0,0]]
    }
}
