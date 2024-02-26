//
//  ViewController.swift
//  MovieApp
//
//  Created by 정성희 on 2024/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var moviemodel : MovieModel?
    
    var term : String?
    
    var netWorkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dataSource : 데이터 연결
        // delegate : 검색을 하려고 뭔갈 누를때
        movieTableView.dataSource = self
        movieTableView.delegate = self
        searchBar.delegate = self
        
        requestMovieAPI()
    }
    
    //네트워크 리펙토링 후
    func requestMovieAPI() {
        let term = URLQueryItem(name: "term", value: term)
        let media = URLQueryItem(name: "media", value: "movie")
        let querys = [term, media]
        
        netWorkManager.request(type: .searchMovie(querys: querys)) { data, reponse, error in
            if let hasData = data{
                do{
                    self.moviemodel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
    //네트워크 리펙토리 전
    /*
    func requestMovieAPI() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        
        // components에 쿼리 직접 써넣으면 실수 할 수 있으므로 따로 key value 를 쓰고 합치는 작업을 진행함
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        
        components?.queryItems = [term,media]
        
        guard let url = components?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // data : body
        // reponse : status code
        let task = session.dataTask(with: request) { data, reponse, error in
            print ((reponse as! HTTPURLResponse).statusCode)
            
            if let hasData = data{
                //백엔드에서 오는 데이터를 사람이 볼 수있는 데이터로 바꾸기 위해 decoding 진행
                //from : -> 어떤걸 디코딩 하겠냐
                do{ // do: try 문장을 실행해서 문제가 발생한다면, catch : 해당 에러를 처리하겠다
                    self.moviemodel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    print(self.moviemodel ?? "no data")
                    
                    //데이터를 네트워크를 통해 불러왔으니 다시 리로드.
                    //리로드하면 extension 에 있는 것들이 다시 실행될걸 아마?
                    //ui 바꾸는 것이므로 메인스레드 에서 해야함
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
     */
    
    //이미지 로드 리펙토리 후
    func loadImage(urlString: String, completion: @escaping (UIImage?)->Void) {
        netWorkManager.request(type: .justURL(urlString: urlString)) { data, reponse, error in
            if let hasData = data {
                completion(UIImage(data: hasData))
                return
            }
            completion(nil)
        }
    }
    //이미지 로드 리펙토리 전
    /*
    func loadImage(urlString: String, completion: @escaping (UIImage?)->Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let hasURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: hasURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            print ((response as! HTTPURLResponse).statusCode)
            
            if let hasData = data {
                //closure 내부에선 return 을 할 수 없기 때문에, 지금 함수의 인자로 클로저를 넣어줘야함
                //data, response, error 등의 데이터는 현재 클로저 내부에서만 라이프 사이클이 돌아감. 그래서 원래는 함수 인자로 내보내주는 것이 안되는데 @escaping 키워드를 사용하면 밖에서도 사용할 수 있게 해줌
                completion(UIImage(data: hasData))
                
                //여기서 return 을 하는 이유는 윗 줄에서 completion 을 하더라도 현재 함수가 끝나는 것이 아니고 이후로 계속 실행하기 때문에 return 을 해줘야 한다
                return
            }
        }.resume() //마지막에 항상 실행, 그리고 끝내기까지 해주는것 잊지 말기
        session.finishTasksAndInvalidate()
        
        // 만약 if 문에 안걸려서 completion(UIImage(data: hasData)) 를 실행하지 못한다면 마지막에 nil이라도 completion 을 해줘야함. 하지 않으면 계속 메모리를 잡아먹고 있을 것임
        completion(nil)
    }*/
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviemodel?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell
        
        cell.titleLabel.text = self.moviemodel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.moviemodel?.results[indexPath.row].shortDescription
        
        let currency = self.moviemodel?.results[indexPath.row].currency ?? ""
        let price = self.moviemodel?.results[indexPath.row].trackPrice?.description ?? ""
        
        cell.priceLabel.text = currency + price
        
        //이부분 closure 자세하게 다시 공부할것
        if let hasURL = self.moviemodel?.results[indexPath.row].image {
            loadImage(urlString: hasURL, completion: { image in
                DispatchQueue.main.async{
                    cell.movieImage.image = image
                }
            })
        }
        
        //String 을 date 값으로 포맷 해주는 과정
        if let dateString = self.moviemodel?.results[indexPath.row].releaseDate {
            let formater = ISO8601DateFormatter()
            //isoDate 에는 date 타입의 값이 들어 있을 것
            
            if let isoDate = formater.date(from: dateString){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.M.d"
                
                //정했던 포멧 형태로 date -> string 값으로 바꿈
                let hasDate = dateFormatter.string(from: isoDate)
                
                cell.dateLabel.text = hasDate
            }
        }
        
        return cell
    }
    
    //해당 부분은 iOS 구버전에서 반드시 해줘야 하는 작업이었지만 현재 최신 버전은 알아서 해줌. 따라서 이걸 아예 생략하는건 그렇게 좋지 않음
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // 아이템 하나 클릭시 실행 됨
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController")as! DetailViewController
            detailVC.movieResult = moviemodel?.results[indexPath.row]
        
        //한번 선택했던 것 클릭표시 상태 없애주기
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(detailVC, animated: true) {
            //다만 이 코드를 실행하면 디테일뷰 켜지는 순간 임시 데이터가 잠깐 보이게 됨. 그래서 아래에서 실행하지 않음
            /*
            detailVC.movieResult = self.moviemodel?.results[indexPath.row]
             */
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        term = searchBar.text
        requestMovieAPI()
    }
}
