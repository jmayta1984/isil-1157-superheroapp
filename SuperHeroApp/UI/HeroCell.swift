//
//  HeroCell.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import UIKit

class HeroCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var hero: Hero? {
        didSet {
            nameLabel.text = hero?.name
            fullNameLabel.text = hero?.biography.fullName
            posterImageView.loadImage(from: hero?.image.url ?? "")
            checkFavorite()
        }
    }
    
    var isFavorite = false {
        didSet {
            favoriteButton.tintColor = isFavorite ? .red : .gray
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()

    }
    
    func checkFavorite(){
        guard let hero = hero else { return }
        isFavorite = HeroDao().isFavorite(id: hero.id)
    }
    
    func initView() {
        posterImageView.contentMode = ContentMode.scaleAspectFill
        posterImageView.layer.cornerRadius = 8
        
    }
    @IBAction func saveFavorite(_ sender: UIButton) {
        guard let hero = hero else { return }
        isFavorite = !isFavorite
        if isFavorite {
            HeroDao().insert(id: hero.id, name: hero.name)
        }
        else {
            HeroDao().delete(id: hero.id)
        }
    }
}
