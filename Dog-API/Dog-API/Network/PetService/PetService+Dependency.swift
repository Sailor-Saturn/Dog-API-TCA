import Dependencies

extension PetService: DependencyKey {
    @Dependency(\.networkService) private static var networkService
    public static let liveValue: PetService = .live(
        networkService: networkService
    )
}

extension DependencyValues {
    public var petService: PetService {
        get { self[PetService.self] }
        set { self[PetService.self] = newValue }
    }
}
