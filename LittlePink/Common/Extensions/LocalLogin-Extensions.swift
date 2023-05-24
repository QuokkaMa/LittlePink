//
//  LocalLogin-Extensions.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/5/22.
//

import Foundation
import Alamofire

extension UIViewController{
    
    func localLogin(){
        showLoadHUD()
        let config = JVAuthConfig()
        config.appKey = kJAppKey
        config.authBlock = { _ in
            if JVERIFICATIONService.isSetupClient(){
                //预取号（可验证当前运营商网络是否可以进行一键登录操作）--取的手机号为139****1234
                JVERIFICATIONService.preLogin(5000) { (result) in
                    self.hideLoadHUD()
                    if let code = result!["code"] as? Int, code == 7000 {
                        //当前设备可使用一键登录
                        self.setLocalLoginUI()
                        self.presentLocalLoginVC()
                        
                    }else{
                        print("当前设备不可使用一键登录")
//                        self.presentCodeLoginVC()
                    }
                }
            }else{
                self.hideLoadHUD()
                print("初始化一键登录失败")
//                self.presentCodeLoginVC()
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
    
    // MARK: 弹出一键登录授权页+用户点击登录后
    private func presentLocalLoginVC(){
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5*1000, completion: { (result) in
            if let loginToken = result!["loginToken"] as? String {
                //一键登录成功
                JVERIFICATIONService.clearPreLoginCache()
                
                print("loginToken: \(loginToken)")
                // MARK: 发送token到我们自己的服务器
                //1.服务器收到后携带此token并调用运营商接口（参考极光REST API）--可用postman模拟发送（注意鉴权和body中发参数）
                //2.成功则返回被公钥加密后的用户手机号，需在服务端解密（可在公私钥网站解密）得出明文手机号
                //3.手机号存入数据库等操作后向客户端返回登录成功的信息
                //self.getEncryptedPhoneNum(loginToken)
            }else{
                print("一键登录失败")//可提示用户UI并指引用户接下来的操作
                self.otherLogin()
            }
        }) { (type, content) in
            //授权页事件触发回调，根据type事件类型来判断页面上的事件
            print("一键登录 actionBlock :type = \(type), content = \(content)")
        }
    }
    
}

// MARK: - 监听
extension UIViewController{
    @objc func otherLogin(){
        JVERIFICATIONService.dismissLoginController(animated: true) {
//            self.presentCodeLoginVC()
        }
    }
    @objc func dismissLocalLoginVC(){
        //JVERIFICATIONService.dismissLoginController(animated: true, completion: nil )
    }
}

// MARK: - 一般函数
//extension UIViewController{
//    func presentCodeLoginVC(){
//        let mainSB = UIStoryboard(name: "Main", bundle: nil)
//        let loginNaviC = mainSB.instantiateViewController(identifier: kLoginNaviID)
//        loginNaviC.modalPresentationStyle = .fullScreen
//        present(loginNaviC, animated: true)
//    }
//}
// MARK: - UI
extension UIViewController{

    private func setLocalLoginUI(){
        let config = JVUIConfig()
        
        //状态栏
        config.prefersStatusBarHidden = true
        
        //导航栏
        config.navTransparent = true
        config.navText = NSAttributedString(string: " ")
        //因默认的关闭按钮在浅色模式下和底色融为一体了,故先隐藏掉他,再重新做一个按钮
        config.navReturnHidden = true
        config.navControl = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(dismissLocalLoginVC))
        
        //统一的水平居中约束
        let constraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)!
        
        //logo
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/7, constant: 0)!
        config.logoConstraints = [constraintX, logoConstraintY]
        
        //手机号码
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.numberConstraints = [constraintX,numberConstraintY]
        
        //slogan-xx运营商提供认证服务的标语
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.sloganConstraints = [constraintX, sloganConstraintY]
        
        //一键登录按钮
        config.logBtnText = "同意协议并一键登录"
        config.logBtnImgs = [
            UIImage(named: "localLoginBtn-nor")!,
            UIImage(named: "localLoginBtn-nor")!,
            UIImage(named: "localLoginBtn-hig")!
        ]
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)!
        config.logBtnConstraints = [constraintX, logBtnConstraintY]
        
        //隐私协议勾选框
        config.privacyState = true
        config.checkViewHidden = true
        
        //用户协议和隐私政策
        config.appPrivacyOne = ["用户协议","https://www.cctalk.com/m/group/86306378"]
        config.appPrivacyTwo = ["隐私政策","https://www.cctalk.com/m/group/86308246"]
        config.privacyComponents = ["登录注册代表你已同意","以及","和"," "]

        config.appPrivacyColor = [UIColor.secondaryLabel, blueColor]
        config.privacyTextAlignment = .center
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)!
        let privacyConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)!
        config.privacyConstraints = [constraintX,privacyConstraintY,privacyConstraintW]
        
        //隐私协议页面
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")!
        
        //运行自定义的UI并自定义一个button加到customView上
        JVERIFICATIONService.customUI(with: config){ customView in
            guard let customView = customView else { return }

            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("其他方式登录", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpInside)
            customView.addSubview(otherLoginBtn)

            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 170),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
        }
    }
}

extension UIViewController{
    
    struct LocalLoginRes: Decodable {
        let phone: String
    }
    
    private func getEncryptedPhoneNum(_ loginToken: String){
        
        //测试时需把Master Secret改成自己的
        let headers: HTTPHeaders = [
            .authorization(username: kJAppKey, password: "Master Secret")
        ]
        
        let parameters = ["loginToken": loginToken]
        
        AF.request(
            "https://api.verification.jpush.cn/v1/web/loginTokenVerify",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).responseDecodable(of: LocalLoginRes.self) { response in
            if let localLoginRes = response.value{
                print(localLoginRes.phone)
            }
        }
        
        
    }
}

