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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    public var arView :ARView = ARView(frame: .zero)
    public var score: Int = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    @Published public var isGameOver = false
    @Published public var timerStart = false
    @Published public var timerCount : Int = 10
    
    private var anchor: AnchorEntity!
    private var cards: [Entity] = []
    private var cancellabel: AnyCancellable? = nil
    private var objects: [ModelEntity] = []
    private var flipped: [Entity] = []
    private var gameResult = false
    
    init(){
        
        //Configure coachingOverlay 引导使用者进行操作，建立Ar环境
        let coachingOverlay = ARCoachingOverlayView(frame:arView.frame)
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        // add overlay to arView hierarchy
        arView.addSubview(coachingOverlay)
        
        //set layout constraints
        
        coachingOverlay.topAnchor.constraint(equalTo: arView.topAnchor).isActive = true
        coachingOverlay.leadingAnchor.constraint(equalTo: arView.leadingAnchor).isActive = true
        coachingOverlay.trailingAnchor.constraint(equalTo: arView.trailingAnchor).isActive = true
        coachingOverlay.bottomAnchor.constraint(equalTo: arView.bottomAnchor).isActive = true
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = arView.session
        
        // MARK: Add gestureRecognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        arView.addGestureRecognizer(gestureRecognizer)
        
        // MARK: Configure arView
        let config = ARWorldTrackingConfiguration()
        // Auto Focus
        config.isAutoFocusEnabled = true
        
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        arView.session.run(config)
        
        // anchor for a horizontal plane for minimum 40cm * 40cm
        self.anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.5, 0.5])
        arView.scene.addAnchor(anchor)
        
        //var cards: [Entity]=[]
        for _ in 1...4 {  //创建卡片
            let box = MeshResource.generateBox(width: 0.05, height: 0.002, depth: 0.05)
            let metalMaterial = SimpleMaterial(color:.orange, isMetallic: true) //卡片颜色
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true) //使卡片可触摸
            cards.append(model)
                }
            
            
        
        for (index, card) in cards.enumerated(){
            let x = Float(index % 2 )
            let z = Float(index / 2 )
            
            card.position = [x*0.1, 0, z*0.1]
            anchor.addChild(card)
        }
        setupScene(anchor)
    }
    

    func updateScore(){
    
        print("update score")
        score += 1
        
        print(score)
        
        if (score >= 4){
            
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
        
        //正面朝上时
        if card.transform.rotation.angle == .pi{
            var flipDownTransform = card.transform
            flipDownTransform.rotation = simd_quatf(angle: 0,axis: [1,0,0])
            card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
        }
        else{ //背面朝上
            var flipUpTransform = card.transform
            flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
            card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            
        }
    }
    @objc func tapped(gesture: UITapGestureRecognizer){
        // Get Hit Position
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
                
                //翻开两张卡片之后设置延迟
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
    
    func setupScene(_ anchor: AnchorEntity) {
        //隐藏卡片上的模型
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        
        //var cancellabel: AnyCancellable? = nil
        self.cancellabel = ModelEntity.loadModelAsync(named: "model_1")
            .append(ModelEntity.loadModelAsync(named:"model_2"))
            //.append(ModelEntity.loadModelAsync(named:"model_3"))
            //.append(ModelEntity.loadModelAsync(named:"model_4"))
            //.append(ModelEntity.loadModelAsync(named:"model_5"))
            //.append(ModelEntity.loadModelAsync(named:"model_6"))
            //.append(ModelEntity.loadModelAsync(named:"model_7"))
            //.append(ModelEntity.loadModelAsync(named:"model_8"))
        //加载模型
            .collect()
            .sink(receiveCompletion: {error in
                  print("Error: \(error)")
                self.cancellabel?.cancel()
            }, receiveValue: { [self] entities in
                //var objects : [ModelEntity] = []
                let names: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
                for (i, entity) in entities.enumerated(){ //创建卡片序列
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    entity.name = names[i]
                    for _ in 1...2{
                        objects.append(entity.clone(recursive: true))  //复制一个相同的卡片，作为匹配项
                    }
                }
                
                objects.shuffle() //使卡片内容随机排列
                
                for(index, object) in objects.enumerated(){
                    self.cards[index].addChild(object)
                    self.cards[index].name = "card \(object.name)"
                    self.cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                }
                
                cancellabel?.cancel()
                
            })
        
        
    }
    
    func findMatches() -> [String]{ //判断是否模型是否一致
        
        let dups = Dictionary(grouping: self.flipped, by: {$0.name}).filter { $1.count > 1 }.keys
        
        print(dups)
        
        return Array(dups.map{$0})
    }
    
    func removeAll() {
        for anchor in arView.scene.anchors where anchor is AnchorEntity {
            (anchor as? AnchorEntity)?.children.removeAll()
        }
    }
    
    func countDown(){
        
        if !timerStart{
            timerStart = true
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ timer in
                self.timerCount -= 1
                if self.timerCount <= 0{
                    timer.invalidate()
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
        
        let gameScore = GameScore(context: moc)
        gameScore.id = UUID()
        gameScore.score = Int16(self.score)
        print("save:\(gameScore.score)")
        try? moc.save()
    }
}

struct ARGameViewContainer: UIViewRepresentable {
    
    public let arView: ARView
    
    init(_ view: ARView) {
        arView = view
    }
    
    func makeUIView(context: Context) -> ARView {
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
