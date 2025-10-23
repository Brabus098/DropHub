import UIKit

class FullImageController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .specialBack
        
        // 1. Настройка ScrollView
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.2
        scrollView.maximumZoomScale = 6.0
        
        // 2. Настройка ImageView
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.clipsToBounds = true
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentImageView)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // ScrollView на весь экран
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // ImageView внутри ScrollView
            contentImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            // Ключевое изменение: размер изображения не привязан к view
            contentImageView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor),
            contentImageView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        ])
    }
    
    func setImage(_ image: UIImage) {
        contentImageView.image = image
               view.layoutIfNeeded()

//        // Рассчитываем размер для contentSize
//        let imageSize = image.size
//        let viewSize = view.bounds.size
//        let widthRatio = viewSize.width / imageSize.width
//        let heightRatio = viewSize.height / imageSize.height
//        let minRatio = min(widthRatio, heightRatio)
//        
//        // Устанавливаем contentSize
//        scrollView.contentSize = CGSize(
//            width: imageSize.width * minRatio,
//            height: imageSize.height * minRatio
//        )
    }
}

extension FullImageController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentImageView
    }
}
