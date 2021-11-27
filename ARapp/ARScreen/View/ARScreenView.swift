
import UIKit
import SceneKit
import ARKit

protocol IARScreenView {
    func createVirtualObject(hitResult: ARHitTestResult, sceneView: ARSCNView, objectName: String)
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor, planes: inout [ARPlane])
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor, planes: [ARPlane])
}

class ARScreenView: UIViewController {

    //MARK: - Variables

    private var planes = [ARPlane]()
    var objectName: String
    var output: IARScreenView
    
    private var sceneView = ARSCNView()
    private var session: ARSession {
        return sceneView.session
    }
    
    //MARK: - Init
    
    init(output: IARScreenView, objectName: String) {
        self.output = output
        self.objectName = objectName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}

//MARK: - Private UI func

extension ARScreenView {
        
    private func setupViews() {
        let scene = SCNScene()
        sceneView.delegate = self
        sceneView.showsStatistics = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.scene = scene
        view.addSubview(sceneView)
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            sceneView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
    }
}

//MARK: - Private logic func

extension ARScreenView {
    
    private func setupGestures() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeVirtualObject))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createVirtualObject(hitResult: ARHitTestResult) {
        output.createVirtualObject(hitResult: hitResult, sceneView: sceneView, objectName: objectName)
    }
    
    @objc func placeVirtualObject(tapGesture: UITapGestureRecognizer) {
        let sceneView = tapGesture.view as! ARSCNView
        let location = tapGesture.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        guard let hitResult = hitTestResult.first else { return }
        createVirtualObject(hitResult: hitResult)
    }
}

//MARK: - ARSCNViewDelegate

extension ARScreenView: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        output.renderer(renderer, didAdd: node, for: anchor, planes: &planes)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        output.renderer(renderer, didUpdate: node, for: anchor, planes: planes)
    }
}
