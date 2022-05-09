//
//  ARGameViewModel.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/18.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit
import Combine


class GameController:ObservableObject{
    //@StateObject private var dataController = DataController()
    //@Environment(\.managedObjectContext) var moc
    //@FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    
    public var arView :ARView = ARView(frame: .zero)
    @Published public var score: Int = 0
    /*{
        didSet {
            objectWillChange.send()
        }
    }*/
    @Published public var isGameOver = false
    @Published public var timerStart = false
    @Published public var timerCount : Int = 10
    @Published public var gameDifficulty = GameDifficulty.easy
    
    private var cardNumber = 4
    private var cardPosition = 2
    private var anchor: AnchorEntity!
    private var cards: [Entity] = []
    private var cancellabel: AnyCancellable? = nil
    private var objects: [ModelEntity] = []
    private var flipped: [Entity] = []
    private var gameResult = false
    
    
    
    func coachingOverlay(){
        
        //Configure coachingOverlay
        let coachingOverlay = ARCoachingOverlayView(frame:arView.frame)
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        //Add overlay to arView hierarchy
        arView.addSubview(coachingOverlay)
        
        //Set layout constraints
        coachingOverlay.topAnchor.constraint(equalTo: arView.topAnchor).isActive = true
        coachingOverlay.leadingAnchor.constraint(equalTo: arView.leadingAnchor).isActive = true
        coachingOverlay.trailingAnchor.constraint(equalTo: arView.trailingAnchor).isActive = true
        coachingOverlay.bottomAnchor.constraint(equalTo: arView.bottomAnchor).isActive = true
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = arView.session
    }
    
    func addTappedGesture(){
        //Enable tapped gesture
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        arView.addGestureRecognizer(gestureRecognizer)
    }
    
