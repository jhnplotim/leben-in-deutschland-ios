//
//  DIResolver.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Swinject
import Foundation

public final class DIResolver {
    static let shared: DIResolver = {
        let resolver = DIResolver()
        return resolver
    }()
}

// swiftlint:disable function_parameter_count
extension DIResolver: Resolver {
    public func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType)
    }
    
    public func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name)
    }
    
    public func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, argument: argument)
    }
    
    public func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String?, argument: Arg1) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, argument: argument)
    }
    
    public func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2)
    }
    
    public func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }
    
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service? {
        Assembler.sharedAssembler.resolver.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }
    
}
