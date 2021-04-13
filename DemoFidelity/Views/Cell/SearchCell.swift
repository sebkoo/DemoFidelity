//
//  SearchCell.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class SearchCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var background: UIView!
  
  public var viewModel: CellViewModel!{
    didSet { self.configureUI() }
  }
  
  // MARK: - set UI
  private func configureUI() {
    iconView.image = UIImage(named: "placeholder")
    iconView.download(imageURL: viewModel.imageURL)
    titleLabel.text = viewModel.title
    synopsisLabel.text = viewModel.synopsis
    typeLabel.text = viewModel.type
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