    func arViewConfigure(){
        
        let config = ARWorldTrackingConfiguration()
        //Auto Focus
        config.isAutoFocusEnabled = true
        //Plane detecte
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        arView.session.run(config)
        
        //Add horizontal plane for mini 50cm * 50cm
        self.anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.5, 0.5])
        arView.scene.addAnchor(anchor)
    }
    
     
    func configureGameDifficulty(level: GameDifficulty){
        switch level{
        case .easy:
            cardNumber = 4
            cardPosition = 2
            timerCount = 10
        case .medium:
            cardNumber = 16
            cardPosition = 4
            timerCount = 30
        case .hard:
            cardNumber = 16
            cardPosition = 4
            timerCount = 60
        }
    }
    
    
    
    func setUpGame(){
        
        coachingOverlay()
        addTappedGesture()
        arViewConfigure()
        
        
        //Initialize
        cards = []
        objects = []
        cancellabel = nil
        flipped = []
        gameResult = false
        timerStart = false
        timerCount = 10
        score = 0
        self.configureGameDifficulty(level: gameDifficulty)
        
        for _ in 1...cardNumber {  //创建卡片
            let box = MeshResource.generateBox(width: 0.05, height: 0.002, depth: 0.05)
            let metalMaterial = SimpleMaterial(color:.orange, isMetallic: true) //卡片颜色
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true) //使卡片可触摸
            cards.append(model)
                }
            
            
        
        for (index, card) in cards.enumerated(){
            let x = Float(index % cardPosition )
            let z = Float(index / cardPosition )
            
            card.position = [x*0.1, 0, z*0.1]
            anchor.addChild(card)
        }
        

        switch timerCount{
        case 10:
            setupEasyScene(anchor)
        case 30:
            setupMediumScene(anchor)
        case 60:
            setupHardScene(anchor)
        default:
            setupEasyScene(anchor)
        }
        

    }
    

    func updateScore(){

        print("update score")
        score += 1
        
        print(score)
        
        if ((score >= 4) && (cardNumber == 4)) || ((score >= 16) && (cardNumber == 16)){
            //self.saveScore()
            gameResult = true
            gameOver(self.anchor, result:gameResult)
            let waitSeconds = 10.0
            DispatchQueue.main.asyncAfter(deadline: .now() + waitSeconds, execute: {
                self.removeAll()
                self.isGameOver = true
                print("game over")
            })
        }
        
    }
    
    func flipCard(card: Entity){
        
        //Untapped
        if card.transform.rotation.angle == .pi{
            var flipDownTransform = card.transform
            flipDownTransform.rotation = simd_quatf(angle: 0,axis: [1,0,0])
            card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
        }
        //Already tapped
        else{
            var flipUpTransform = card.transform
            flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
            card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            
        }
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer){
        //Get hit position
        let tapLocation = gesture.location(in: arView)
        print("Guesture Point Hit: \(tapLocation)")
        countDown()
        if let hitResult = arView.entity(at: tapLocation){
            print("hit \(hitResult.id)+\(hitResult.name)")
            
            if hitResult.name.contains("card"){
                flipped.append(hitResult)
            }
        }
        
        if let card = arView.entity(at: tapLocation){
            if card.transform.rotation.angle == .pi{
                self.flipCard(card: card)
            }
            
            if self.flipped.count >= 2{
                
                let waitSeconds = 1.0
                
                //After two card were flipped, the player should wait for matching
                DispatchQueue.main.asyncAfter(deadline: .now() + waitSeconds){
                    print("matching test...")
                    
                    let dupNames: [String] = self.findMatches()
                    for card in self.flipped{
                        self.flipCard(card: card)
                        if dupNames.contains(card.name){
                            print("Duplicate cards")
                            self.updateScore()
                            self.anchor.removeChild(card)
                        }
                    }
                    
                    self.flipped = []
                }
            }
        }
        /*
        if let card = arView.entity(at: tapLocation){  //点击卡片翻转
            if card.transform.rotation.angle == .pi{  //正面朝上
                var flipDownTransform = card.transform
                flipDownTransform.rotation = simd_quatf(angle: 0,axis: [1,0,0])
                card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            }
            else{  //背面朝上
                var flipUpTransform = card.transform
                flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            }
        }
        
        */
    }
    
    func setupEasyScene(_ anchor: AnchorEntity) {
        
        //Configure occlusionBox
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        
        //var cancellabel: AnyCancellable? = nil
        self.cancellabel = ModelEntity.loadModelAsync(named: "model_1")
            .append(ModelEntity.loadModelAsync(named:"model_2"))

        //加载模型
            .collect()
            .sink(receiveCompletion: {error in
                  print("Error: \(error)")
                self.cancellabel?.cancel()
            }, receiveValue: { [self] entities in
                //var objects : [ModelEntity] = []
                let names: [String] = ["1", "2"]
                for (i, entity) in entities.enumerated(){
                    //Initialize entities
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    entity.name = names[i]
                    for _ in 1...2{
                        objects.append(entity.clone(recursive: true))
                        //clone a same card to create a pair
                    }
                }
                
                objects.shuffle() //Random card position
                
                for(index, object) in objects.enumerated(){
                    self.cards[index].addChild(object)
                    self.cards[index].name = "card \(object.name)"
                    self.cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                }
                
                cancellabel?.cancel()
                
            })
    }
    
    func setupMediumScene(_ anchor: AnchorEntity) {
        
        //Configure occlusionBox
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        
        //var cancellabel: AnyCancellable? = nil
        self.cancellabel = ModelEntity.loadModelAsync(named: "model_1")
            .append(ModelEntity.loadModelAsync(named:"model_2"))
            .append(ModelEntity.loadModelAsync(named:"model_3"))
            .append(ModelEntity.loadModelAsync(named:"model_4"))
        //Load models
            .collect()
            .sink(receiveCompletion: {error in
                  print("Error: \(error)")
                self.cancellabel?.cancel()
            }, receiveValue: { [self] entities in
                //var objects : [ModelEntity] = []
                let names: [String] = ["1", "2", "3", "4"]
                for (i, entity) in entities.enumerated(){ //Initialize entities
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    entity.name = names[i]
                    for _ in 1...4{
                        objects.append(entity.clone(recursive: true))
                        //clone a same card to create a pair
                    }
                }
                
                objects.shuffle() //Random card position
                
                for(index, object) in objects.enumerated(){
                    self.cards[index].addChild(object)
                    self.cards[index].name = "card \(object.name)"
                    self.cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                }
                
                cancellabel?.cancel()
                
            })
    }
    
    func setupHardScene(_ anchor: AnchorEntity) {
        
        //Configure occlusionBox
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        
        //var cancellabel: AnyCancellable? = nil
        self.cancellabel = ModelEntity.loadModelAsync(named: "model_1")
            .append(ModelEntity.loadModelAsync(named:"model_2"))
            .append(ModelEntity.loadModelAsync(named:"model_3"))
            .append(ModelEntity.loadModelAsync(named:"model_4"))
            .append(ModelEntity.loadModelAsync(named:"model_5"))
            .append(ModelEntity.loadModelAsync(named:"model_6"))
            .append(ModelEntity.loadModelAsync(named:"model_7"))
            .append(ModelEntity.loadModelAsync(named:"model_8"))
        //Load models
            .collect()
            .sink(receiveCompletion: {error in
                  print("Error: \(error)")
                self.cancellabel?.cancel()
            }, receiveValue: { [self] entities in
                //var objects : [ModelEntity] = []
                let names: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
                for (i, entity) in entities.enumerated(){ //Initialize entities
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    entity.name = names[i]
                    for _ in 1...2{
                        objects.append(entity.clone(recursive: true))
                        //clone a same card to create a pair
                    }
                }
                
                objects.shuffle() //Random card position
                
                for(index, object) in objects.enumerated(){
                    self.cards[index].addChild(object)
                    self.cards[index].name = "card \(object.name)"
                    self.cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                }
                
                cancellabel?.cancel()
                
            })
    }
    /*
    func saveScore(){
        do{
            let currentScore = GameScore(context: moc)
            currentScore.historyScore = Int16(self.score)
            currentScore.id = UUID()
            try moc.save()
            print("successfully save score")
        } catch{
            print (error.localizedDescription)
        }
    }
    */
    func findMatches() -> [String]{
        //Identify whether the models are the same
        
        let dups = Dictionary(grouping: self.flipped, by: {$0.name}).filter { $1.count > 1 }.keys
        
        print(dups)
        
        return Array(dups.map{$0})
    }
    
    @objc func removeAll() {

        for anchor in arView.scene.anchors where anchor is AnchorEntity {
            (anchor as? AnchorEntity)?.children.removeAll()
        }
        arView.session.pause()
        arView.removeFromSuperview()
        //let config = ARWorldTrackingConfiguration()
        //arView.session.run(config, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func countDown(){
        
        if !timerStart{
            timerStart = true
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ timer in
                self.timerCount -= 1
                if self.timerCount <= 0{
                    timer.invalidate()
                    //self.saveScore()
                    if self.gameResult == false{
                    self.gameOver(self.anchor, result:self.gameResult)
                    let waitSeconds = 10.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + waitSeconds, execute: {
                        self.removeAll()
                        self.isGameOver = true
                        print("game over")
                    })
                    }
                }
            }
        }
        
    }
    

    func gameOver(_ anchor: AnchorEntity, result: Bool){
        
        if !result{
            let entity = try! GameCelebrate.loadLoseScene()
            //entity.setScale(SIMD3<Float>(0.08, 0.08, 0.08), relativeTo: anchor)
            self.anchor.addChild(entity)
            entity.notifications.lose.post()
        }
        else
        {
            let entity = try! GameCelebrate.loadCelebrateScene()
            //entity.setScale(SIMD3<Float>(0.08, 0.08, 0.08), relativeTo: anchor)
            self.anchor.addChild(entity)
            entity.notifications.celebrate.post()
        }
        
        /*
        let gameScore = GameScore(context: moc)
        gameScore.id = UUID()
        gameScore.score = Int16(self.score)
        print("save:\(gameScore.score)")
        try? moc.save()
         */
    }
    

}

struct ARGameViewContainer: UIViewRepresentable {
    
    public let arView: ARView
    @EnvironmentObject var gameController :GameController
    
    init(_ view: ARView) {
        arView = view
    }
    
    func makeUIView(context: Context) -> ARView {
        gameController.setUpGame()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        //gameController.setUpGame()
        //uiView.removeFromSuperview()

    }
}
