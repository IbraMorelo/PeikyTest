//
//  XIBBundle.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

func bundleFor(root object: AnyClass, name: String) -> Bundle? {
    guard let path = Bundle(for: object).path(forResource: name, ofType: "bundle"), let bundle = Bundle(path: path) else { return nil }
    return bundle
}

func bundleForXib<T: NSObject>(type: T.Type) -> Bundle {
    let defaultBundle = Bundle(for: T.classForCoder())
    let name = String(describing: type)
    
    if let podName = String(reflecting: type).split(separator: ".").first,
        let resourcesBundle = bundleFor(root: T.classForCoder(), name: podName + "Resources"),
        resourcesBundle.has(xib: name) { return resourcesBundle }
    
    if defaultBundle.has(xib: name) { return defaultBundle }
    
    if !Bundle.main.has(xib: name) {
        print("The xib named: " + name + " isn't in the resources bundle neither in the class bundle or in the main bundle, this message only tells you that PeikyTest will crash 🧨")
    }
    return .main
}


extension Bundle {
    func has(xib: String) -> Bool {
        return path(forResource: xib, ofType: "nib") != nil
    }
}

public protocol BundleHelper {
    static var defaultName: String { get }
}

public extension BundleHelper  where Self: NSObject {
    static var mainBundle: Bundle {
        return bundleFor(root: self, name: defaultName) ?? Bundle(path: "\(defaultName).bundle") ?? Bundle(for: self)
    }
}

final class OpenWeatherPeikyBundleHelper: NSObject, BundleHelper {
    public static var defaultName: String {
        return "OpenWeatherPeikyResources"
    }
    
    public override init() {}
}

extension Bundle {
    static var openWeatherPeikyBundle: Bundle {
        return OpenWeatherPeikyBundleHelper.mainBundle
    }
}

