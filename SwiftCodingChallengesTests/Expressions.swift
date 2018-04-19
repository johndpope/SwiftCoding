//
//  Expressions.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/18/18.
//

import JavaScriptCore
import XCTest

/// Reference
/// https://developer.apple.com/documentation/foundation/nsexpression
/// http://nshipster.com/nspredicate/
/// https://developer.apple.com/documentation/javascriptcore
/// http://nshipster.com/javascriptcore/

func costExpression(elapsedTime: TimeInterval) -> Double {

    // Additional time
    let expr1 = NSExpression(format: "%f - (30 * 60)", elapsedTime)
    let res1 = expr1.expressionValue(with: nil, context: nil) as! NSNumber
    print(res1)

    // Extra Full minutes
    let expr2 = NSExpression(format: "%f / 60", res1.doubleValue)
    let res2 = expr2.expressionValue(with: nil, context: nil) as! NSNumber
    print(res2)

    // Extra Partial minutes
    let expr3 = NSExpression(forFunction: "modulus:by:",
                             arguments: [NSExpression(forConstantValue: res1.doubleValue),
                                         NSExpression(forConstantValue: 60)])
    let res3 = expr3.expressionValue(with: nil, context: nil) as! NSNumber
    print(res3)

    // Has Partial minute?
    let expr4 = NSPredicate(format: "%f > 0", res3.doubleValue)
    let res4 = expr4.evaluate(with: nil) as NSNumber
    print(res4)

    // Cost calculation Base Fee + ((Extra Full Minute + Extra Partial Minute) * Extra Minute Cost)
    let expr5 = NSExpression(format: "2000 + (%f + %f) * 70", res2.doubleValue, res4.doubleValue)
    let res5 = expr5.expressionValue(with: nil, context: nil) as! NSNumber
    print(res5)

    return res5.doubleValue
}

func costJS(elapsedTime: TimeInterval) -> Double {

    let formula = """
        var cost = function(elapsedTime) {
            var extraElapsedTime = Math.max(0, elapsedTime - (30 * 60));
            var extraFullMinutes = extraElapsedTime / 60;
            var extraPartialMinutes = extraElapsedTime % 60 > 0 ? 1 : 0;
            var cost = 2000 + ((extraFullMinutes + extraPartialMinutes) * 70);
            return cost;
        }
        """
    let context = JSContext()
    _ = context?.evaluateScript("var elapsedTime = \(elapsedTime)")
    _ = context?.evaluateScript(formula)
    let cost = context?.evaluateScript("cost(elapsedTime)")
    return cost!.toDouble()
}

func costEnum(model: String, elapsedTime: TimeInterval) -> Double {
    let model = TimeModel(rawValue: model)!
    return model.evaluate(elapsedTime: elapsedTime)
}


enum TimeModel: String {
    case jump
    case limeBike

    func evaluate(elapsedTime: TimeInterval) -> Double {
        switch self {
        case .jump:
            return jumpEvaluate(elapsedTime:elapsedTime)
        case .limeBike:
            return limeBikeEvaluate(elapsedTime:elapsedTime)
        }
    }

    func jumpEvaluate(elapsedTime: TimeInterval) -> Double {
        let baseFare = 2000.0
        let extraFullMinute = (elapsedTime - 30 * 60) / 60
        let extraPartialMinute = ((elapsedTime - 30 * 60).truncatingRemainder(dividingBy: 60)) > 0 ? 1.0 : 0.0
        let extraMinuteFare = 70.0
        return baseFare + ((extraFullMinute + extraPartialMinute) * extraMinuteFare)
    }

    func limeBikeEvaluate(elapsedTime: TimeInterval) -> Double {
        return 0
    }
}

class Expressions: XCTestCase {

    func testCost() {
        // 35 min (2100 seconds) = $2.35 cost
        XCTAssertEqual(costExpression(elapsedTime: 2100), 2350)
    }

    func testCostJS() {
        // 35 min (2100 seconds) = $2.35 cost
        XCTAssertEqual(costJS(elapsedTime: 2100), 2350)
    }

    func testCostEnum() {
        // 35 min (2100 seconds) = $2.35 cost
        XCTAssertEqual(costEnum(model: "jump", elapsedTime: 2100), 2350)
    }
}
