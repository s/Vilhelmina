//
//  SubmissionListView.swift
//  Vilhelmina
//
//  Created by Muhammed Said Özcan on 10/08/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import UIKit

protocol SubmissionListViewProtocol{
    var presenter: SubmissionListPresenter? { get set }
    
    func show(summary summary:String)
}

class SubmissionListView: UIViewController, SubmissionListViewProtocol{
    private let taskformsListSegueIdentifier = "showTaskformsListSegue"
    var presenter: SubmissionListPresenter?
    var chosenProject: ProjectItem?

    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var chooseProjectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectNameLabel.text = chosenProject?.name
        summaryLabel.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == taskformsListSegueIdentifier{
            if let destinationView = segue.destinationViewController as? ProjectTaskformsListView{
                presenter?.didBeginTaskformsListSegue(destinationView)
            }
        }
    }
    
    func show(summary summary: String) {
        if let text = summaryLabel.text {
            summaryLabel.text = text + " " + summary
        }
    }
}

extension SubmissionListView: ProjectTaskformsListViewDelegate{
    func didSelect(item: ProjectTaskformItem) {
        chooseProjectButton.setTitle(item.title, forState: .Normal)
        if let chosenProject = chosenProject {
            presenter?.getTaskformQuestions(chosenProject.id, taskformId: item.id)
            presenter?.getTaskformSubmissions(chosenProject.id, taskformId: item.id)
        }
        print(item)
    }
}

extension SubmissionListView: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}