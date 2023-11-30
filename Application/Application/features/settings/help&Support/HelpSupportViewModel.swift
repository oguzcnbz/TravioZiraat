//
//  HelpSupportViewModel.swift
//  Application
//
//  Created by Ada on 29.11.2023.
//

import Foundation
class HelpSupportViewModel { 
    var cells:[HelpAndSupportModel] = [HelpAndSupportModel(questionLbl: "How can I create a new account on Travio?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How can I create a new account on Travio?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")]
    
    
    func getArr()-> [HelpAndSupportModel]{
        return cells
        
    }
}



