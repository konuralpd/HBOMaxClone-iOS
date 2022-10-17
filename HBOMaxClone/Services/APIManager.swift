//
//  APIManager.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import Foundation



struct Constants {
    static let API_KEY = "ffd53786c8d35556c4cf65072876da13"
    static let baseURL = "https://api.themoviedb.org"
    static let youtube_APIKEY = "AIzaSyA5JzrMcW84gtCwA_TNXNyfknGMKL2nRFk"
    static let youtube_BaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case getDataError
}

class APIManager {
    static let shared = APIManager()
    
    
    func getWatchingList(completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/week?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
                }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results!))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    

    
    
    
    func getTrendingTVSeries(completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)&language=tr-TR&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try? JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success((results?.results)!))
                
            } catch {
                completion(.failure(APIError.getDataError))
            }
        }
        task.resume()
    }

    func getDiscoverMovies(completion: @escaping(Result<[DiscoverResults], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=tr-TR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try? JSONDecoder().decode(DiscoverResponse.self, from: data)
                completion(.success(((results?.results)!)))
            } catch {
                completion(.failure(APIError.getDataError))
            }
        }
        task.resume()
    }
    
    func searchContent(with searchText: String, completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        
        guard let searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(searchText)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results!))
            } catch {
                completion(.failure(APIError.getDataError))
            }
        }
        task.resume()
    }
    
    func getContentVideo(with text: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtube_BaseURL)q=\(searchText)&key=\(Constants.youtube_APIKEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
        
    }
}

