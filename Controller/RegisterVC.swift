//
//  RegisterViewController.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 2.01.2024.
//

import Foundation
import UIKit

protocol RegisterVC_Delegate: AnyObject{
    func didSuccessRegister(_ Vc: RegisterViewController)
}

class RegisterViewController: UIViewController{
    weak var delegate: RegisterVC_Delegate?
    
    private var viewModel = RegisterViewModel()
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attrributedText(firstString: "Already have account ", secondString: "Sign In")
        button.setHeight(50)
        button.layer.cornerRadius =  7
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    private lazy var choosePhootoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(handleChoosePhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTF = CustomTextField(placeHolder: "Email", keyboardType: .emailAddress)
    private let passwordTF = CustomTextField(placeHolder: "Password", isSecure: true)
    private let fullnameTF = CustomTextField(placeHolder: "Full Name")
    private let userNameTF = CustomTextField(placeHolder: "User Name")
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.defaultButton(buttonText: "Sign Up")
        return button
    }()
    
    private var profileImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureForTextField()
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        alreadyHaveAccountButton.centerX(inView: view)
        
        view.addSubview(choosePhootoButton)
        choosePhootoButton.centerX(inView: view)
        choosePhootoButton.anchor(top:view.safeAreaLayoutGuide.topAnchor)
        
        let stakeView = UIStackView(arrangedSubviews: [emailTF,passwordTF,fullnameTF,userNameTF, signUpButton])
        stakeView.axis = .vertical
        stakeView.spacing = 20
        
        view.addSubview(stakeView)
        stakeView.anchor(top: choosePhootoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30,paddingLeft: 30,paddingRight: 30)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    private func configureForTextField(){
        emailTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
        userNameTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
        fullnameTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
    }
    
    @objc func handleAlreadyHaveAccount(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleChoosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func handleSignUp(){
        guard let userName = userNameTF.text?.lowercased() else {return}
        guard let fullName = fullnameTF.text else {return}
        guard let email = emailTF.text?.lowercased() else {return}
        guard let password = passwordTF.text else {return}
        guard let profileImage = profileImage else {return}
        
        let user = AuthInfo(userName: userName, email: email, password: password, fullName: fullName, profileImage: profileImage)
        AuthServices.registerUser(userInfo: user) {error in
            if let error = error {
                
                print("kllaanıcı oluşmadı")
                print(error.localizedDescription)
                return
            }
        }
        delegate?.didSuccessRegister(self)
    }
    
    @objc func handleTextChanged(sender: UITextField){
        if sender == emailTF{
            viewModel.email = sender.text
        } else if sender == passwordTF{
            viewModel.password = sender.text
        } else if sender == userNameTF{
            viewModel.userName = sender.text
        } else{
            viewModel.fullName = sender.text
        }
        uptadeButton()
    }
    private func uptadeButton(){
        signUpButton.isEnabled = viewModel.isEmpty
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }

}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        self.profileImage = selectedImage
        choosePhootoButton.layer.cornerRadius = choosePhootoButton.frame.width / 2
        choosePhootoButton.layer.masksToBounds = true
        choosePhootoButton.layer.borderColor = #colorLiteral(red: 0.08050254732, green: 0.07995598763, blue: 0.07094972581, alpha: 0.6647868377).cgColor
        choosePhootoButton.layer.borderWidth = 3
        choosePhootoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        picker.dismiss(animated: true)
    }
}

