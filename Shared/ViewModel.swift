//
//  ViewModel.swift
//  InsertionSortGifs
//
//  Created by Borna Libertines on 16/02/22.
//
/*
 
 */
import Foundation
/*
 func reverse<T>(with array: [T]) -> [T] {
    var array1 = array
    var start = 0
    var end = array1.count - 1
    while start < end {
       let temp = array1[start]
       array1[start] = array1[end]
       array1[end] = temp
       start = start + 1
       end = end - 1
    }
    return array1
 }
 */
class ViewModel: ObservableObject {
   
   @Published var gifs = [GifCollectionViewCellViewModel]()
   // MARK:  Initializer Dependency injestion
   let appiCall: ApiLoader?
   
   init(appiCall: ApiLoader = ApiLoader()){
      self.appiCall = appiCall
   }
   
   func reverse<T>(with array: [T]) -> [T] {
      var array1 = array
      var start = 0
      var end = array1.count - 1
      while end > start {
         let temp = array1[start]
         array1[start] = array1[end]
         array1[end] = temp
         start = start + 1
         end = end - 1
      }
      return array1
   }
   
   public func reverseArray(){
      self.gifs = reverse(with: gifs)
   }
   
   
   @MainActor func loadGift() async {
      Task(priority: .userInitiated, operation: {
         let fp: APIListResponse? = try? await appiCall?.fetchAPI(urlParams: [Constants.rating: Constants.rating, Constants.limit: Constants.limitNum], gifacces: Constants.trending)
         let d = fp?.data.map({ return GifCollectionViewCellViewModel(id: $0.id!, title: $0.title!, rating: $0.rating, Image: $0.images?.fixed_height?.url, url: $0.url)
         })
         self.gifs = d!
      })
   }
   
   
   deinit{
      debugPrint("ViewModel deinit")
   }
}


