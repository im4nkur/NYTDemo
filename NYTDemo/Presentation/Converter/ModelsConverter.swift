import UIKit

/// Converter Class for the models used in this project.
class ModelsConverter {
    
    /// Convert domain Article model to presentation Article model.
    ///
    /// - Parameter article: domain Article model
    /// - Returns: presentation Article model.
    internal func convertArticleDomainToPresentationModel(article: Article) -> ArticleModel {
        let media = article.media.map({convertMediaDomainToPresentationModel(media: $0)}).first
        
        return ArticleModel(url: article.url, section: article.section, byline: article.byline, type: article.type, title: article.title, abstract: article.abstract, publishedDate: article.publishedDate, source: article.source, id: article.id, views: article.views, media: media)
    }
    
    /// Convert network Article model to domain Article model.
    ///
    /// - Parameter networkModel: network model
    /// - Returns: domain model.
     internal func convertArticleNetworkToDomainModel(networkModel: NetworkArticle) -> Article {
        let media = networkModel.media.map({ convertMediaNetworkToDomainModel(media: $0) })
        
        return Article(url: networkModel.url, section: networkModel.section, byline: networkModel.byline, type: networkModel.type, title: networkModel.title, abstract: networkModel.abstract, publishedDate: networkModel.publishedDate, source: networkModel.source, id: networkModel.id, views: networkModel.views, media: media)
    }
    
    /// Convert domain Media model to presentation Media model.
    ///
    /// - Parameter user: domain Media model
    /// - Returns: presentation Media model.
    private func convertMediaDomainToPresentationModel(media: Media) -> MediaModel {
        let thumb = media.mediaData.filter({$0.format == "Standard Thumbnail"}).first?.url ?? ""
        let large = media.mediaData.filter({$0.format == "Large"}).first?.url ?? ""
        return MediaModel(type: media.type, caption: media.caption, copyright: media.caption, thumbnail: thumb, largeImage: large)
    }
    
    /// Convert network Media model to domain Media model.
    ///
    /// - Parameter networkModel: network model
    /// - Returns: domain model.
    private func convertMediaNetworkToDomainModel(media: NetworkMedia) -> Media {
        let mediaData = media.mediaData.map({convertMediaDataNetworkToDomainModel(mediaData: $0)})
        return Media(type: media.type, subtype: media.subtype, caption: media.caption, copyright: media.caption, mediaData: mediaData)
    }
    
    /// Convert network MediaData model to domain MediaData model.
    ///
    /// - Parameter networkModel: network model
    /// - Returns: domain model.
    private func convertMediaDataNetworkToDomainModel(mediaData: NetworkMediaData) -> MediaData {
        return MediaData(url: mediaData.url, format: mediaData.format, height: mediaData.height, width: mediaData.width)
    }
}
