import Foundation
import Combine

private enum Constants: Int {
    case limit = 20
}

protocol AssetsViewModelProtocol: AnyObject {
    var assets: [Asset] { get }
    var errorMessage: String? { get }
    
    func fetchAssets()
    func reloadAssets()
    func loadMoreAssets()
}

class AssetsViewModel: AssetsViewModelProtocol {
    @Published var assets: [Asset] = []
    @Published var errorMessage: String? = nil
    
    private let assetService: AssetServiceProtocol
    private var isLoading: Bool = false
    private var canLoadMore: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var currentOffset: Int = 0
    
    init(assetService: AssetServiceProtocol) {
        self.assetService = assetService
    }
    
    func fetchAssets() {
        guard !isLoading else { return }
        currentOffset = 0
        canLoadMore = true
        loadAssets(offset: currentOffset)
    }
    func reloadAssets() {
        guard !isLoading else { return }
        
        currentOffset = 0
        canLoadMore = true
        loadAssets(offset: currentOffset)
    }
    
    func loadMoreAssets() {
        guard !isLoading, canLoadMore else { return }
        loadAssets(offset: currentOffset)
    }
    
    private func loadAssets(offset: Int) {
        isLoading = true
        errorMessage = nil
        
        assetService.fetchAssets(limit: Constants.limit.rawValue, offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] newAssets in
                guard let self = self else { return }
                if offset == 0 {
                    self.assets = newAssets
                } else {
                    self.assets.append(contentsOf: newAssets)
                }
                self.currentOffset += newAssets.count
                self.canLoadMore = newAssets.count == Constants.limit.rawValue
            }
            .store(in: &cancellables)
    }
}
