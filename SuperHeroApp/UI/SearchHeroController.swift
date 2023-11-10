//
//  ViewController.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import UIKit

class SearchHeroController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var heros = Heros()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.herosTableView.dequeueReusableCell(withIdentifier: HeroCell.identifier, for: indexPath) as! HeroCell
        cell.hero = heros[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var herosTableView: UITableView!
    
    @IBAction func searchHero(_ sender: UIButton) {
        
        guard let name = searchTextField.text else { return }
        
        HeroService().getAll(name: name) { success, data, error in
            if success {
                self.heros = data!
                DispatchQueue.main.async {
                    self.herosTableView.reloadData()
                }
            }
        }
    }
    
    func initView() {
        self.herosTableView.register(HeroCell.nib, forCellReuseIdentifier: HeroCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }


}

