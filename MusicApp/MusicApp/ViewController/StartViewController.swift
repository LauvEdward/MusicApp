//
//  StartViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 25/07/2021.
//

import UIKit

@available(iOS 13.0, *)
class StartViewController: UIViewController {

    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var selectCountryButton: UIButton!
    var tranParentView = UIView()
    var tableView = UITableView()
    var frameSelect = CGRect()
    var datasource: [AppLanguage] = [AppLanguage.english, AppLanguage.vietnamese]
    var select: IndexPath = IndexPath(row: 0, section: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.selectCountryButton.backgroundColor = .grayColorMain
        self.selectCountryButton.setTitleColor(.white, for: .normal)
        
        self.nextButton.backgroundColor = .grayColorMain
        self.nextButton.setTitleColor(.white, for: .normal)
    }
    @IBAction func clickSelectCountry(_ sender: Any) {
        frameSelect = selectCountryButton.frame
        addTranparentview(frame: selectCountryButton.frame)
    }
    @IBAction func clickNext(_ sender: Any) {
        let vc = TabbarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = UITableViewCell()
        cell.textLabel?.text = datasource[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lang = datasource[indexPath.row]
        UserPreferences.shared.appLanguage = lang
        UserPreferences.shared.saveAppLanguage()
        LocalizeManager.shared.setSelectedLanguage(lang: datasource[indexPath.row].rawValue)
        self.selectCountryButton.setTitle(datasource[indexPath.row].text, for: .normal)
        self.dropdown()
    }
}

@available(iOS 13.0, *)
extension StartViewController {
    func addTranparentview(frame: CGRect) {
        let window = UIApplication.shared.keyWindow
        tranParentView.frame = window?.frame ?? self.view.frame
        tableView.frame = CGRect(x: frame.origin.x + self.stackView.frame.origin.x + self.parentStackView.frame.origin.x, y: frame.origin.y + frame.height + self.stackView.frame.origin.y + self.parentStackView.frame.origin.y, width: frame.width, height: 0)
        tableView.backgroundColor = UIColor.init(hexFromString: "F6F6F6")
        tableView.layer.shadowColor = UIColor.gray.cgColor
        tableView.layer.shadowOffset = .zero
        self.view.addSubview(tranParentView)
        self.view.addSubview(tableView)
        self.tableView.reloadData()
        self.tranParentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dropdown))
        tranParentView.addGestureRecognizer(tap)
        tranParentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.tranParentView.alpha = 0.05
            self.tableView.frame = CGRect(x: frame.origin.x + self.stackView.frame.origin.x + self.parentStackView.frame.origin.x, y: frame.origin.y + frame.height + self.stackView.frame.origin.y + self.parentStackView.frame.origin.y, width: frame.width, height: 80)
        } completion: { (_) in
            
        }
    }
    
    @objc func dropdown() {
        let frame = frameSelect
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.tableView.frame = CGRect(x: frame.origin.x + self.stackView.frame.origin.x + self.parentStackView.frame.origin.x, y: frame.origin.y + frame.height + self.stackView.frame.origin.y + self.parentStackView.frame.origin.y, width: frame.width, height: 0)
            self.tranParentView.alpha = 0
        } completion: { (_) in
        }
    }
}
