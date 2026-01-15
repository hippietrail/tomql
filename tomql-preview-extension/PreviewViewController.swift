//
//  PreviewViewController.swift
//  tomql-preview-extension
//
//  Created by Andrew Dunbar on 15/1/2026.
//

import Cocoa
import Quartz

class PreviewViewController: NSViewController, QLPreviewingController {
    @IBOutlet weak var textView: NSTextView?

    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
    }

    func preparePreviewOfFile(at url: URL) async throws {
        do {
            let contents = try String(contentsOf: url, encoding: .utf8)
            DispatchQueue.main.async {
                if let textView = self.textView {
                    textView.string = contents
                    textView.isEditable = false
                    textView.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
                }
            }
        } catch {
            DispatchQueue.main.async {
                if let textView = self.textView {
                    textView.string = "Error reading file: \(error.localizedDescription)"
                    textView.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
                }
            }
        }
    }

}
