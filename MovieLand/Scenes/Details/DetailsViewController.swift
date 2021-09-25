//
//  DetailsViewController.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Kingfisher
import SafariServices
import UIKit

protocol DetailsViewImplementable: AnyObject {
    var viewModel: DetailsViewModelImplementable? { get set }

    var movieId: Int? { get set }

    func display(_ details: Details.Model)
    func displayAlert(_ alert: Details.Alert)
}

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModelImplementable?
    var movieId: Int?

    // MARK: - Outlets

    @IBOutlet var containerView: UIView!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet var backdropImageViewHeight: NSLayoutConstraint!

    // MARK: - Properties

    private var model: Details.Model?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        let closeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Close"), style: .done, target: self, action: #selector(didTapClose(_:)))
        navigationItem.leftBarButtonItem = closeButton

        containerView.isHidden = true

        guard let movie = movieId else {
            displayAlert(withTitle: "Oops", message: "No movie selected")
            return
        }

        viewModel?.display(movie)
    }

    // MARK: - Actions

    @IBAction func didTapImdb(_ sender: Any) {
        navigateToImdb()
    }

    @objc private func didTapClose(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    private func navigateToImdb() {
        guard let imdbURL = model?.imdb else { return }
        openLink(imdbURL)
    }

    private func openLink(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .formSheet
        present(safariViewController, animated: true, completion: nil)
    }
}

// MARK: - DetailsViewImplementable

extension DetailsViewController: DetailsViewImplementable {
    func display(_ details: Details.Model) {
        model = details
        DispatchQueue.main.async {
            let url = URL(string: details.backdrop)
            self.backdropImageView.kf.setImage(with: url, placeholder: nil, options: nil) { result in
                switch result {
                case let .success(response):
                    let image = response.image
                    let ratio = image.size.width / image.size.height
                    let newHeight = self.backdropImageView.frame.width / ratio
                    self.backdropImageViewHeight.constant = newHeight
                    self.containerView.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.view.layoutIfNeeded()
                case .failure:
                    self.containerView.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            }
            self.rateLabel.attributedText = details.rate
            self.dateLabel.text = details.date
            self.titleLabel.text = details.title
            self.descriptionLabel.text = details.description
        }
    }

    func displayAlert(_ alert: Details.Alert) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.displayAlert(withTitle: alert.title, message: alert.message)
        }
    }
}
