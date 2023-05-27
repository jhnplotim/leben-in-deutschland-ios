//
//  PublishableAppStorage.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.05.23.
//

import SwiftUI
import Combine
import CombineExt

// TODO: Extend to support KeyChain and other data sources in future i.e. Have option to pass the data source as an input
/// That works similar to SwiftUI's @AppStorage but provides a publisher for observing changes in the property in Non SwiftUI contexts. Only works with UserDefaults
@propertyWrapper
class PublishableAppStorage<T: Codable>: DynamicProperty {
    
    struct Wrapper: Codable {
        let value: T
    }

    private let subject: PassthroughSubject<T, Never> = PassthroughSubject()
    private let key: String
    private let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.value(forKey: key) as? T {
                return data
            }

            guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return defaultValue }
            let value = (try? PropertyListDecoder().decode(Wrapper.self, from: data))?.value ?? defaultValue

            return value
        }
        set(newValue) {
            let wrapper = Wrapper(value: newValue)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(wrapper), forKey: key)

            subject.send(newValue)
        }
    }
    
    var projectedValue: Binding<T> {
        Binding(
            get: { [self] in wrappedValue },
            set: { [self] in wrappedValue = $0 }
        )
    }

    lazy var publisher: AnyPublisher<T, Never> = {
        subject.prepend(wrappedValue)
            .share(replay: 1)
            .eraseToAnyPublisher()
    }()
}
