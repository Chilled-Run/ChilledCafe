//
//  ARViewContainer.swift
//  ARExperience
//
//  Created by Kyubo Shim on 2022/11/09.
//

import Foundation
import ARKit
import SwiftUI

struct ARViewContainer: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ARView
    
    func makeUIViewController(context: Context) -> ARView {
        return ARView()
    }
    
    func updateUIViewController(_ uiViewController: ARView, context: Context) {
        
    }
}


class ARView: UIViewController, ARSCNViewDelegate {
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
            
        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            
            configuration.trackingImages = imagesToTrack
            
            // this tells ARKit how many images it is supposed to track simultaneously, ARKit can do upto 100
            configuration.maximumNumberOfTrackedImages = 1
        }

        // Run the view's session
        arView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        arView.session.pause()
    }
    
    
    // MARK: - ARSCNViewDelegate
    

     //Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        // Cast the found anchor as image anchor
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
        
        // get the name of the image from the anchor
        guard let imageName = imageAnchor.name else { return nil }
        
        // Check if the name of the detected image is the one you want
        if imageName == "fish" {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            
            let planeNode = SCNNode(geometry: plane)
            // When a plane geometry is created, by default it is oriented vertically
            // so we have to rotate it on X-axis by -90 degrees to
            // make it flat to the image detected
            planeNode.eulerAngles.x = -.pi / 2
            
            createHostingController(for: planeNode)
            
            node.addChildNode(planeNode)
            return node
        } else {
            return nil
        }

    }
    
    func createHostingController(for node: SCNNode) {
        
        // Do this on the main thread
        DispatchQueue.main.async {
            // create a hosting controller with SwiftUI view
            let arVC = UIHostingController(rootView: SampleCardView())
            
            arVC.willMove(toParent: self)
            // make the hosting VC a child to the main view controller
            self.addChild(arVC)
            
            // set the pixel size of the Card View
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
            // add the ar card view as a subview to the main view
            self.view.addSubview(arVC.view)
            
            // render the view on the plane geometry as a material
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<SampleCardView>, on node: SCNNode) {
        // create a new material
        let material = SCNMaterial()
        
        // this allows the card to render transparent parts the right way
        hostingVC.view.isOpaque = false
        
        // set the diffuse of the material to the view of the Hosting View Controller
        material.diffuse.contents = hostingVC.view
        
        // Set the material to the geometry of the node (plane geometry)
        node.geometry?.materials = [material]
        
        hostingVC.view.backgroundColor = UIColor.clear
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

