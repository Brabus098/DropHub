import UIKit

final class FullImageController: UIViewController, FullImageControllerProtocol {
    
    private let scrollView = UIScrollView()
    private let contentImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentImageView)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FullImageController {
    func setImage(_ image: UIImage) {
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
    
    func alignmentCentreForImage() {
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
}
