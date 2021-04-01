//
//  APICaller.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init(){}
    
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case  failedToGetData
    }
    
    //MARK: - Playlist
    
    public func getPlaylistDetails(for playlist: Playlist, completion:@escaping (Result<PlaylistDetailsResponse, Error>) -> Void){
        createRequest(
            with: URL(string: Constants.baseURL + "/playlists/" + playlist.id),
            type: .GET) { (request) in
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                     completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Album
    
    public func getAlbumDetails(for album: Album, completion:@escaping (Result<AlbumDetailsResponse, Error>) -> Void){
        createRequest(
            with: URL(string: Constants.baseURL + "/albums/" + album.id),
            type: .GET) { (request) in
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    
    
    
    
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseURL + "/me"), type: .GET) { (baseRequest) in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseURL + "/browse/new-releases?limit=50"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsReponse, Error>) -> Void)){
        createRequest(with: URL(string: Constants.baseURL + "/browse/featured-playlists?limit=50"), type: .GET){ (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(FeaturedPlaylistsReponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genre: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>) -> Void)) {
        let seeds = genre.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try  JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        
        createRequest(with: URL(string: Constants.baseURL + "/recommendations/available-genre-seeds"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { (token) in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 60
            completion(request)
        }
    }
}
