
import Foundation

protocol Configurable {
    associatedtype ModelType
    func configure(with model: ModelType)
}
