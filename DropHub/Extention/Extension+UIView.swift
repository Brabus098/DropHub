//  Extension+UIView.swift

import UIKit

extension UIView {
    func preSetView(newView: UIView){
        self.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
    }

    func constraintEdges(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
