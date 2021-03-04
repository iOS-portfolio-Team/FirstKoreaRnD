//
//  PWViewController.swift
//  IDRnd
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class PWViewController: UIViewController, DBPwChkProtocol {


    

    @IBOutlet weak var labelEmail: UITextField!
    @IBOutlet weak var labelPhone: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    @IBAction func btnFindPw(_ sender: UIButton) {
        
        
     
        let inputId = labelEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPhone = labelPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
      
        
        let dbPwCheck = DBPwChk()
        dbPwCheck.delegate = self
        dbPwCheck.check( userId: inputId,phone: inputPhone)
    
        
    }
    
    
    
    func pwResult(result: String) {
        if result == ""{
            labelResult.text = "가입된 정보가 없습니다."
            labelResult.textColor = UIColor.red
        }else{
            
            labelResult.text = "회원님 비밀번호는 \n'\(result)'입니다."
            labelResult.textColor = UIColor.blue
        }
    
        
        
    }
    
    
    
    
    
    // 키보드 없애기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
