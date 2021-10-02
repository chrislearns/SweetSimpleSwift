//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//


import SwiftUI
import Accelerate.vecLib.LinearAlgebra


public class MathHelper {
    public static func solveSystemOfEquations(matrix:[[Double]], vector:[Double])->[Double]{
        var result: [Double] = Array(repeating: 0.0, count: vector.count)
        let flatMatrix = matrix.flatMap({$0})
        
        let laMatrix:la_object_t =
            la_matrix_from_double_buffer(flatMatrix,  la_count_t(matrix.count),  la_count_t(matrix[0].count),  la_count_t(matrix[0].count), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let laVector = la_matrix_from_double_buffer(vector, la_count_t(vector.count), 1, 1, la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let vecCj = la_solve(laMatrix, laVector)
        
        let status = la_matrix_to_double_buffer(&result, 1, vecCj)
        
        if status == la_status_t(LA_SUCCESS) {
            return result
        } else {
            return [Double]()
        }
    }
    
    static func sin(degrees: Double) -> Double {
        return __sinpi(degrees/180.0)
    }

    static func cos(degrees: Double) -> Double {
        return __cospi(degrees/180.0)
    }
}
