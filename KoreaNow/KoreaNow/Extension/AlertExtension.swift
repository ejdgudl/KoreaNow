//
//  AlertExtension.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/04.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - AlertController
    
    func alertNormal(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "로그아웃", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
