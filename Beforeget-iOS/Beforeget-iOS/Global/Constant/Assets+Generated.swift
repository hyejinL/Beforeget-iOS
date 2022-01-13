// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal static let bigstarActive = ImageAsset(name: "bigstarActive")
    internal static let bigstarInactive = ImageAsset(name: "bigstarInactive")
    internal static let boxActiveStar1 = ImageAsset(name: "boxActiveStar1")
    internal static let boxActiveStar2 = ImageAsset(name: "boxActiveStar2")
    internal static let boxActiveStar3 = ImageAsset(name: "boxActiveStar3")
    internal static let boxActiveStar4 = ImageAsset(name: "boxActiveStar4")
    internal static let boxActiveStar5 = ImageAsset(name: "boxActiveStar5")
    internal static let boxFilterActive = ImageAsset(name: "boxFilterActive")
    internal static let boxFilterInactive = ImageAsset(name: "boxFilterInactive")
    internal static let boxInactiveStar1 = ImageAsset(name: "boxInactiveStar1")
    internal static let boxInactiveStar2 = ImageAsset(name: "boxInactiveStar2")
    internal static let boxInactiveStar3 = ImageAsset(name: "boxInactiveStar3")
    internal static let boxInactiveStar4 = ImageAsset(name: "boxInactiveStar4")
    internal static let boxInactiveStar5 = ImageAsset(name: "boxInactiveStar5")
    internal static let btnAddreview = ImageAsset(name: "btnAddreview")
    internal static let btnBack = ImageAsset(name: "btnBack")
    internal static let btnBigstarActive = ImageAsset(name: "btnBigstarActive")
    internal static let btnBigstarInactive = ImageAsset(name: "btnBigstarInactive")
    internal static let btnClose = ImageAsset(name: "btnClose")
    internal static let btnCompleteActive = ImageAsset(name: "btnCompleteActive")
    internal static let btnCompleteInactive = ImageAsset(name: "btnCompleteInactive")
    internal static let btnDelete = ImageAsset(name: "btnDelete")
    internal static let btnDetail = ImageAsset(name: "btnDetail")
    internal static let btnDownload = ImageAsset(name: "btnDownload")
    internal static let btnKeyboard = ImageAsset(name: "btnKeyboard")
    internal static let btnPlus = ImageAsset(name: "btnPlus")
    internal static let btnRefresh = ImageAsset(name: "btnRefresh")
    internal static let btnRefreshAll = ImageAsset(name: "btnRefreshAll")
    internal static let btnRefreshDate = ImageAsset(name: "btnRefreshDate")
    internal static let btnRefreshMedia = ImageAsset(name: "btnRefreshMedia")
    internal static let btnRefreshStar = ImageAsset(name: "btnRefreshStar")
    internal static let btnReviewDelete = ImageAsset(name: "btnReviewDelete")
    internal static let btnSearch = ImageAsset(name: "btnSearch")
    internal static let btnSetting = ImageAsset(name: "btnSetting")
    internal static let btnStarActive = ImageAsset(name: "btnStarActive")
    internal static let btnStarInactive = ImageAsset(name: "btnStarInactive")
    internal static let btnStats = ImageAsset(name: "btnStats")
    internal static let btnWriting = ImageAsset(name: "btnWriting")
    internal static let btnAll = ImageAsset(name: "btn_all")
    internal static let btnFilterActive = ImageAsset(name: "btn_filter_active")
    internal static let btnFilterInactive = ImageAsset(name: "btn_filter_inactive")
    internal static let icnAddItem = ImageAsset(name: "icnAddItem")
    internal static let icnEdit = ImageAsset(name: "icnEdit")
    internal static let icnLogoMain = ImageAsset(name: "icnLogoMain")
    internal static let icnTextStar = ImageAsset(name: "icnTextStar")
    internal static let icnLittleStarBlack = ImageAsset(name: "icn_littleStar_black")
    internal static let icnLittleStarWhite = ImageAsset(name: "icn_littleStar_white")
    internal static let icnStarBlack = ImageAsset(name: "icn_star_black")
    internal static let icnStarGreen = ImageAsset(name: "icn_star_green")
    internal static let icnWebtoon = ImageAsset(name: "icn_webtoon")
    internal static let imgSentenceBack = ImageAsset(name: "imgSentenceBack")
    internal static let imgSentenceFront = ImageAsset(name: "imgSentenceFront")
    internal static let pageActive = ImageAsset(name: "page_active")
    internal static let pageInactive = ImageAsset(name: "page_inactive")
  }
  internal enum Colors {
    internal static let background = ColorAsset(name: "background")
    internal static let black100 = ColorAsset(name: "black100")
    internal static let black200 = ColorAsset(name: "black200")
    internal static let gray100 = ColorAsset(name: "gray100")
    internal static let gray200 = ColorAsset(name: "gray200")
    internal static let gray300 = ColorAsset(name: "gray300")
    internal static let gray400 = ColorAsset(name: "gray400")
    internal static let green100 = ColorAsset(name: "green100")
    internal static let red100 = ColorAsset(name: "red100")
    internal static let white = ColorAsset(name: "white")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
