/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
 
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import IGListKit

class Comments: NSObject {
    
    static let comments = [
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
        "Aliquam tincidunt mauris eu risus.",
        "Vestibulum auctor dapibus neque.",
        "Nunc dignissim risus id metus.",
        "Cras ornare tristique elit.",
        "Vivamus vestibulum nulla nec ante.",
        "Praesent placerat risus quis eros.",
        "Fusce pellentesque suscipit nibh.",
        "Integer vitae libero ac risus egestas placerat.",
        "Vestibulum commodo felis quis tortor."
    ]
    
    let commentItems: ArraySlice<String>
    
    init(count: Int) {
        self.commentItems = Comments.comments.prefix(count)
    }
    
}

class StackedSectionViewController: UIViewController, IGListAdapterDataSource {

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    lazy var items = [
        "Ryan Olson",
        Comments(count: 2),
        "Oliver Rickard",
        Comments(count: 4),
        "Jesse Squires",
        Comments(count: 10),
        "Ryan Nystrom",
        Comments(count: 8),
        "James Sherlock",
        Comments(count: 6)
    ] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return items as! [IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let comments = object as? Comments {
            var controllers = [IGListSectionController]()
            for item in comments.commentItems {
                let sectionController = LabelSectionController()
                sectionController.object = item
                controllers.append(sectionController)
            }
            return IGListStackedSectionController(sectionControllers: controllers)
        }
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}
