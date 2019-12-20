//
//  JSONObject.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

let stringJSON = """
{
 "resultCount":3,
 "results": [
{"wrapperType":"track", "kind":"song", "artistId":1238013332, "collectionId":1238013326, "trackId":1238013707, "artistName":"Name It Now!", "collectionName":"Album Name", "trackName":"Song Name", "collectionCensoredName":"Album Name", "trackCensoredName":"Song Name", "artistViewUrl":"https://music.apple.com/us/artist/name-it-now/1238013332?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/song-name/1238013326?i=1238013707&uo=4", "trackViewUrl":"https://music.apple.com/us/album/song-name/1238013326?i=1238013707&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview117/v4/2c/b6/fd/2cb6fdbe-5452-0744-31f4-7942be65ffcf/mzaf_3947892404594376077.plus.aac.p.m4a", "artworkUrl30":"https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/e7/5d/34/e75d340a-7fde-085d-ad69-1463a1d4c295/source/30x30bb.jpg", "artworkUrl60":"https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/e7/5d/34/e75d340a-7fde-085d-ad69-1463a1d4c295/source/60x60bb.jpg", "artworkUrl100":"https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/e7/5d/34/e75d340a-7fde-085d-ad69-1463a1d4c295/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":0.99, "releaseDate":"2017-05-18T12:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"explicit", "discCount":1, "discNumber":1, "trackCount":13, "trackNumber":13, "trackTimeMillis":156035, "country":"USA", "currency":"USD", "primaryGenreName":"Alternative", "contentAdvisoryRating":"Explicit", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1450551538, "collectionId":1487079175, "trackId":1487079945, "artistName":"Camax", "collectionName":"What I've Done", "trackName":"Song Name", "collectionCensoredName":"What I've Done", "trackCensoredName":"Song Name", "artistViewUrl":"https://music.apple.com/us/artist/camax/1450551538?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/song-name/1487079175?i=1487079945&uo=4", "trackViewUrl":"https://music.apple.com/us/album/song-name/1487079175?i=1487079945&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview123/v4/f5/71/bb/f571bb1b-953c-6815-143f-4e1e57fa9ff0/mzaf_2060174869630788351.plus.aac.p.m4a", "artworkUrl30":"https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/6a/a2/51/6aa25132-b2e0-16d4-7399-5ced7b66860c/source/30x30bb.jpg", "artworkUrl60":"https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/6a/a2/51/6aa25132-b2e0-16d4-7399-5ced7b66860c/source/60x60bb.jpg", "artworkUrl100":"https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/6a/a2/51/6aa25132-b2e0-16d4-7399-5ced7b66860c/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":0.99, "releaseDate":"2019-11-07T08:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":12, "trackNumber":6, "trackTimeMillis":376320, "country":"USA", "currency":"USD", "primaryGenreName":"Electronic", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1454765939, "collectionId":1462685812, "trackId":1462685907, "artistName":"Elijah Fritz", "collectionName":"Elijah Fritz - Single", "trackName":"Song Name", "collectionCensoredName":"Elijah Fritz - Single", "trackCensoredName":"Song Name (Demo)", "artistViewUrl":"https://music.apple.com/us/artist/elijah-fritz/1454765939?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/song-name-demo/1462685812?i=1462685907&uo=4", "trackViewUrl":"https://music.apple.com/us/album/song-name-demo/1462685812?i=1462685907&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview113/v4/05/96/dd/0596dd4a-c8d7-99db-c3d3-f13bfe7a664f/mzaf_3023086533386208955.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/d9/ed/3f/d9ed3fde-7b68-53a6-9345-7ac38804acb1/source/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/d9/ed/3f/d9ed3fde-7b68-53a6-9345-7ac38804acb1/source/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/d9/ed/3f/d9ed3fde-7b68-53a6-9345-7ac38804acb1/source/100x100bb.jpg", "collectionPrice":2.97, "trackPrice":0.99, "releaseDate":"2019-04-29T12:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":3, "trackNumber":3, "trackTimeMillis":218182, "country":"USA", "currency":"USD", "primaryGenreName":"Ambient", "isStreamable":true}]
}
"""

struct JSONObject: Codable {
    var results: [Track]?
}

struct Track: Codable {
    var artistName: String?
    var trackName: String?
}

