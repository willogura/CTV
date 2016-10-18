//
//  Video.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

import MediaPlayer

public func getSampleVideos() -> [Video] {
    
    var samples = [Video]()
    
    var video = Video(title: "Legion Baseball Rosetown v. Tri-City Maroon 16-07-13 Gm1", thumbnail: nil, fileName: 1220 , sourceUrl: "http://trms.ctv15.org/TRMSVOD/10581-Baseball-TCM-v-Rosetown-16-07-13-gm1-trms-Medium-v1.mp4", comments: "A sample video")
    
    video!.generateThumbnail()
    
    samples.append(video!)
    
    video = Video(title: "Roseville High School Graduation Ceremony (RAHS) 2015-06-05 (CH14)", thumbnail: nil, fileName: 1220, sourceUrl: "http://trms.ctv15.org/TRMSVOD/10439-RAHSGrad16-06-03-Medium-v1.mp4", comments: "A sample video")
    
    video!.generateThumbnail()
    
    samples.append(video!)
    
    video = Video(title: "Softball Roseville v. Mounds View RAHS MVHS 16-04-13", thumbnail: nil, fileName: 1220, sourceUrl: "http://trms.ctv15.org/TRMSVOD/10178-RAHS-vs-MVHS-Softball-16-04-13-trms-Medium-v1.mp4", comments: "A sample video")
    
    video!.generateThumbnail()
    
    samples.append(video!)

    return samples
    
}

open class Video: NSObject, NSCoding {
    
    var title: String?
    
    var fileName: Int?
    
    var sourceUrl: String?
    
    var thumbnail: UIImage?
    
    var comments: String?

    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("videos")
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let titleKey = "title"
        
        static let thumbnailKey = "thumbnail"
        
        static let fileNameKey = "fileName"
        
        static let sourceUrlKey = "sourceUrl"
        
        static let commentsKey = "comments"
        
    }
    
    // MARK: Initialization
    
    init?(title: String, thumbnail: UIImage?,fileName: Int?, sourceUrl: String?, comments: String) {
        
        // Initialize stored properties.
        
        self.title = title
        
        self.thumbnail = thumbnail
      
        self.fileName = fileName
        
        self.sourceUrl = sourceUrl
        
        self.comments = comments
        
       /* Possible Image setter
        let url = NSURL(string: image.url)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imageView.image = UIImage(data: data!)
       */
        
        super.init()
        
        // Initialization should fail if there is no title.
        
        if title.isEmpty {
            
            return nil
            
        }
        
    }
    
    open func generateThumbnail()  {
        
        
        
      
        
        var tempThumb: UIImage
        

        
        do {
            
            let asset = AVURLAsset(url: URL(string: self.sourceUrl!)!, options: nil)
            
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            imgGenerator.appliesPreferredTrackTransform = true
            
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(5, 1), actualTime: nil)
    
            tempThumb = UIImage(cgImage: cgImage)
            
            self.thumbnail = tempThumb
            
            // lay out this image view, or if it already exists, set its image property to uiImage
            
        } catch let error as NSError {
            
            print("Error generating thumbnail: \(error)")
            
            
            self.thumbnail = nil
            
        }
        
       
        
        
    }
    
    // MARK: NSCoding
    
    open func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: PropertyKey.titleKey)
        
        aCoder.encode(thumbnail, forKey: PropertyKey.thumbnailKey)
        
        aCoder.encode(fileName, forKey: PropertyKey.fileNameKey)
        
        aCoder.encode(sourceUrl, forKey: PropertyKey.sourceUrlKey)
        
        aCoder.encode(comments, forKey: PropertyKey.commentsKey)
        
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as! String
        
        let fileName = aDecoder.decodeObject(forKey: PropertyKey.fileNameKey) as? Int
        
        let sourceUrl = aDecoder.decodeObject(forKey: PropertyKey.sourceUrlKey) as! String
        
        let comments = aDecoder.decodeObject(forKey: PropertyKey.commentsKey) as! String
        
        // Because photo is an optional property of Video, use conditional cast.
        
        let thumbnail = aDecoder.decodeObject(forKey: PropertyKey.thumbnailKey) as? UIImage
        
        // Must call designated initializer.
        
        self.init(title: title, thumbnail: thumbnail, fileName: fileName, sourceUrl: sourceUrl, comments: comments )
        
    }

}
