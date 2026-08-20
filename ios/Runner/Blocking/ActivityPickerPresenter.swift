import FamilyControls
import SwiftUI
import UIKit

/// FamilyActivityPicker must be presented from native SwiftUI — Flutter only
/// receives an opaque selection id plus counts (iOS never reveals app names).
@available(iOS 16.0, *)
enum ActivityPickerPresenter {
    enum Outcome {
        case picked(selectionId: String, selection: FamilyActivitySelection)
        case cancelled
        case failed(String)
    }

    static func present(
        existingSelectionId: String?,
        completion: @escaping (Outcome) -> Void
    ) {
        DispatchQueue.main.async {
            guard let root = Self.topViewController() else {
                completion(.failed("No view controller to present from"))
                return
            }
            let initial = existingSelectionId.flatMap {
                SharedStore.loadSelection(id: $0)
            } ?? FamilyActivitySelection()

            var finished = false
            let finish: (Outcome) -> Void = { outcome in
                guard !finished else { return }
                finished = true
                root.dismiss(animated: true)
                completion(outcome)
            }

            let view = PickerSheet(
                selection: initial,
                onDone: { selection in
                    let id = existingSelectionId ?? UUID().uuidString
                    do {
                        try SharedStore.saveSelection(selection, id: id)
                        finish(.picked(selectionId: id, selection: selection))
                    } catch {
                        finish(.failed("Failed to persist selection: \(error)"))
                    }
                },
                onCancel: { finish(.cancelled) }
            )
            let host = UIHostingController(rootView: view)
            host.isModalInPresentation = true
            root.present(host, animated: true)
        }
    }

    private static func topViewController() -> UIViewController? {
        let scene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        var top = scene?.windows.first(where: \.isKeyWindow)?.rootViewController
        while let presented = top?.presentedViewController { top = presented }
        return top
    }
}

@available(iOS 16.0, *)
private struct PickerSheet: View {
    @State var selection: FamilyActivitySelection
    let onDone: (FamilyActivitySelection) -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            FamilyActivityPicker(selection: $selection)
                .navigationTitle("Pick the apps that get you")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: onCancel)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { onDone(selection) }
                    }
                }
        }
    }
}
