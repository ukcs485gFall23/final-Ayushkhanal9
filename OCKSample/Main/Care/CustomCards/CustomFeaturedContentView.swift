//
//  CustomFeaturedContentView.swift
//  OCKSample
//
//  Created by Aayush Khanal on 12/12/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import UIKit
import CareKit
import CareKitUI

class CustomFeaturedContentView: OCKFeaturedContentView {
    var url: URL?

    // Need to override so we can become delegate when the user taps on card
    override init(imageOverlayStyle: UIUserInterfaceStyle = .unspecified) {
        // See that this always calls the super
        super.init(imageOverlayStyle: imageOverlayStyle)

        self.delegate = self
    }
    // swiftlint:disable:next line_length
    convenience init(url: String, imageOverlayStyle: UIUserInterfaceStyle = .unspecified, image: UIImage?, tipTitle: String, color: UIColor) {
        self.init(imageOverlayStyle: imageOverlayStyle)

        self.url = URL(string: url)
        self.imageView.image = image
        self.label.text = tipTitle
        self.label.textColor = color
    }
}

/// Need to conform to delegate in order to be delegated to.
extension CustomFeaturedContentView: OCKFeaturedContentViewDelegate {

    func didTapView(_ view: OCKFeaturedContentView) {
        // When tapped open a URL.
        guard let url = url else {
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
}
