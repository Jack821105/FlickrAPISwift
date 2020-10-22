
# FlickrAPISwift

Flickr MVC Example project

這是Flickr圖像搜索模塊的基本示例，它會根據您的關鍵字搜索任何關鍵字，然後
用滾動顯示圖像，並且能上拉去載入更新的圖片，下拉會重新整理資料。

在此項目中，使用，** UICollectionView **用於顯示搜索結果。
它將調用請求異步並同時基於backgroud中的頁數顯示新圖像。


##  要求
* XCode 9.3或更高版本
* Swift 4.0

## Flickr API文檔

通過點擊[Flickr API] https://www.flickr.com/photos/190775964@N08/

-**搜索路徑：**

```
https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=3f92e427e0f27a1c0ef70176acf1c848&text=?&sort=date-posted-asc&per_page=?&format=json&nojsoncallback=1&page=?

```

``` swift
{
    "id": "23451156376",
    "owner": "28017113@N08",
    "secret": "8983a8ebc7",
    "server": "578",
    "farm": 1,
    "title": "Merry Christmas!",
    "ispublic": 1,
    "isfriend": 0,
    "isfamily": 0
}
```
