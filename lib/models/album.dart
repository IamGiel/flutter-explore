class Album {
  final int total;
  final int totalHits;
  final List hits;

  Album({this.total, this.totalHits, this.hits});

  factory Album.fromJson(Map<dynamic, dynamic> json) {
    return Album(
        total: json['userId'],
        totalHits: json['totalHits'],
        hits: json['hits']);
  }
}

// {
//     "total": 1340971,
//     "totalHits": 500,
//     "hits": [
//         {
//             "id": 474351,
//             "pageURL": "https://pixabay.com/photos/stinging-nettle-leaves-burning-hair-474351/",
//             "type": "photo",
//             "tags": "stinging nettle, leaves, burning hair",
//             "previewURL": "https://cdn.pixabay.com/photo/2014/10/05/03/17/stinging-nettle-474351_150.jpg",
//             "previewWidth": 150,
//             "previewHeight": 99,
//             "webformatURL": "https://pixabay.com/get/52e7d1404f53b10ff3d8992cc6203f7c153bd8e64e507749762b79d59f4acc_640.jpg",
//             "webformatWidth": 640,
//             "webformatHeight": 426,
//             "largeImageURL": "https://pixabay.com/get/52e7d1404f53b108f5d0846096293f76173fdae3504c704f752c7fd69645c251_1280.jpg",
//             "imageWidth": 6000,
//             "imageHeight": 4000,
//             "imageSize": 3667610,
//             "views": 43360,
//             "downloads": 28292,
//             "favorites": 86,
//             "likes": 107,
//             "comments": 23,
//             "user_id": 2,
//             "user": "Hans",
//             "userImageURL": "https://cdn.pixabay.com/user/2019/01/29/15-01-52-802_250x250.jpg"
//         },
//         {
//             "id": 5665074,
//             "pageURL": "https://pixabay.com/photos/storm-farm-house-farm-house-5665074/",
//             "type": "photo",
//             "tags": "storm, farm, house",
//             "previewURL": "https://cdn.pixabay.com/photo/2020/10/18/15/24/storm-5665074_150.jpg",
//             "previewWidth": 150,
//             "previewHeight": 100,
//             "webformatURL": "https://pixabay.com/get/53e6d3464a55a814f1dc846096293f76173fdae3504c704f752c7fd69645c251_640.jpg",
//             "webformatWidth": 640,
//             "webformatHeight": 427,
//             "largeImageURL": "https://pixabay.com/get/53e6d3464a55a814f6da8c7dda7936761d3ddee155526c48732f78d0954ccd5fb1_1280.jpg",
//             "imageWidth": 7087,
//             "imageHeight": 4724,
//             "imageSize": 7785186,
//             "views": 15593,
//             "downloads": 14907,
//             "favorites": 35,
//             "likes": 87,
//             "comments": 70,
//             "user_id": 3764790,
//             "user": "enriquelopezgarre",
//             "userImageURL": "https://cdn.pixabay.com/user/2020/09/01/06-45-36-722_250x250.jpg"
//         },
//         {
//             "id": 5664425,
//             "pageURL": "https://pixabay.com/photos/deer-animal-nature-cervidae-5664425/",
//             "type": "photo",
//             "tags": "deer, animal, nature",
//             "previewURL": "https://cdn.pixabay.com/photo/2020/10/18/11/01/deer-5664425_150.jpg",
//             "previewWidth": 150,
//             "previewHeight": 100,
//             "webformatURL": "https://pixabay.com/get/53e6d3474e50a914f1dc846096293f76173fdae3504c704f752c7fd69645c251_640.jpg",
//             "webformatWidth": 640,
//             "webformatHeight": 427,
//             "largeImageURL": "https://pixabay.com/get/53e6d3474e50a914f6da8c7dda7936761d3ddee155526c48732f78d0954ccd5fb1_1280.jpg",
//             "imageWidth": 6297,
//             "imageHeight": 4200,
//             "imageSize": 7457483,
//             "views": 16694,
//             "downloads": 14196,
//             "favorites": 42,
//             "likes": 68,
//             "comments": 26,
//             "user_id": 7520060,
//             "user": "DerWeg",
//             "userImageURL": "https://cdn.pixabay.com/user/2017/12/28/13-40-02-308_250x250.png"
//         }
//     ]
// }
