//
//  UseCase.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import Foundation

/// Does not Accept any inputs will inform about the completion of the task
protocol UseCase {
    associatedtype Output
    func execute(completion: Output)
}
/// Does not Accept any inputs will not inform about the completion of the task
protocol CompletableUseCase {
    func execute()
}
/// Accepts the input parameters and will not informs the completion of the task
protocol CompletableUseCaseWithParameter {
    associatedtype Input
    func execute(input: Input)
}
/// Accepts the input parameters and informs the completion of the task
protocol UseCaseWithParameter {
    associatedtype Input
    associatedtype Output
    func execute(input: Input, completion: Output)
}
