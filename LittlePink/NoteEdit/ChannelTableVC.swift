//
//  ChannelTableVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/10.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {

    var channel = ""
    var subChannels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subChannels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelVC = parent as! ChannelVC
        channelVC.PVDelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])

        //根据present及dismiss机制，子视图控制器的presentingViewController和父视图控制器一样（这里为NoteEditVC）
        //故这里用dimiss就等于是在父视图控制器中直接用dismiss
        dismiss(animated: true)
    }
    
}


extension ChannelTableVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
