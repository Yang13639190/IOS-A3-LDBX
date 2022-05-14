//
//  LoginViewController.swift
//  IOS Assignment3
//
//  Created by 阳力强 on 11/5/2022.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var remerber: UISwitch!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
   
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func loginClick(_ sender: Any) {
        
        if self.remerber.isOn{
            
            UserDefaults.standard.setValue(self.name.text, forKey: "remembername")//记住账号
            UserDefaults.standard.setValue(self.password.text, forKey: "rememberpassword")//记住密码
        }
        
        let name = self.name.text
        let pwd = self.password.text
        if name == "" {
            alert(message: "账户不能为空")
            
            return;
        }
        if  pwd == "" {
            alert(message: "密码不能为空")
            return;
        }
        
        //获取账号存储信息
        let defaults = UserDefaults.standard
        // 读取
        if let userPass = defaults.string(forKey: self.name.text!) {
            //当前账号信息与存储信息比对
            if  userPass == self.password.text {
                
                
                
                UserDefaults.standard.setValue(self.name.text, forKey: "username")
                if self.remerber.isOn{
                    
                    UserDefaults.standard.setValue(self.name.text, forKey: "remembername")//记住账号
                    UserDefaults.standard.setValue(self.password.text, forKey: "rememberpassword")//记住密码
                }
                UserDefaults.standard.synchronize()
                
                //延迟0.5秒
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //将当前的view视图给移除
                    self.dismiss(animated: true)
                }
                
                
               
                return

            }
        }
        
        
        return alert(message: "账号密码错误或没有注册哦")
    }
    @IBAction func registerClick(_ sender: Any) {
        let rvc = RegisterViewController()
        self.present(rvc, animated:true, completion:nil)
//        self.navigationController!.pushViewController(rvc, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        self.title = "登录";
        self.login.layer.masksToBounds =  true
        self.login.layer.cornerRadius = 5
        
        let remembername = UserDefaults.standard.string(forKey: "remembername");
        let rememberpassword = UserDefaults.standard.string(forKey: "rememberpassword");
       
        self.name.text = remembername
        self.password.text = rememberpassword
        
        
    }
    
    
    func alert(message: String){
      
        let alert = UIAlertController(title:"提示",message:message,preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"确定",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("确定")})
            
        let unKnown = UIAlertAction(title:"取消" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("取消")
            })
            
            
            
            alert.addAction(no)
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)

    }
    
    
    func fillUserData(name: String, pwd: String) {
        user = User()
        user.userPwd = pwd
        user.userName = name
    }
    
    /// 用户
    public struct User{
        
        /// 用户名
        public var userName: String?
        
        /// 密码
        public var userPwd: String?
        
        public init(){
            self.userName = ""
            self.userPwd = ""
        }
        
        public init(userName: String, userPwd: String){
            self.userName = userName
            self.userPwd = userPwd
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
