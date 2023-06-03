//
//  DiscontentAlertViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 03.06.2023.
//

import UIKit
import RxSwift

final class DiscontentAlertViewController: UIViewController {
    lazy var mainView = DiscontentAlertView(name: name)

    private lazy var disposeBag = DisposeBag()

    private let name: String
    private let didClose: (() -> Void)

    private init(name: String, didClose: @escaping (() -> Void)) {
        self.name = name
        self.didClose = didClose

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.button.rx.tap
            .bind(to: Binder(self) { base, void in
                base.animateDismiss {
                    base.didClose()
                }
            })
            .disposed(by: disposeBag)

        prepareToAnimate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateShow()
    }
}

// MARK: Make
extension DiscontentAlertViewController {
    static func make(name: String, didClose: @escaping (() -> Void)) -> DiscontentAlertViewController {
        let vc = DiscontentAlertViewController(name: name, didClose: didClose)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: Private
private extension DiscontentAlertViewController {
    func prepareToAnimate() {
        mainView.backgroundColor = UIColor.black.withAlphaComponent(0)
        mainView.container.alpha = 0
    }
    
    func animateShow() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self?.mainView.container.alpha = 1
        })
    }
    
    func animateDismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.mainView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self?.mainView.container.alpha = 0
        }, completion: { [weak self] result in
            self?.dismiss(animated: false) {
                completion?()
            }
        })
    }
}
