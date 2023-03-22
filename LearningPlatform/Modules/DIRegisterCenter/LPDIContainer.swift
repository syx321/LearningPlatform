//
//  LPDIContainer.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/22.
//

import Foundation
import Swinject

/// 封装Swinject
enum DIScopeType: Int {
    case graph = 0
    case permanent = 1
    case transient = 2
    case weak = 3
}

protocol LiveAssembling {
    func registCommonService()
}

protocol DIResolvable: AnyObject {
    func callAsFunction<P>(_ type: P.Type, name: String?) -> P?
}

extension DIResolvable {
    func callAsFunction<P>(_ type: P.Type, name: String? = nil) -> P? {
        callAsFunction(type, name: name)
    }
}

protocol DIContainering {
    func register<P>(_ proto: P.Type, name: String?, scopeType: DIScopeType, factory: @escaping (DIResolvable) -> P, completedHandler: ((P, DIResolvable) -> Void)?)
}

extension DIContainering {
    func register<P>(_ proto: P.Type, name: String? = nil, scopeType: DIScopeType, factory: @escaping (DIResolvable) -> P, completedHandler: ((P, DIResolvable) -> Void)? = nil) {
        register(proto, name: name, scopeType: scopeType, factory: factory, completedHandler: completedHandler)
    }
}

final class DIContainer {
    private let container: Container
    
    init(parent: DIContainering?) {
        if let parentContainer = parent as? DIContainer {
            container = Container(parent: parentContainer.container, defaultObjectScope: .graph)
        } else {
            container = Container(defaultObjectScope: .graph)
        }
    }
}

extension DIContainer: DIContainering {
    func register<P>(_ proto: P.Type, name: String?, scopeType: DIScopeType, factory: @escaping (DIResolvable) -> P, completedHandler: ((P, DIResolvable) -> Void)?) {
        let entry = container.register(proto, name: name) { [weak self](resolver) -> P in
            return factory(self!)
        }.inObjectScope(scopeMapper(scopeType))
        if let completedHandler = completedHandler {
            entry.initCompleted({ [weak self](resolver, instance) in
                guard let self = self else { return }
                completedHandler(instance, self)
            })
        }
    }
    
    private func scopeMapper(_ scopeType: DIScopeType) -> Swinject.ObjectScope {
        switch scopeType {
        case .graph:
            return .graph
        case .permanent:
            return .container
        case .transient:
            return .transient
        case .weak:
            return .weak
        }
    }
}

extension DIContainer: DIResolvable {
    func callAsFunction<P>(_ type: P.Type, name: String?) -> P? {
        let instance = container.resolve(type, name: name)
        return instance
    }
}
