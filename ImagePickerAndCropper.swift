//
//  ImagePickerAndCropper.swift
//  StrataPanel
//
//  Created by Gaurang on 31/12/24.
//

import SwiftUI
import SwiftyCrop



struct ImagePickerAndCropper<Content: View>: View {
    @StateObject private var viewModel = ViewModel()
    @ViewBuilder let content: () -> Content
    @State private var showPhotoPickerSources = false
    @State private var showImageCropper: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var selectedSource: UIImagePickerController.SourceType = .camera
    let sources: [UIImagePickerController.SourceType]
    let editShape: MaskShape?
    let onSelected: (_ image: UIImage) -> Void
    
    init(
        sources: [UIImagePickerController.SourceType],
        editShape: MaskShape? = nil,
        @ViewBuilder content: @escaping () -> Content,
        onSelected: @escaping (_ image: UIImage) -> Void
    ) {
        self.content = content
        self.sources = sources
        self.editShape = editShape
        self.onSelected = onSelected
    }
    
    var body: some View {
        Button(action: {
            if sources.count > 1 {
                self.showPhotoPickerSources = true
            } else if sources.first == .photoLibrary {
                self.selectedSource = .photoLibrary
                self.showCameraPicker = true
            } else {
                self.selectedSource = .camera
                self.showCameraPicker = true
            }
            
        }, label: {
            content()
        })
        .fullScreenCover(isPresented: $showImageCropper) {
            if let selectedImage = viewModel.selectedImage {
                SwiftyCropView(
                    imageToCrop: selectedImage,
                    maskShape: editShape ?? .circle,
                    configuration: .init(zoomSensitivity: 5)
                ) { croppedImage in
                    if let croppedImage {
                        self.onSelected(croppedImage)
                        viewModel.selectedImage = nil
                    }
                }
            }
        }
        .confirmationDialog("Select Source", isPresented: $showPhotoPickerSources, actions: {
            Button("Camera") {
                self.selectedSource = .camera
                self.showCameraPicker = true
            }
            Button("Photo Library") {
                self.selectedSource = .photoLibrary
                self.showCameraPicker = true
            }
        })
        .fullScreenCover(isPresented: $showCameraPicker) {
            CameraImagePicker(
                sourceType: self.selectedSource,
                allowsEditing: false) { image in
                    if editShape == nil {
                        onSelected(image)
                    } else {
                        viewModel.selectedImage = image
                        DispatchQueue.main.async {
                            self.showImageCropper = true
                        }
                    }
                }
        }
    }
}

extension ImagePickerAndCropper {
    class ViewModel: ObservableObject {
        var selectedImage: UIImage? = nil
    }
}
