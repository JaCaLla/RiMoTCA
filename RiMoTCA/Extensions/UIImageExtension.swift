//
//  UIImageExtension.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit

extension UIImageView {

    // MARK: - Typealias
    typealias Completion = (ImageError?) -> Void

    // MARK: - Error enum
    enum ImageError: Error {
        case badRequest
        case general
        case imageUnparseable
        case invalidData
    }
    
    func setImage(from url: URL?,
                  alpha: CGFloat = 0,
                  removeCurrentIfNil removeIfNil: Bool = true,
                  completed: Completion? = nil) async {
        self.alpha = alpha
        if let imageFromCache = ImagesCache.shared.object(forKey: url as AnyObject) as? UIImage {
            animateImage(image: imageFromCache, removeIfNil: removeIfNil, completed: completed)
            return
        }
        let response = await request(url: url)
        switch response {
        case .success(let image):
            self.animateImage(image: image, removeIfNil: removeIfNil, completed: completed)
        case .failure(let error):
            self.animateImage(removeIfNil: removeIfNil, completed: completed, error: error)
        }
    }

    private func animateImage(image: UIImage? = nil,
                              removeIfNil: Bool,
                              completed: Completion? = nil,
                              error: ImageError? = nil) {
        if image != nil || removeIfNil {
            self.image = image
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }, completion: { _ in
            completed?(error)
        })
    }

    // MARK: - Private Methods
    private func request(url: URL?) async -> Result<UIImage, ImageError> {

        guard let request = makeRequest(url) else {
            return .failure(.badRequest)
        }

        do {
            let dataURLResponse = try await URLSession.shared.data(for: request)
            
            guard let response = dataURLResponse.1 as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.invalidData)
            }
            if let image = UIImage(data: dataURLResponse.0 ) {
                ImagesCache.shared.setObject(image, forKey: url as AnyObject)
                return .success(image)
            } else {
                return .failure(.imageUnparseable)
            }
        } catch {
            return .failure(.general)
        }
    }

    private func makeRequest(_ route: URL?) -> URLRequest? {
        guard let url = route else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
