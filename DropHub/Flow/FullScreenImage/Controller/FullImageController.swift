// FullImageController.swift

import UIKit

final class FullImageController: UIViewController, FullImageControllerProtocol {
    
    private let scrollView = UIScrollView()
    private let contentImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        scrollView.constraintEdges(to: view)
        setupTapGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetImageState()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBack
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 3
        
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.clipsToBounds = true
        
        view.preSetView(newView: scrollView)
        scrollView.addSubview(contentImageView)
    }
    
    private func resetImageState() {
        scrollView.zoomScale = 1.0
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
        contentImageView.image = nil
        contentImageView.frame = .zero
        scrollView.contentSize = .zero
    }
}

extension FullImageController: UIGestureRecognizerDelegate {
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        let pointInScrollView = scrollView.convert(touchPoint, from: view)
        let imageViewFrame = contentImageView.frame
        
        // Если тапнули не по imageView (пустая область в scrollView)
        if !imageViewFrame.contains(pointInScrollView) {
            dismiss(animated: true)
        }
    }
}

extension FullImageController {
    func setImage(_ image: UIImage) {
        
        resetImageState()
        contentImageView.image = image
        view.layoutIfNeeded()
        
        let imageSize = image.size
        let scrollViewSize = scrollView.bounds.size
        
        let scaleW = scrollViewSize.width / imageSize.width
        let scaleH = scrollViewSize.height / imageSize.height
        
        let newScale = min(scaleH, scaleW)
        let minScale = min(scrollView.maximumZoomScale, max(scrollView.minimumZoomScale, newScale))
        
        let initialZoom = max(scrollView.minimumZoomScale,
                              min(scrollView.maximumZoomScale, minScale))
        
        contentImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: imageSize.width,
            height: imageSize.height
        )
        scrollView.contentSize = imageSize
        scrollView.zoomScale = initialZoom
        
        alignmentCentreForImage()
    }
    
    private func alignmentCentreForImage() {
        let scrollViewBounds = scrollView.bounds.size
        let contentImageViewFrame = contentImageView.frame.size
        
        let heightForImage = max((scrollViewBounds.height - contentImageViewFrame.height) / 2, 0)
        let weightForImage = max((scrollViewBounds.width - contentImageViewFrame.width) / 2, 0)
        
        scrollView.contentInset = UIEdgeInsets(top: heightForImage, left: weightForImage, bottom: heightForImage, right: weightForImage)
        scrollView.layoutIfNeeded()
    }
}

extension FullImageController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentImageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        alignmentCentreForImage()
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        alignmentCentreForImage()
    }
}
