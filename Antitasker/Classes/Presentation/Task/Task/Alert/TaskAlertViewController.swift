//
//  TaskAlertViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit
import RxSwift

final class TaskAlertViewController: UIViewController {
    enum Mode {
        case completed, deleted
    }
    
    lazy var mainView = TaskAlertView(mode: mode)

    private lazy var disposeBag = DisposeBag()

    private let mode: Mode
    private let didClose: (() -> Void)?

    private init(mode: Mode, didClose: (() -> Void)?) {
        self.mode = mode
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
                    base.didClose?()
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
extension TaskAlertViewController {
    static func make(mode: Mode, didClose: (() -> Void)? = nil) -> TaskAlertViewController {
        let vc = TaskAlertViewController(mode: mode, didClose: didClose)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: Private
private extension TaskAlertViewController {
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
