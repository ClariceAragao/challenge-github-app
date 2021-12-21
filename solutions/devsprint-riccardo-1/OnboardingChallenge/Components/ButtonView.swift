//
//  ButtonView.swift
//  OnboardingChallenge
//
//  Created by Pedro Gabriel on 15/12/21.
//

import UIKit

struct ButtonViewConfiguration {
    let title: String
    var pressedButton: (() -> Void)?
}

class ButtonView: UIView {
    // MARK: Properties
    private var pressedButton: (() -> Void)?
    
    private lazy var button: UIButton = {
        var button = UIButton(type: .system)

        button.layer.cornerRadius = 15
        button.backgroundColor = .systemBlue
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        configureSubviews()
        configureSubviewsConstraints()
        configureAdditionalBehaviors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override var intrinsicContentSize: CGSize {
        return button.intrinsicContentSize
    }
    
    // MARK: Actions
    @objc
    private func buttonPressed() {
        pressedButton?()
    }
    
    // MARK: Methods
    func configure(with configuration: ButtonViewConfiguration) {
        pressedButton = configuration.pressedButton
        button.setTitle(configuration.title, for: .normal)
    }
}

// MARK: ViewCode Extensions
extension ButtonView {
    func configureSubviews() {
        addSubview(button)
    }
    
    func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureAdditionalBehaviors() {}
}

// MARK: Preview
#if DEBUG
 import SwiftUI

 struct ButtonView_Preview: PreviewProvider {
     static var previews: some View {
         return SwiftUIPreView { context in
             let config = ButtonViewConfiguration(title: "Some button") {
                 print("do something")
             }
             let view = ButtonView()
             view.configure(with: config)
             return view
         }
             .padding()
             .frame(width: .infinity, height: 80)
     }
 }
 #endif