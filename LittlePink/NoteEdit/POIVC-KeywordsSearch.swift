//
//  POIVC-KeywordsSearch.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/13.
//


// MARK: - UISearchBarDelegate
extension POIVC: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {dismiss(animated: true)}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            //重置(reset)
            pois = aroundSearchedPOIs //恢复为之前周边搜索的数据
            setAroundSearchFooter() //恢复为周边搜索的上拉加载功能(防止之前是从关键字搜索过来的)
            tableView.reloadData()
        }
    }
    
    // MARK: 关键字搜索POI
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        
        keywords = searchText
        //重置(reset)
        pois.removeAll() //恢复为检索前的空数据状态
        currentKeywordsPage = 1 //恢复内存中的当前页数(防止还停留在之前一次的关键字检索中,比如之前加载了3页,这次检索开始时就为3)
               
        setKeywordsSearchFooter()
        
        showLoadHUD()
        makeKeywordsSearch(keywords)
        
    }
        
}

// MARK: - AMapSearchDelegate
extension POIVC: AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {

        hideLoadHUD()
        
        
        let poiCount = response.count
        
        if poiCount > kPOIsOffset{
            pageCount = poiCount / kPOIsOffset + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
        if poiCount == 0 {return}
        
        for poi in response.pois{
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"
            ]
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest{
                aroundSearchedPOIs.append(poi)
            }
        }
        
        tableView.reloadData()
    }
}


// MARK: - 一般函数
extension POIVC{
    private func makeKeywordsSearch(_ keywords: String, _ page: Int = 1){
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    private func setKeywordsSearchFooter(){
        //重置(reset)
        footer.resetNoMoreData() //恢复为正常footer(防止因之前加载完毕后footer的不可用)
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
}
// MARK: - 监听
extension POIVC{
    @objc private func keywordsSearchPullToRefresh(){
        currentKeywordsPage += 1
        makeKeywordsSearch(keywords, currentKeywordsPage)
        // 最后刷新
        endRefreshing(currentKeywordsPage)
    }
}

