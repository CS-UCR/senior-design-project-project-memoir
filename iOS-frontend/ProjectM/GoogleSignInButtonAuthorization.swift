//
//  GoogleSignInButtonAuthorization.swift
//  ProjectM
//
//  Created by Carlos Loeza on 10/26/21.
//
import AuthenticationServices
import UIKit

@IBDesignable
class GoogleSignInButtonAuthorization: UIButton {

    private var authorizationButton: ASAuthorizationAppleIDButton!
    
    // init's allow our button to used in storyboard
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        // Create ASAuthorizationAppleIDButton
        authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)

        // Show authorizationButton
        addSubview(authorizationButton)

        // Use auto layout to make authorizationButton follow the MyAuthorizationAppleIDButton's dimension
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            authorizationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            authorizationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            authorizationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        ])
    }

}


