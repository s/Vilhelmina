//
//  SubmissionListInteractor.swift
//  Vilhelmina
//
//  Created by Muhammed Said Özcan on 10/08/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation

protocol SubmissionListInteractorInputProtocol {
    var dataManager: SubmissionListDataManager { get set }
    weak var presenter: SubmissionListPresenter? { get set }
    
    func getTaskforms() -> [ProjectTaskformItem]
    func getTaskformQuestions(projectId:Int, taskformId:Int)
    func getTaskformSubmissions(projectId:Int, taskformId: Int)
}

protocol SubmissionListInteractorOutputProtocol{
    func didReceiveTaskformQuestionsResponse(withSuccess:Bool, taskform:ProjectTaskformItem?, error:NSError?)
    func didReceiveTaskformSubmissionsResponse(withSuccess:Bool, submissions:[ProjectTaskformSubmissionItem]?, error:NSError?)
}

class SubmissionListInteractor: SubmissionListInteractorInputProtocol{
    var dataManager: SubmissionListDataManager
    weak var presenter: SubmissionListPresenter?
    
    init(withDataManager dataManager: SubmissionListDataManager){
        self.dataManager = dataManager
    }
    
    func getTaskforms() -> [ProjectTaskformItem]{
        return dataManager.taskforms
    }
    
    func getTaskformQuestions(projectId:Int, taskformId:Int){
        dataManager.getTaskformQuestions(projectId, taskformId: taskformId)
    }
    
    func getTaskformSubmissions(projectId:Int, taskformId: Int){
        dataManager.getTaskformSubmissions(projectId, taskformId: taskformId)
    }
}

extension SubmissionListInteractor: SubmissionListDataManagerOutputProtocol{
    func didReceiveTaskformQuestionsResponse(withSuccess:Bool, taskform:ProjectTaskformItem?, error:NSError?){
        presenter?.didReceiveTaskformQuestionsResponse(withSuccess, taskform: taskform, error: error)
    }
    
    func didReceiveTaskformSubmissionsResponse(withSuccess:Bool, submissions:[ProjectTaskformSubmissionItem]?, error:NSError?){
        presenter?.didReceiveTaskformSubmissionsResponse(withSuccess, submissions: submissions, error: error)
    }
}
