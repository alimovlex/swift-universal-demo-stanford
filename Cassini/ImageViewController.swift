//
//  ImageViewController.swift
//  Cassini
//
//  Created by robot on 4/1/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            
            scrollView.delegate = self;
            scrollView.minimumZoomScale = 0.03;
            scrollView.maximumZoomScale = 1.0;
            scrollView.contentSize = imageView.frame.size;
            scrollView.addSubview(imageView);
        }
    }
    
    var imageURL: URL? {
        didSet {
            image = nil;
            if view.window != nil {
            fetchImage();
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!;
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating();
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url);
                
                if let imageData = urlContents, url == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData);
                    }
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if image == nil {
            fetchImage();
        }
    }
    
    
    fileprivate var imageView = UIImageView();
    
    private var image: UIImage? {
        get {
            return imageView.image;
        }
        set {
            imageView.image = newValue;
            imageView.sizeToFit();
            scrollView?.contentSize = imageView.frame.size;
            spinner?.stopAnimating();
        }
    }
    
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView;
    }
}
