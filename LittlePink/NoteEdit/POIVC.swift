//
//  POIVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/10.
//

import UIKit

class POIVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


// MARK: - UITableViewDataSource
extension POIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
//
//        let poi = pois[indexPath.row]
//        cell.poi = poi
//
//        if poi[0] == poiName{ cell.accessoryType = .checkmark }
//
//        return cell
        return UITableViewCell()
    }
}
// MARK: - UITableViewDelegate
extension POIVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)!
//        cell.accessoryType = .checkmark
//
//        delegate?.updatePOIName(pois[indexPath.row][0])
//
//        dismiss(animated: true)
    }
}