/*
 1.İlk Sayfa (kapak)
 2.İçindekiler Tablosu
 3.Yönetici Özeti
 4.İşletme ve Endüstri Profili
 5.Pazar ve Rekabet Analizi
 6.Pazarlama Planı
 7.Yönetim ve Organizasyon
 8.Üretim Planı (eğer üretici bir şirketse)
 9.Yerleşim Planı (şirketin doğasına bağlı)
 10.Mali Plan

 11.Uyg
 1.Uygulama Planı
 12.Acil Durum Planları
 13.Ekler (varsa)

 İş planının nasıl hazırlanacağını ve planın her bir bölümünün ne içermesi gerektiğini daha iyi anlamak için İş Planı Literatürünü okuyabilir ve İş Planı Örneklerine (görevde istenen tüm unsurları içermeyebilen ekteki örnekler) dayanarak bir iş planının nasıl göründüğüne dair bir model edinebilirsiniz.

 Başarılar dilerim!
 User
 şimdi sana bir iş planı örneği söyleyeceğim ve lütfen bana mantıklı olup olmadığını söyle.
 bence üniversitelerde sıcak simit makineleri koymak ve bu makinelerin öğrenciye hamurdan hızlıca sıcak simit yapıp almasını sağlama fikri mantıklı mı

 ChatGPT
 Üniversite kampüslerinde sıcak simit makineleri kurma fikri oldukça ilginç ve potansiyel açısından değerlendirilebilir. Bu fikrin mantıklılığını değerlendirmek için çeşitli faktörleri göz önünde bulundurmak gerekir:

 Hedef Kitle: Üniversite öğrencileri genellikle hızlı ve uygun fiyatlı yiyecek seçeneklerine yönelirler. Sıcak simit, özellikle sabahları ve ara öğünler için popüler bir seçim olabilir.
 Konum: Üniversite kampüsleri genellikle yoğun nüfusa sahiptir. Simit makinelerinin, öğrencilerin sıkça uğradıkları yerlere yakın konumlandırılması önemlidir (örneğin, kütüphane girişleri, dersliklerin yakını, yemek alanları).
 Hız ve Kolaylık: Öğrenciler genellikle zamanla sınırlıdır, bu nedenle hızlı ve kolay erişilebilir yiyecek seçenekleri tercih edilir. Makinenin hamurdan hızlıca sıcak simit yapabilmesi bu açıdan avantaj sağlayabilir.
 Maliyet ve Fiyatlandırma: Üretim maliyetleri ve son tüketiciye sunulacak simitin fiyatlandırması, bu iş fikrinin sürdürülebilirliğini büyük ölçüde etkiler.
 Sağlık ve Güvenlik Standartları: Gıda üretimi ve dağıtımı ile ilgili sağlık ve güvenlik standartlarına uyulması gerekmektedir. Bu, gerekli izinlerin alınmasını ve düzenli bakımın yapılmasını gerektirir.
 Teknoloji ve İnovasyon: Simit yapımını otomatize edecek makinenin teknolojik altyapısı, verimlilik ve ürün kalitesi açısından önemlidir.
 Pazarlama ve Tanıtım: Öğrenciler arasında farkındalık yaratmak ve makineleri popüler hale getirmek için etkili pazarlama stratejileri geliştirilmelidir.
 Sonuç olarak, üniversite kampüslerinde sıcak simit makineleri koymak, doğru planlama ve uygulama ile başarılı olabilecek yenilikçi ve ilgi çekici bir iş fikri olarak görülebilir. Ancak, bu tür bir girişimin başarısı, pazar araştırması, maliyet analizi, teknolojik altyapı ve operasyonel yönetim gibi faktörlere bağlı olacaktır.
 User
 1.İlk Sayfa (kapak)
 2.İçindekiler Tablosu
 3.Yönetici Özeti
 4.İşletme ve Endüstri Profili
 5.Pazar ve Rekabet Analizi
 6.Pazarlama Planı
 7.Yönetim ve Organizasyon
 8.Üretim Planı (eğer üretici bir şirketse)
 9.Yerleşim Planı (şirketin doğasına bağlı)
 10.Mali Plan

 11.Uygulama Planı
 12.Acil Durum Planları
 13.Ekler (varsa)
 şimdi bu iş fikrini gerçekleştirdiğimizi farz edelim bu fikir için üstteki adımları benim için doldurur musun

 ChatGPT
 Elbette, üniversitelerde sıcak simit makineleri kurma iş fikrinizi gerçekleştirdiğimizi varsayarak, iş planınızı yukarıda belirtilen adımlar doğrultusunda doldurabilirim. İşte her bir bölüm için temel bir taslak:

 İlk Sayfa (Kapak):
 Şirketin Adı
 Logo
 İletişim Bilgileri
 Hazırlama Tarihi
 İçindekiler Tablosu:
 Her bölümün ve alt başlığın sayfa numaraları ile birlikte listesi.
 Yönetici Özeti:
 İş fikrinin kısa özeti.
 Beklenen başarı ve pazarın potansiyeli.
 Neden bu işin başarılı olacağına dair anahtar noktalar.
 İşletme ve Endüstri Profili:
 Şirketin misyonu ve vizyonu.
 Gıda sektörü ve özellikle simit piyasasındaki trendler.
 Teknolojik yenilikler ve otomatik gıda üretiminin rolü.
 Pazar ve Rekabet Analizi:
 Hedef pazarın demografik özellikleri.
 Rakip analizi ve pazardaki benzersiz konumlandırma.
 Pazarın büyüklüğü ve potansiyel büyüme.
 Pazarlama Planı:
 Ürün tanıtımı ve markalaşma stratejileri.
 Reklam ve promosyon faaliyetleri.
 Sosyal medya ve dijital pazarlama taktikleri.
 Yönetim ve Organizasyon:
 Yönetim ekibi ve rolleri.
 İşletme yapısı ve personel ihtiyaçları.
 İşbirlikleri ve ortaklıklar.
 Üretim Planı:
 Makine üretimi ve kurulumu.
 Gıda güvenliği ve kalite kontrol prosedürleri.
 Tedarik zinciri yönetimi.
 Yerleşim Planı:
 Makinelerin yerleştirileceği üniversite kampüsleri.
 Fiziksel altyapı ve bakım gereksinimleri.
 Mali Plan:
 Başlangıç sermayesi ve finansman kaynakları.
 Gelir ve gider tahminleri.
 Karlılık analizi ve maliyet kontrolü.
 Uygulama Planı:
 Projenin zaman çizelgesi.
 Aşamalar halinde görevler ve sorumluluklar.
 Başarı ölçütleri ve değerlendirme süreçleri.
 Acil Durum Planları:
 Teknik arızalar ve gıda güvenliği sorunları için prosedürler.
 Kriz yönetimi ve risk azaltma stratejileri.
 Ekler (varsa):
 Pazar araştırması verileri.
 Finansal projeksiyonlar ve tablolar.
 Hukuki belgeler ve lisanslar.
 */
