
import UIKit
import Combine
class ViewController: UIViewController {

    
    @IBOutlet weak var userNameF: UITextField!
    
    @IBOutlet weak var passwordF: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @Published private var userName:String = "a"
    @Published private var password:String = "a"
    
    private var subsciptions:Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var signUpValidationPublisher:AnyPublisher<Bool,Never> {
        return Publishers.CombineLatest($userName, $password)
            .map{userName,password in
                !userName.isEmpty && !password.isEmpty
            }.eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled,on:signUpBtn)
            .store(in: &subsciptions)
        
        userNameF.addTarget(self, action: #selector(onUserNameChanged), for: .editingChanged)
        
        passwordF.addTarget(self, action: #selector(onPasswordChanged), for: .editingChanged)
        
        signUpBtn.addTarget(self, action: #selector(onTappedSignUp), for: .touchUpInside)
    }


    @objc func onUserNameChanged(_ sender: UITextField) {
        self.userName = sender.text ?? ""
    }
    
    @objc func onPasswordChanged(_ sender: UITextField) {
        self.password = sender.text ?? ""
    }
    

    @objc func onTappedSignUp(){
        

    }
    
    
}

